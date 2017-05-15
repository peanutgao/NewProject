//
//  WDLoadingHUD.h
//  MyProject
//
//  Created by Joseph Gao on 2017/5/11.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 加载指示器类
@interface WDLoadingHUD : NSObject


/// 在视图中显示指示器, inView设置成 控制器的view, 可以操作导航栏返回按钮
+ (void)showInView:(UIView *)inView;

/**
 在视图中显示指示器, inView设置成 控制器的view, 可以操作导航栏返回按钮

 @param inView 添加到哪个view中显示
 @param title 显示的标题
 */
+ (void)showInView:(UIView *)inView withTitle:(NSString *)title;


/// 隐藏HUD
+ (void)hiddenInView:(UIView *)inView;

/// 显示指示器, HUD添加在window上面, 导航栏 `不可` 操作
/// 隐藏操作要用 + (void)hiddenIndeterminate;
+ (void)showIndeterminate;

/// 隐藏HUD
+ (void)hiddenIndeterminate;

/// 显示提示信息, 1.5秒后消失
+ (void)showTips:(NSString *)tips;

@end
