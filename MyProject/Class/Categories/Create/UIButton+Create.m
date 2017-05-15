//
//  UIButton+Create.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/1.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "UIButton+Create.h"

@implementation UIButton (Create)


+ (instancetype)buttonWithNormalImgName:(NSString *)nImgName
                                bgColor:(UIColor *)bgColor
                                 inView:(__kindof UIView *)inView
                                 action:(void(^)(UIButton *btn))action {
    return [self buttonWithTitle:nil
                      titleColor:nil
                        fontSize:14
                   normalImgName:nImgName
            highlightedImageName:nil
                         bgColor:bgColor
               normalBgImageName:nil
          highlightedBgImageName:nil
                          inView:inView
                          action:action];
}

+ (instancetype)buttonWithTitle:(NSString *)title
                     titleColor:(UIColor *)titleColor
                       fontSize:(CGFloat)fontSize
                        bgColor:(UIColor *)bgColor
                         inView:(__kindof UIView *)inView
                         action:(void(^)(UIButton *btn))action {
    return [self buttonWithTitle:title
                      titleColor:titleColor
                        fontSize:fontSize
                   normalImgName:nil
            highlightedImageName:nil
                         bgColor:bgColor
               normalBgImageName:nil
          highlightedBgImageName:nil
                          inView:inView
                          action:action];
}

+ (instancetype)buttonWithTitle:(NSString *)title
                     titleColor:(UIColor *)titleColor
                       fontSize:(CGFloat)fontSize
                  normalImgName:(NSString *)nImgName
                        bgColor:(UIColor *)bgColor
                         inView:(__kindof UIView *)inView
                         action:(void(^)(UIButton *btn))action {
    return [self buttonWithTitle:title
                      titleColor:titleColor
                        fontSize:fontSize
                   normalImgName:nImgName
            highlightedImageName:nil
                         bgColor:bgColor
               normalBgImageName:nil
          highlightedBgImageName:nil
                          inView:inView
                          action:action];
}

+ (instancetype)buttonWithTitle:(NSString *)title
                     titleColor:(UIColor *)titleColor
                       fontSize:(CGFloat)fontSize
                  normalImgName:(NSString *)nImgName
           highlightedImageName:(NSString *)hImgName
                        bgColor:(UIColor *)bgColor
              normalBgImageName:(NSString *)nBgImageName
         highlightedBgImageName:(NSString *)hBgImageName
                         inView:(__kindof UIView *)inView
                         action:(void(^)(UIButton *btn))action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if(title && ![title isEqualToString:@""]) {
        [btn setTitle:title forState:UIControlStateNormal];
    }
    if (titleColor) {
        [btn setTitleColor:titleColor forState:UIControlStateNormal];
    }
    if (fontSize > 0) {
        [btn.titleLabel setFont:[UIFont systemFontOfSize:fontSize]];
    }
    if(nImgName && ![nImgName isEqualToString:@""]) {
        [btn setImage:[UIImage imageNamed:nImgName] forState:UIControlStateNormal];
    }
    if(hImgName && ![hImgName isEqualToString:@""]) {
        [btn setImage:[UIImage imageNamed:hImgName] forState:UIControlStateHighlighted];
    }
    if (bgColor) {
        [btn setBackgroundColor:bgColor];
    }
    if(nBgImageName && ![nBgImageName isEqualToString:@""]) {
        [btn setBackgroundImage:[UIImage imageNamed:nBgImageName] forState:UIControlStateNormal];
    }
    if(hBgImageName && ![hBgImageName isEqualToString:@""]) {
        [btn setBackgroundImage:[UIImage imageNamed:hBgImageName] forState:UIControlStateHighlighted];
    }
    if (action) {
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside]
         subscribeNext:^(__kindof UIControl * _Nullable x) {
             action(x);
         }];
    }
    if (inView && [inView isKindOfClass:[UIView class]]) {
        [inView addSubview:btn];
    }
    
    return btn;
}

@end
