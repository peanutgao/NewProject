//
//  UILabel+Create.h
//  MyProject
//
//  Created by Joseph Gao on 2017/5/1.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Create)

//+ (UILabel *)labelWithText:(NSString *)text inView:(__kindof UIView *)inView;
//
//+ (UILabel *)labelWithText:(NSString *)text
//                  fontSize:(CGFloat)fontSize
//                    inView:(__kindof UIView *)inView;
//
//+ (UILabel *)labelWithText:(NSString *)text
//                 textColor:(UIColor *)textColor
//                  fontSize:(CGFloat)fontSize
//                    inView:(__kindof UIView *)inView;
//
//+ (UILabel *)labelWithText:(NSString *)text
//                 textColor:(UIColor *)textColor
//             textAlignment:(NSTextAlignment)alignment
//                  fontSize:(CGFloat)fontSize
//                    inView:(__kindof UIView *)inView;
//
//+ (UILabel *)labelWithText:(NSString *)text
//                 textColor:(UIColor *)textColor
//                  fontSize:(CGFloat)fontSize
//           backgroundColor:(UIColor *)bgColor
//                    inView:(__kindof UIView *)inView;
//
//+ (UILabel *)labelWithText:(NSString *)text
//                 textColor:(UIColor *)textColor
//             textAlignment:(NSTextAlignment)alignment
//                  fontSize:(CGFloat)fontSize
//           backgroundColor:(UIColor *)bgColor
//                    inView:(__kindof UIView *)inView;

/// 快速创建UILabel对象: text/inView/tapAction
+ (UILabel *)labelWithText:(NSString *)text
                    inView:(__kindof UIView *)inView
                 tapAction:(void(^)(UILabel *label, UIGestureRecognizer *tap))tapAction;

/// 快速创建UILabel对象: text / fontSize / inView / tapAction
+ (UILabel *)labelWithText:(NSString *)text
                  fontSize:(CGFloat)fontSize
                    inView:(__kindof UIView *)inView
                 tapAction:(void(^)(UILabel *label, UIGestureRecognizer *tap))tapAction;

/// 快速创建UILabel对象: text / textColor/ fontSize / inView / tapAction
+ (UILabel *)labelWithText:(NSString *)text
                 textColor:(UIColor *)textColor
                  fontSize:(CGFloat)fontSize
                    inView:(__kindof UIView *)inView
                 tapAction:(void(^)(UILabel *label, UIGestureRecognizer *tap))tapAction;

/// 快速创建UILabel对象: text / textColor / alignment/ fontSize / inView / tapAction
+ (UILabel *)labelWithText:(NSString *)text
                 textColor:(UIColor *)textColor
             textAlignment:(NSTextAlignment)alignment
                  fontSize:(CGFloat)fontSize
                    inView:(__kindof UIView *)inView
                 tapAction:(void(^)(UILabel *label, UIGestureRecognizer *tap))tapAction;

/// 快速创建UILabel对象: text / textColor / fontSize/ bgColor / inView / tapAction
+ (UILabel *)labelWithText:(NSString *)text
                 textColor:(UIColor *)textColor
                  fontSize:(CGFloat)fontSize
           backgroundColor:(UIColor *)bgColor
                    inView:(__kindof UIView *)inView
                 tapAction:(void(^)(UILabel *label, UIGestureRecognizer *tap))tapAction;

/// 快速创建UILabel对象: text / textColor / alignment/ fontSize / bgColor / inView / tapAction
+ (UILabel *)labelWithText:(NSString *)text
                 textColor:(UIColor *)textColor
             textAlignment:(NSTextAlignment)alignment
                  fontSize:(CGFloat)fontSize
           backgroundColor:(UIColor *)bgColor
                    inView:(__kindof UIView *)inView
                 tapAction:(void(^)(UILabel *label, UIGestureRecognizer *tap))tapAction;

@end
