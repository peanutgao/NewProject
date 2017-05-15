//
//  AppPushAssistant.h
//  MyProject
//
//  Created by Joseph Gao on 2017/5/9.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, AppPushStatus) {
    AppPushStatusOn,
    AppPushStatusOff,
};

@interface AppPushAssistant : NSObject

/// 推送状态
@property (nonatomic, assign) AppPushStatus pushStatus;
@property (nonatomic, strong) RACCommand *pushStatusCommand;

/// 推送使用单例
+ (instancetype)shareAssistant;

/// 注册推送SDK
- (void)registerPushSDK;

- (void)hookDidFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

- (void)hookDidRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
- (void)hookDidFailToRegisterForRemoteNotificationsWithError:(NSError *)error;
- (void)hookDidReceiveRemoteNotification:(NSDictionary *)userInfo;
- (void)hookDidReceiveRemoteNotification:(NSDictionary *)userInfo
                  fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler;


@end


@interface AppPushAssistant (Request);

- (RACSignal *)signalOfBindAlias;
- (RACSignal *)signalOfUnbindAlias;

@end
