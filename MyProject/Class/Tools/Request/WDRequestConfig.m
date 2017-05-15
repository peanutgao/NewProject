//
//  WDRequestConfig.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/2.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDRequestConfig.h"

@implementation WDRequestConfig

/// 环境配置预编译宏:
/// ETEST : 测试环境
/// ERELEASE : 正式环境
/// EPRERE : 预发布环境
/// EDEVELOPMENT : 开发环境

//--------------------------------Base URL--------------------------------------
#pragma mark - Base URL

/// 服务器Base URL
NSString *const kServerBaseURL = @"http://101.230.192.74/neohealthcloud-user-te/api";
/// H5页面BaseURL
NSString *const kH5BaseURL = @"http://10.1.64.194/neohealthcloud-app-h5/";

@end
