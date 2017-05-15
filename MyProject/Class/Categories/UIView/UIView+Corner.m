//
//  UIView+Corner.m
//
//  Created by Joseph Gao on 2016/11/30.
//  Copyright © 2016年 Joseph. All rights reserved.
//

#import "UIView+Corner.h"

@implementation UIView (Corner)

-(void)setCornerRadius:(CGFloat)radius withRoundingCorners:(UIRectCorner)corners {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

@end
