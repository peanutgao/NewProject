//
//  YSMediator.h
//  Mediator
//
//  Created by Joseph Gao on 2017/4/6.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface YSMediator : NSObject

/**
 push方式展现控制器
 
 @param tCName push到的控制器类名字符串
 @param params 传递的参数字典, 注意: key要和push到的控制器接口的参数名一致
 @param flag push时是否显示动画
 @param callBack push完成后回调
 */
+ (void)pushViewControllerClassName:(NSString *)VCClassName
                    withParams:(NSDictionary *)params
                      animated:(BOOL)flag
                      callBack:(void(^)(void))callBack;


/**
 present方式展现控制器
 
 @param tCName present到的控制器类名字符串
 @param params 传递的参数字典, 注意: key要和push到的控制器接口的参数名一致
 @param flag present时是否显示动画
 @param callBack present完成后回调
 */
+ (void)presentViewControllerClassName:(NSString *)VCClassName
                            withParams:(NSDictionary *)params
                              animated:(BOOL)flag
                              callBack:(void(^)(void))callBack;
@end
