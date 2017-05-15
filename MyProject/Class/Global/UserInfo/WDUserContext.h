//
//  WDUserContext.h
//  MyProject
//
//  Created by Joseph Gao on 2017/5/8.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WDUserModel;

/// 用户数据全局上下文
@interface WDUserContext : NSObject

/// 是否是已经登陆
@property (nonatomic, assign, getter=isLogin) BOOL login;
/// 用户信息数据模型
@property (nonatomic, strong) WDUserModel *userModel;
@property (nonatomic, strong) RACCommand *loadDBUserData;

+ (instancetype)shareContext;

@end


@interface WDUserContext (Deploy)

- (void)deployLoginOutData;
- (void)deployLoginInDataWithUserModel:(WDUserModel *)userModel;

@end
