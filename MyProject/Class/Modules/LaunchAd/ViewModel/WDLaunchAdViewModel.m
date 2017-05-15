//
//  WDLaunchAdViewModel.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/2.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDLaunchAdViewModel.h"

@implementation WDLaunchAdViewModel

- (instancetype)init {
    if (self = [super init]) {
        self->_haveAdImage = NO;
        [self initialize];
    }
    return self;
}

- (void)initialize {
    // 获取缓存图片
    if ([self isHaveLaunchAd]) {
        self->_adImage = [self adImageCache];
        self->_haveAdImage = YES;
    }


    @weakify(self);
    _downloadAdCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        [self downloadAd];
        return [RACSignal empty];
    }];
    
    
    _loadAdCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        UIImage *cache = [self adImageCache];
        self->_adImage = cache;
        if (cache) {
            NSLog(@"获取广告图片成功-------%@", cache);
        } else {
            NSLog(@"获取广告图片失败-------");
        }
        
        return [RACSignal empty];
    }];
    
    _clickAdCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        // TODO: 打开链接
        NSLog(@"TODO: 点击图片跳转链接");
        return [RACSignal empty];
    }];
}

- (void)downloadAd {
    NSUserDefaults *defualts = [NSUserDefaults standardUserDefaults];
    NSDictionary *adInfoDict = [defualts objectForKey:APP_AD_INFO_KEY];
    NSString *imgURL = [WDAppContext shareContext].appConfigModel.adImageURL;
    NSString *openURL = [WDAppContext shareContext].appConfigModel.adURL;

    if (adInfoDict[@"img"] && [adInfoDict[@"img"] isEqualToString:imgURL]) return;

    RACSignal *signal = [WDRequestAdapter downloadImageSignalWithURL:imgURL key:APP_AD_INFO_KEY];
    [signal subscribeNext:^(NSDictionary * _Nullable x) {
        // 下载广告成功: 1. 删除plist中广告标识 2. 重新设置plist中广告标识
        [defualts removeObjectForKey:APP_AD_INFO_KEY];
        
        NSDictionary *dict = @{
                               @"img": imgURL,
                               @"url": openURL
                               };
        [defualts setObject:dict forKey:APP_AD_INFO_KEY];
        [defualts synchronize];
    } error:^(NSError * _Nullable error) {
        NSLog(@"下载广告图片失败");
    } completed:^{
        NSLog(@"下载广告图片完成");
    }];
    
    return;
}

- (BOOL)isHaveLaunchAd {
    NSDictionary *adInfoDict = [[NSUserDefaults standardUserDefaults] objectForKey:APP_AD_INFO_KEY];
    if (!adInfoDict || !adInfoDict[@"img"]) return NO;
    if (![self adImageCache]) return NO;
    
    return YES;
}

- (UIImage *)adImageCache {
    return [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:APP_AD_INFO_KEY];
}

@end
