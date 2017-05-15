//
//  UILabel+Create.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/1.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "UILabel+Create.h"

@implementation UILabel (Create)

//+ (UILabel *)labelWithText:(NSString *)text inView:(__kindof UIView *)inView {
//    return [self labelWithText:text
//                     textColor:[UIColor blackColor]
//                      fontSize:14.0
//               backgroundColor:[UIColor whiteColor]
//                        inView:inView];
//}
//
//+ (UILabel *)labelWithText:(NSString *)text
//                  fontSize:(CGFloat)fontSize
//                    inView:(__kindof UIView *)inView {
//    return [self labelWithText:text
//                     textColor:[UIColor blackColor]
//                      fontSize:fontSize
//               backgroundColor:[UIColor whiteColor]
//                        inView:inView];
//}
//
//+ (UILabel *)labelWithText:(NSString *)text
//                 textColor:(UIColor *)textColor
//                  fontSize:(CGFloat)fontSize
//                    inView:(__kindof UIView *)inView {
//    return [self labelWithText:text
//                     textColor:textColor
//                      fontSize:fontSize
//               backgroundColor:[UIColor whiteColor]
//                        inView:inView];
//}
//
//+ (UILabel *)labelWithText:(NSString *)text
//                 textColor:(UIColor *)textColor
//             textAlignment:(NSTextAlignment)alignment
//                  fontSize:(CGFloat)fontSize
//                    inView:(__kindof UIView *)inView {
//    return [self labelWithText:text
//                     textColor:textColor
//                 textAlignment:alignment
//                      fontSize:fontSize
//               backgroundColor:[UIColor whiteColor]
//                        inView:inView];
//}
//
//+ (UILabel *)labelWithText:(NSString *)text
//                 textColor:(UIColor *)textColor
//                  fontSize:(CGFloat)fontSize
//           backgroundColor:(UIColor *)bgColor
//                    inView:(__kindof UIView *)inView {
//    return [self labelWithText:text
//                     textColor:textColor
//                 textAlignment:NSTextAlignmentNatural
//                      fontSize:fontSize
//               backgroundColor:[UIColor whiteColor]
//                        inView:inView];
//}
//
//+ (UILabel *)labelWithText:(NSString *)text
//                 textColor:(UIColor *)textColor
//             textAlignment:(NSTextAlignment)alignment
//                  fontSize:(CGFloat)fontSize
//           backgroundColor:(UIColor *)bgColor
//                    inView:(__kindof UIView *)inView {
//    if (textColor == nil) textColor = [UIColor blackColor];
//    if (fontSize <= 0) fontSize = 14.0;
//    if (bgColor == nil) bgColor = [UIColor clearColor];
//    
//    UILabel *label = [[UILabel alloc] init];
//    label.text = text;
//    label.textColor = textColor;
//    label.backgroundColor = bgColor;
//    label.textAlignment = alignment;
//    label.font = [UIFont systemFontOfSize:fontSize];
//    [label sizeToFit];
//    
//    if (inView && [inView isKindOfClass:[UIView class]]) {
//        [inView addSubview:label];
//    }
//    return label;
//}


+ (UILabel *)labelWithText:(NSString *)text
                    inView:(__kindof UIView *)inView
                 tapAction:(void(^)(UILabel *label, UIGestureRecognizer *tap))tapAction {
    return [self labelWithText:text
                     textColor:[UIColor blackColor]
                      fontSize:14.0
               backgroundColor:[UIColor whiteColor]
                        inView:inView
                     tapAction:tapAction];
}

+ (UILabel *)labelWithText:(NSString *)text
                  fontSize:(CGFloat)fontSize
                    inView:(__kindof UIView *)inView
                 tapAction:(void(^)(UILabel *label, UIGestureRecognizer *tap))tapAction {
    return [self labelWithText:text
                     textColor:[UIColor blackColor]
                      fontSize:fontSize
               backgroundColor:[UIColor whiteColor]
                        inView:inView
                     tapAction:tapAction];
}

+ (UILabel *)labelWithText:(NSString *)text
                 textColor:(UIColor *)textColor
                  fontSize:(CGFloat)fontSize
                    inView:(__kindof UIView *)inView
                 tapAction:(void(^)(UILabel *label, UIGestureRecognizer *tap))tapAction {
    return [self labelWithText:text
                     textColor:textColor
                      fontSize:fontSize
               backgroundColor:[UIColor whiteColor]
                        inView:inView
                     tapAction:tapAction];
}

+ (UILabel *)labelWithText:(NSString *)text
                 textColor:(UIColor *)textColor
             textAlignment:(NSTextAlignment)alignment
                  fontSize:(CGFloat)fontSize
                    inView:(__kindof UIView *)inView
                 tapAction:(void(^)(UILabel *label, UIGestureRecognizer *tap))tapAction {
    return [self labelWithText:text
                     textColor:textColor
                 textAlignment:alignment
                      fontSize:fontSize
               backgroundColor:[UIColor whiteColor]
                        inView:inView
                     tapAction:tapAction];
}

+ (UILabel *)labelWithText:(NSString *)text
                 textColor:(UIColor *)textColor
                  fontSize:(CGFloat)fontSize
           backgroundColor:(UIColor *)bgColor
                    inView:(__kindof UIView *)inView
                 tapAction:(void(^)(UILabel *label, UIGestureRecognizer *tap))tapAction {
    return [self labelWithText:text
                     textColor:textColor
                 textAlignment:NSTextAlignmentNatural
                      fontSize:fontSize
               backgroundColor:bgColor
                        inView:inView
                     tapAction:tapAction];
}

+ (UILabel *)labelWithText:(NSString *)text
                 textColor:(UIColor *)textColor
             textAlignment:(NSTextAlignment)alignment
                  fontSize:(CGFloat)fontSize
           backgroundColor:(UIColor *)bgColor
                    inView:(__kindof UIView *)inView
                 tapAction:(void(^)(UILabel *label, UIGestureRecognizer *tap))tapAction {
    if (textColor == nil) textColor = [UIColor blackColor];
    if (fontSize <= 0) fontSize = 14.0;
    if (bgColor == nil) bgColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.textColor = textColor;
    label.backgroundColor = bgColor;
    label.textAlignment = alignment;
    label.font = [UIFont systemFontOfSize:fontSize];
    [label sizeToFit];
    
    if (tapAction) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [label addGestureRecognizer:tap];
        [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
            tapAction(label, x);
        }];
    }
    if (inView && [inView isKindOfClass:[UIView class]]) {
        [inView addSubview:label];
    }
    return label;
}
@end
