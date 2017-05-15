//
//  WDEnvironmentConfig.h
//  MyProject
//
//  Created by Joseph Gao on 2017/5/8.
//  Copyright © 2017年 Joseph. All rights reserved.
//

/// 环境配置, 对于不同的环境, 第三方 Key 可能不一样


#import <UIKit/UIKit.h>


//--------------------------------第三方key--------------------------------------
#pragma mark - Vander Key

/// 七牛
UIKIT_EXTERN NSString *const kQiniuURL;
/// 友盟
UIKIT_EXTERN NSString *const kUMTrackAppKey;
/// shareSDK
UIKIT_EXTERN NSString *const kShareSdkAppKey;
/// 科大讯飞
UIKIT_EXTERN NSString *const kIFlyid;
/// 新浪微博 appKey
UIKIT_EXTERN NSString *const kSinaWeiboAppKey;
/// 新浪微博 appSecret
UIKIT_EXTERN NSString *const kSinaWeiboAppSecret;
/// 新浪微博 跳转URL
UIKIT_EXTERN NSString *const KSinaWeiboAppDirectURL;
/// 微信 appID
UIKIT_EXTERN NSString *const kWeixinAppID;
/// 微信 appSecret
UIKIT_EXTERN NSString *const kWeixinAppSecret;
/// QQ appID
UIKIT_EXTERN NSString *const kQQAppID;
/// QQ appSecret
UIKIT_EXTERN NSString *const kQQAppKey;
/// 个推 appID
UIKIT_EXTERN NSString *const kGeTuiSdkAppID;
/// 个推 appKey
UIKIT_EXTERN NSString *const kGeTuiSdkAppKey;
/// 个推 appSecret
UIKIT_EXTERN NSString *const kGeTuiSdkAppSecret;


//--------------------------------市民云key--------------------------------------
#pragma mark - 市民云 Key

/// 市民云 OAuthor ClientId
UIKIT_EXTERN NSString *const kResidentOAuthorClientId;
/// 市民云 OAuthor appSecret
UIKIT_EXTERN NSString *const kResidentOAuthorClientSecret;
/// 市民云 OAuthor 重定向URL
UIKIT_EXTERN NSString *const kResidentOAuthorClientRedirectURL;
