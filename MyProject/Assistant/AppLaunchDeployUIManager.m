//  AppLaunchDeployUIManager.m
//  MyProject
//
//
//  Created by Joseph Gao on 2017/5/2.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "AppLaunchDeployUIManager.h"
#import "AppDelegateUIAssistant.h"
#import "WDSplashViewManager.h"
#import "WDLaunchAdViewMananger.h"

@interface AppLaunchDeployUIManager ()

@end


@implementation AppLaunchDeployUIManager


- (UIWindow *)deployUI {
    AppDelegateUIAssistant *assistant = [AppDelegateUIAssistant shareInstance];
    WDAppContext *context = [WDAppContext shareContext];
    
    // 1. 默认启动是root是LoginVC, 如果登陆了设置为tabbarVC
    if ([WDUserContext shareContext].isLogin) {
        [assistant.setTabBarVCAsRootVCCommand execute:@1];
    }
    
#warning Test
    [assistant.setTabBarVCAsRootVCCommand execute:@1];
    // 2. 检查是否需要显示指导页
    if (context.isNeedShowGuiderView) {
        [[[WDSplashViewManager alloc] init].showCommand execute:@1];
    }
    // 3. 检查是否需要显示广告
    [self checkIsCanShowAd];
    // 4. 下载全局接口信息
    [context.latestConfigCommand execute:@1];
    // 5. 记录保存的版本号
    [context.saveVersionCommand execute:@1];

    return assistant.window;
}

/// 执行显示广告操作
- (void)checkIsCanShowAd {
    WDLaunchAdViewMananger *adViewMgr = [[WDLaunchAdViewMananger alloc] init];
    // 如果本地有缓存广告显示广告
    if (adViewMgr.isHaveAdImage) [adViewMgr.showAdCommand execute:@1];
    // 后台异步下载广告
    [adViewMgr.downloadAdCommand execute:@1];
}

@end
