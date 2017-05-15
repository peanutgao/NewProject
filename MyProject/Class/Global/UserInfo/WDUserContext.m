//
//  WDUserContext.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/8.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDUserContext.h"
#import "WDUserModel.h"

@implementation WDUserContext

+ (instancetype)shareContext {
    static dispatch_once_t onceToken;
    static WDUserContext *instance = nil;

    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        [instance initialize];
    });
    return instance;
}

- (void)initialize {
    self.userModel = [[WDUserModel alloc] init];
    
    @weakify(self);
    self.loadDBUserData = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        id model = [[WDDBDaoManager shareManager] searchSingle:[WDUserModel class] where:nil orderBy:nil];
        self.userModel = model;
        return [RACSignal empty];
    }];
    
}

@end


@implementation WDUserContext (Deploy)

- (void)deployLoginOutData {
    WDDBDaoManager *mgr = [WDDBDaoManager shareManager];
    BOOL b = [mgr deleteWithClass:[WDUserModel class] where:nil];
    b = [mgr deleteWithClass:[WDUserInfoModel class] where:nil];
}

- (void)deployLoginInDataWithUserModel:(WDUserModel *)userModel {
    self.userModel = userModel;
    [self deployLoginOutData];
    [[WDDBDaoManager shareManager] insertToDB:userModel];
}



@end
