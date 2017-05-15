//
//  WDAppContext.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/2.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#define USER_DEFAULT_LAST_VERSION_KEY @"USER_DEFAULT_LAST_VERSION_KEY"

#import "WDAppContext.h"
#import "WDAppContextRequester.h"
#import "WDVersionCompare.h"

@interface WDAppContext ()

@property (nonatomic, strong) WDAppContextRequester *requester;

@end

@implementation WDAppContext

+ (instancetype)shareContext {
    static dispatch_once_t onceToken;
    static WDAppContext *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[WDAppContext alloc] init];
        [instance initialize];
    });
    return instance;
}

- (void)initialize {
    self.requester = [[WDAppContextRequester alloc] init];
    
    @weakify(self);
    self.latestConfigCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            @strongify(self);
            [[self databaseSignal] subscribeNext:^(id  _Nullable x) {
                [subscriber sendNext:x];
                [subscriber sendCompleted];
                
            } error:^(NSError * _Nullable error) {
                [subscriber sendError:error];
                [subscriber sendCompleted];
                
            } completed:^{
                @strongify(self);
                // 获取本地app配置数据无论成败都拉去最新的配置
                [self.requester.downloadLatestDataCommand execute:@1];
            }];
            
            return nil;
        }];
    }];
    
    
    self.saveVersionCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        if (APP_VERSION) {
            [[NSUserDefaults standardUserDefaults] setObject:APP_VERSION
                                                      forKey:USER_DEFAULT_LAST_VERSION_KEY];
        }
        return [RACSignal empty];
    }];
    
#warning Test Data
    WDAppConfigModel *m = [[WDAppConfigModel alloc] init];
    m.adImageURL =  @"http://media.idownloadblog.com/wp-content/uploads/2016/06/iOS10-wallpaper-iPhone6.png";
    m.adURL = @"www.baidu.com";
    self.appConfigModel = m;

}


- (RACSignal *)databaseSignal {
    @weakify(self);
    RACSignal *s = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self);
        [[self.requester.loadDBDataCommand execute:@1]
         subscribeNext:^(id  _Nullable x) {
            [subscriber sendNext:x];
            [subscriber sendCompleted];
        }
         error:^(NSError * _Nullable error) {
            [subscriber sendError:error];
            [subscriber sendCompleted];
         }];

        return nil;
    }];
    
    return s;
}

- (BOOL)isNeedShowGuiderView {
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULT_LAST_VERSION_KEY];
    BOOL b = NO;
    if (lastVersion == nil || compareVersion([APP_VERSION UTF8String], [lastVersion UTF8String]) == 1) {
        return YES;
    }
    return b;
}



@end
