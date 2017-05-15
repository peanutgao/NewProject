//
//  AppVandersRegisterAssistant.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/8.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "AppVandersRegisterAssistant.h"
#import "WDEnvironmentConfig.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WeiboSDK.h"
#import "UMMobClick/MobClick.h"

@implementation AppVandersRegisterAssistant

+ (void)registerVanders {
    [self registerShareSDK];
    [self registerUMengAnalytics];
    
    //    //注册科大讯飞
    //    [IFlySpeechUtility createUtility:[NSString stringWithFormat:@"appid=%@", kIFlyid]];
    //
}

/// 注册友盟分析
+ (void)registerUMengAnalytics {
    UMConfigInstance.appKey = kUMTrackAppKey;
    UMConfigInstance.channelId = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];
}


/// 注册ShareSDK
+ (void)registerShareSDK {
    [ShareSDK registerApp:kShareSdkAppKey
          activePlatforms:@[
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeCopy),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ)]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:kSinaWeiboAppKey
                                           appSecret:kSinaWeiboAppSecret
                                         redirectUri:KSinaWeiboAppDirectURL
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:kWeixinAppID
                                       appSecret:kWeixinAppSecret];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:kQQAppID
                                      appKey:kQQAppKey
                                    authType:SSDKAuthTypeBoth];
                 break;
             default:
                 break;
         }
     }];
}

@end
