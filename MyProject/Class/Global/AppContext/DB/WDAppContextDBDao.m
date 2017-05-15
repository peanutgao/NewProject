//
//  WDAppContextDBDao.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/8.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDAppContextDBDao.h"

@implementation WDAppContextDBDao

+ (RACSignal *)saveAppContextConfig:(WDAppConfigModel *)configModel {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        BOOL b = [[WDDBDaoManager shareManager] deleteWithClass:[WDAppConfigModel class] where:nil];
        b = [[WDDBDaoManager shareManager] insertToDB:configModel];
        [subscriber sendNext:@(b)];

        return nil;
    }];
}

+ (WDAppConfigModel *)quaryConfigModel {
    return [[WDDBDaoManager shareManager] searchSingle:[WDAppConfigModel class]
                                                 where:nil
                                               orderBy:nil];
}

@end
