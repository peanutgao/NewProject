//
//  AppDelegateUIAssistant.m
//  MyProject
//
//  Created by Joseph Gao on 2017/4/30.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "AppDelegateUIAssistant.h"
#import "WDNavigationController.h"
#import "WDRootTabBarController.h"

/// 登陆界面控制器
#define LOGIN_VC @"WDLoginViewController"

@implementation AppDelegateUIAssistant

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static AppDelegateUIAssistant *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        [instance initialize];
    });
    return instance;
}

- (void)initialize {
    self->_window = [self keyWindow];
    
    @weakify(self);
    self->_setLoginVCAsRootVCCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        UIViewController *loginVC = [[NSClassFromString(LOGIN_VC) alloc] init];
        self->_rootNavigationController = [self navControllerWithRootViewController:loginVC];
        self->_window.rootViewController = self.rootNavigationController;
        [self->_rootNavigationController setNavigationBarHidden:NO];
        return [RACSignal empty];
    }];
    
    self->_setTabBarVCAsRootVCCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        self->_rootNavigationController = [self navControllerWithRootViewController:[self tabBarController]];
        self->_window.rootViewController = self.rootNavigationController;
        
        [self->_rootNavigationController setNavigationBarHidden:YES];
        return [RACSignal empty];
    }];
}

- (UIWindow *)keyWindow {
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.backgroundColor = [UIColor whiteColor];
    UIViewController *loginVC = [[NSClassFromString(LOGIN_VC) alloc] init];
    self->_rootNavigationController = [self navControllerWithRootViewController:loginVC];
    window.rootViewController = self.rootNavigationController;
    [window makeKeyAndVisible];
    return window;
}

- (__kindof WDNavigationController *)navControllerWithRootViewController:(__kindof UIViewController *)vc {
    if (vc == nil) {
        vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = [UIColor whiteColor];
    }
    return [[WDNavigationController alloc] initWithRootViewController:vc];;
}

- (__kindof UITabBarController *)tabBarController {
    return [[WDRootTabBarController alloc] init];
}

@end
