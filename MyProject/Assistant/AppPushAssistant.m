//
//  AppPushAssistant.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/9.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "AppPushAssistant.h"
#import "WDRequestAdapter.h"
#import "GeTuiSdk.h"

@interface AppPushAssistant () <GeTuiSdkDelegate>

@property (nonatomic, copy) NSString *clientId;

@end


@implementation AppPushAssistant

#pragma mark - Init

+ (instancetype)shareAssistant {
    static dispatch_once_t onceToken;
    static AppPushAssistant *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        [instance initialize];
    });
    return instance;
}

- (void)initialize {    
    @weakify(self);
    // 本地PList里面没有字段, 设置字段为yes
    NSNumber *status = [APP_USERDEFAULTS objectForKey:USER_DEFAULT_PUSH_STATUS];
    if (status == nil) [self savePushStatusToLocal:@1];

    // 推送状态命令创建
    self.pushStatusCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        [self savePushStatusToLocal:input];
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:input];
            [subscriber sendCompleted];
            
            return nil;
        }];
    }];
    
    
    // 监听推送状态
    [[RACObserve(self, pushStatus) distinctUntilChanged] subscribeNext:^(id  _Nullable x) {
        [GeTuiSdk setPushModeForOff:[x boolValue]];
    }];
    
    
    // 监听用户登陆状态的改变来绑定/解绑个推别名
    [[RACObserve([WDUserContext shareContext], isLogin) distinctUntilChanged]
     subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if ([x boolValue]) {
            [self bindAlias];
        } else {
            [self unbindAlias];
        }
    }];
}


- (void)bindAlias {
    [[self signalOfBindAlias] subscribeNext:^(id  _Nullable x) {
    }];
}

- (void)unbindAlias {
    [[self signalOfUnbindAlias] subscribeNext:^(id  _Nullable x) {
    }];
}

- (void)savePushStatusToLocal:(NSNumber *)status {
    NSNumber *r = status == nil ? @1 : @0;
    [APP_USERDEFAULTS setObject:r forKey:USER_DEFAULT_PUSH_STATUS];
    self.pushStatus = [r integerValue];
}


#pragma mark - Register

/// 注册推送SDK
- (void)registerPushSDK {
    // 通过 appId、 appKey 、appSecret 启动SDK，注：该方法需要在主线程中调用
    [GeTuiSdk startSdkWithAppId:kGeTuiSdkAppID
                         appKey:kGeTuiSdkAppKey
                      appSecret:kGeTuiSdkAppSecret
                       delegate:self];
    [GeTuiSdk runBackgroundEnable:NO];
}


#pragma mark - Hook Method

- (void)hookDidFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 判读系统版本是否是“iOS 8.0”以上
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ||
        [UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
        
        // 定义用户通知类型(Remote.远程 - Badge.标记 Alert.提示 Sound.声音)
        UIUserNotificationType types = UIUserNotificationTypeAlert |
                                       UIUserNotificationTypeBadge |
                                       UIUserNotificationTypeSound;
        // 定义用户通知设置
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        
        // 注册用户通知 - 根据用户通知设置
        [SHARED_APPLICATION registerUserNotificationSettings:settings];
        [SHARED_APPLICATION registerForRemoteNotifications];
    }
    else { // iOS8.0 以前远程推送设置方式
        // 定义远程通知类型(Remote.远程 - Badge.标记 Alert.提示 Sound.声音)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge |
                                           UIRemoteNotificationTypeAlert |
                                           UIRemoteNotificationTypeSound;
        // 注册远程通知 -根据远程通知类型
        [SHARED_APPLICATION registerForRemoteNotificationTypes:myTypes];
#pragma clang diagnostic pop
    }
}

- (void)hookDidRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"\n>>>[DeviceToken Success]:%@\n\n", token);
   
    [GeTuiSdk registerDeviceToken:token];
}

- (void)hookDidFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
}

- (void)hookDidReceiveRemoteNotification:(NSDictionary *)userInfo {
    SHARED_APPLICATION.applicationIconBadgeNumber = 0;
}

- (void)hookDidReceiveRemoteNotification:(NSDictionary *)userInfo
                  fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    if (SHARED_APPLICATION.applicationState == UIApplicationStateBackground) return;
    
    NSString *contentStr = [userInfo objectForKey:@"content"];
    if (contentStr.length > 0) {
        NSDictionary *contentDic = [contentStr mj_JSONObject];
        if (contentDic) {
//            PushModel *push = [PushModel mj_objectWithKeyValues:contentDic];
//            if (push) {
//                [[PushManager manager] addPushModel:push];
//            }
        }
    }
    
//    [[PushManager manager] handelPushFromBackGround:(application.applicationState != UIApplicationStateActive)];
    
    completionHandler(UIBackgroundFetchResultNewData);
}


@end



@implementation AppPushAssistant (Request)

- (RACSignal *)signalOfBindAlias {
    NSDictionary *params = @{
                             @"uid": [WDUserContext shareContext].userModel.uid ?: @"",
                             @"cid": self.clientId ?: @""
                             };
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        RACSignal *s = [WDRequestAdapter requestSignalWithURL:API_BIND_ALIAS
                                                       params:params
                                                  requestType:WDRequestTypePOST
                                                 responseType:WDResponseTypeObject
                                                responseClass:nil];
        [s subscribeNext:^(WDResponseModel * _Nullable x) {
            NSString *alias = [x.data objectForKey:@"alias"];
            [subscriber sendNext:alias];
            [subscriber sendCompleted];
            NSLog(@"绑定别名成功");
            
        } error:^(NSError * _Nullable error) {
            [subscriber sendError:error];
            [subscriber sendCompleted];
            NSLog(@"绑定别名失败");
        }];
        
        return nil;
    }];
}

- (RACSignal *)signalOfUnbindAlias {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        RACSignal *s = [WDRequestAdapter requestSignalWithURL:API_UNBIND_ALIAS
                                                       params:@{@"uid": [WDUserContext shareContext].userModel.uid}
                                                  requestType:WDRequestTypePOST
                                                 responseType:WDResponseTypeObject
                                                responseClass:nil];
        [s subscribeNext:^(WDResponseModel * _Nullable x) {
            [subscriber sendNext:@1];
            [subscriber sendCompleted];
            NSLog(@"解除别名成功");
            
        } error:^(NSError * _Nullable error) {
            [subscriber sendError:error];
            [subscriber sendCompleted];
            NSLog(@"解除别名失败");
        }];
        
        return nil;
    }];
}

@end











