//
//  AppDelegateUIAssistant.h
//  MyProject
//
//  Created by Joseph Gao on 2017/4/30.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 设置启动UI相关
@interface AppDelegateUIAssistant : NSObject

@property (nonatomic, strong, readonly) UIWindow *window;
@property (nonatomic, strong, readonly) UINavigationController *rootNavigationController;
@property (nonatomic, strong, readonly) RACCommand *setLoginVCAsRootVCCommand;
@property (nonatomic, strong, readonly) RACCommand *setTabBarVCAsRootVCCommand;

+ (instancetype)shareInstance;

@end
