//
//  WDRootTabBarViewModel.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/10.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDRootTabBarViewModel.h"
#import "WDNavigationController.h"

#define APP_TABBAR_IMAGE_KEY @"APP_TABBAR_IMAGE_KEY"            // tabbar图片存储key

@interface WDRootTabBarViewModel ()

@property (nonatomic, strong) RACCommand *downloadCommand;
@property (nonatomic, copy) NSString *bcImgURL;

@end


@implementation WDRootTabBarViewModel

- (instancetype)init {
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    @weakify(self);
    self.configVCSignal = [[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self);
        [subscriber sendNext:[self configControllers]];
        [subscriber sendCompleted];
        return nil;
    }] finally:^{
        @strongify(self);
        [self.downloadCommand execute:@1];
    }];
    
    
    self.bgImageSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        UIImage *img = [UIImage imageNamed:@""];
        NSDictionary *cacheInfo = [self tabbarImageCacheInfo];
        NSString *key = cacheInfo[@"bg"];
        UIImage *cache = [[SDImageCache sharedImageCache] imageFromCacheForKey:key];
        
        if (cache) img = cache;
        [subscriber sendNext:img];
        [subscriber sendCompleted];
        
        return nil;
    }];
    
    
    self.downloadCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        RACSignal *s = [WDRequestAdapter requestSignalWithURL:APP_TAB_BAR_IMAGES
                                                       params:nil
                                                  requestType:WDRequestTypeGET
                                                 responseType:WDResponseTypeObject
                                                responseClass:nil];
        [[[[[s
             map:^id _Nullable(WDResponseModel * _Nullable value) {
                 return value.data;
             }]
            filter:^BOOL(NSArray * _Nullable value) {
                return [value isKindOfClass:[NSArray class]] && value.count == 11;
            }]
           doNext:^(id  _Nullable x) {
               @strongify(self);
               // 下载图片,缓存到磁盘
               [self cacheImages:x];
           }]
          map:^id _Nullable(NSArray * _Nullable value) {
              // 导航图标 0-背景,1~4-非高亮,5~8-高亮
              NSMutableArray *nArrayM = [NSMutableArray arrayWithCapacity:5];
              NSMutableArray *sArrayM = [NSMutableArray arrayWithCapacity:5];
              [value enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                  if (idx == 0) return;
                  if (idx < value.count/2.0) {
                      [nArrayM addObject:obj];
                  } else {
                      [sArrayM addObject:obj];
                  }
              }];
              
              return @{
                       @"bg"    : value[0],
                       @"icon"  : @{
                                    @"normal"  : nArrayM,
                                    @"selected": sArrayM,
                                   }
                       };
          }]
         subscribeNext:^(id  _Nullable x) {
             @strongify(self);
             // 保存图片信息
             [self saveInfo:x];
         } error:^(NSError * _Nullable error) {
             NSLog(@"获取底部tabbar图片失败:%@", error);
         }];
        
        return [RACSignal empty];
    }];
    
}

- (void)cacheImages:(NSArray *)images {
    [images enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        RACSignal *s = [WDRequestAdapter downloadImageSignalWithURL:obj key:obj];
        [s subscribeNext:^(id  _Nullable x) {
            
        } error:^(NSError * _Nullable error) {
            
        }];
    }];
}

- (NSArray *)configControllers {
    NSDictionary *cache = [self tabbarImageCacheInfo];
    NSDictionary *cacheInfo = cache[@"icon"];
    self.bcImgURL = cache[@"bg"];
    NSString *configPath = [[NSBundle mainBundle] pathForResource:@"TabbarConfig.json" ofType:nil];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:configPath]
                                                     options:NSJSONReadingMutableContainers
                                                       error:nil];
    __block NSMutableArray *controllers = [NSMutableArray arrayWithCapacity:array.count];
    
    [array enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImage *normalImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_n", obj[@"img"]]];
        UIImage *selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_s", obj[@"img"]]];
        
        // 有缓存设置缓存
        if (cache && cacheInfo) {
            NSString *nStr = cacheInfo[@"normal"][idx];
            NSString *sStr = cacheInfo[@"selected"][idx];
            UIImage *normalImgCache = [[SDImageCache sharedImageCache] imageFromCacheForKey:nStr];
            UIImage *selectedImgCache = [[SDImageCache sharedImageCache] imageFromCacheForKey:sStr];
            
            // 重新设置图片尺寸, 约定是缩小3倍
            CGFloat scale = 3.0;
            if (normalImgCache) normalImage = [UIImage imageWithCGImage:normalImgCache.CGImage
                                                                  scale:scale
                                                            orientation:normalImgCache.imageOrientation];
            if (normalImgCache) selectedImage = [UIImage imageWithCGImage:selectedImgCache.CGImage
                                                                    scale:scale
                                                              orientation:selectedImgCache.imageOrientation];
        }
        
        UIViewController *vc = [self viewControllerWithControllerClassString:obj[@"vcName"]
                                                                       title:obj[@"title"]
                                                       tabBarItemNormalImage:normalImage
                                                               selectedImage:selectedImage];
        [controllers addObject:vc];
    }];
    
    return controllers;
}


- (__kindof UIViewController *)viewControllerWithControllerClassString:(NSString *)classStr
                                                                 title:(NSString *)title
                                                 tabBarItemNormalImage:(UIImage *)normalImage
                                                         selectedImage:(UIImage *)selectedImage {
    if (classStr == nil || [classStr isEqualToString:@""]) {
        classStr = @"UIViewController";
    }
    
    UIViewController *vc = [[NSClassFromString(classStr) alloc] init];
    vc.title = title;
    WDNavigationController *nav = [[WDNavigationController alloc] initWithRootViewController:vc];
    //nav.tabBarItem.badgeValue = @"99";
    nav.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, 100);
    nav.tabBarItem.imageInsets = UIEdgeInsetsMake(8, 0, -8, 0);
    [nav.tabBarItem setSelectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [nav.tabBarItem setImage:[normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    return nav;
}

- (void)saveInfo:(NSDictionary *)info {
    if (info == nil || ![info isKindOfClass:[NSDictionary class]]) return;
    [APP_USERDEFAULTS removeObjectForKey:APP_TABBAR_IMAGE_KEY];
    [APP_USERDEFAULTS setObject:info forKey:APP_TABBAR_IMAGE_KEY];
}


- (NSDictionary *)tabbarImageCacheInfo {
    return [APP_USERDEFAULTS objectForKey:APP_TABBAR_IMAGE_KEY];
}

@end
