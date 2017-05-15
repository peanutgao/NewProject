//
//  WDUserModel.h
//  MyProject
//
//  Created by Joseph Gao on 2017/5/8.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDBaseModel.h"

@class WDUserInfoModel;

/// 用户数据模型
@interface WDUserModel : WDBaseModel

@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *token;


@property (nonatomic, strong) WDUserInfoModel *info;

@end
