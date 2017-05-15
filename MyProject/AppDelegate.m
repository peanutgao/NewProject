//
//  AppDelegate.m
//  MyProject
//
//  Created by Joseph Gao on 2017/4/30.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "AppDelegate.h"
#import "AppLaunchDeployUIManager.h"
#import "AppVandersRegisterAssistant.h"
#import "AppPushAssistant.h"

@interface AppDelegate ()

@property (nonatomic, strong) AppLaunchDeployUIManager *launchDeployUIManager;

@end

@implementation AppDelegate



#pragma mark - Life Circle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [YSNurse shareInstance].debugEnable = YES;
    
    // 监听网络
    [[WDNetworkTools shareTools] startMonitoring];
    // 加载用户本地数据
    [[WDUserContext shareContext].loadDBUserData execute:@1];
    // 部署UI
    self.launchDeployUIManager = [[AppLaunchDeployUIManager alloc] init];
    self.window = [self.launchDeployUIManager deployUI];
    // 注册第三方SDK
    [AppVandersRegisterAssistant registerVanders];
    // 远程推送
    [[AppPushAssistant shareAssistant] registerPushSDK];
    [[AppPushAssistant shareAssistant] hookDidReceiveRemoteNotification:launchOptions];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - Notification

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[AppPushAssistant shareAssistant] hookDidRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}


- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [[AppPushAssistant shareAssistant] hookDidFailToRegisterForRemoteNotificationsWithError:error];
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [[AppPushAssistant shareAssistant] hookDidReceiveRemoteNotification:userInfo];
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [[AppPushAssistant shareAssistant] hookDidReceiveRemoteNotification:userInfo
                                                 fetchCompletionHandler:completionHandler];
}


@end
