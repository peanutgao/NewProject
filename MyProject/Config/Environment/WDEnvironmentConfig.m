//
//  WDEnvironmentConfig.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/8.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 环境配置预编译宏:
/// ETEST : 测试环境
/// ERELEASE : 正式环境
/// EPRERE : 预发布环境
/// EDEVELOPMENT : 开发环境


//--------------------------------第三方key--------------------------------------
#pragma mark - Vander Key

/// 七牛
NSString *const kQiniuURL = @"http://o99kne90l.qnssl.com";
/// 友盟
NSString *const kUMTrackAppKey = @"5590b4b167e58e8e03003d5f";
/// shareSDK
NSString *const kShareSdkAppKey = @"101bfe3ea948c";
/// 科大讯飞
NSString *const kIFlyid = @"55b0ac4a";
/// 新浪微博 appKey
NSString *const kSinaWeiboAppKey = @"3120117176";
/// 新浪微博 appSecret
NSString *const kSinaWeiboAppSecret = @"a9afafcbf05ac5806230781849f79ced";
/// 新浪微博 跳转URL
NSString *const KSinaWeiboAppDirectURL = @"http://www.wdjky.com/healthcloud/";
/// 微信 appID
NSString *const kWeixinAppID = @"wxc5531bfa8f35c45a";
/// 微信 appSecret
NSString *const kWeixinAppSecret = @"b7a9926114e69061121eb96b88d43840";
/// QQ appID
NSString *const kQQAppID = @"1104735148";
/// QQ appSecret
NSString *const kQQAppKey = @"gShPEDi5QJqdzO49";
/// 个推 appID
NSString *const kGeTuiSdkAppID = @"OCayARRsi39MgchgX1hPo6";
/// 个推 appKey
NSString *const kGeTuiSdkAppKey = @"jh3Tfp3au69APHqVb19QM3";
/// 个推 appSecret
NSString *const kGeTuiSdkAppSecret = @"n3k9BRUm9m8QLCVTyzJLC9";


//--------------------------------市民云key--------------------------------------
#pragma mark - 市民云 Key

/// 市民云 OAuthor ClientId
NSString *const kResidentOAuthorClientId = @"5i3BycPXEf";
/// 市民云 OAuthor appSecret
NSString *const kResidentOAuthorClientSecret = @"H7zW0AxZGl4NskHTnHPd7vpQvtB5N3Moc3SImhxL";
/// 市民云 OAuthor 重定向URL
NSString *const kResidentOAuthorClientRedirectURL = @"http://testh5.eshimin.com/";
