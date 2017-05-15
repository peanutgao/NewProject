//
//  WDAppContextRequester.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/5.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDAppContextRequester.h"
#import "WDRequestAdapter.h"
#import "WDAppContextDBDao.h"

@implementation WDAppContextRequester

- (instancetype)init {
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    @weakify(self);
    self.loadDBDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            @strongify(self);
            WDAppConfigModel *model = [self loadDataBaseAppConfig];
            if (model) {
                [subscriber sendNext:model];
            }
            else {
                NSInteger code = 1024;
                NSDictionary *errorInfo = @{
                                            NSLocalizedDescriptionKey : @"获取数据库数据失败",
                                            NSLocalizedFailureReasonErrorKey : [NSNumber numberWithInteger:code]
                                            };
                NSError *error = [NSError errorWithDomain:ERROR_DOMAIN code:code userInfo:errorInfo];
                [subscriber sendError:error];
            }
            
            [subscriber sendCompleted];
            
            return [RACDisposable disposableWithBlock:^{
                NSLog(@"----------获取本地数据库App配置文件结束----------");
            }];
        }];
        
        return [RACSignal empty];
    }];
    
    
    self.downloadLatestDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [WDRequestAdapter requestSignalWithURL:nil
                                               params:nil
                                          requestType:WDRequestTypeGET
                                         responseType:WDResponseTypeObject
                                        responseClass:[WDAppConfigModel class]];
    }];
    
    [[self.downloadLatestDataCommand.executionSignals switchToLatest]
     subscribeNext:^(id  _Nullable x) {
         NSLog(@"------全局接口数据下载完成------");
         WDAppContext *appContext = [WDAppContext shareContext];
         appContext.appConfigModel = x;
     }
     error:^(NSError * _Nullable error) {
         NSLog(@"------全局接口数据下载失败------>error: %@", error);
     }
     completed:^{
         NSLog(@"------全局接口数据下载结束------");
     }];
}

- (WDAppConfigModel *)loadDataBaseAppConfig {
    return [WDAppContextDBDao quaryConfigModel];
}

@end
