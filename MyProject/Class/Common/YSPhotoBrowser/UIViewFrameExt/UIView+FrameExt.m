//
//  UIView+FrameExt.m
//
//  Created by Joseph on 14/5/26.
//  Copyright (c) 2014年 Joseph. All rights reserved.
//

#import "UIView+FrameExt.h"

@implementation UIView (FrameExt)

//-------------
- (CGFloat)ys_x {
    return self.frame.origin.x;
}

- (void)setYs_x:(CGFloat)x {
    CGRect frame   = self.frame;
    frame.origin.x = x;
    self.frame     = frame;
}

//-------------
- (CGFloat)ys_y {
    return self.frame.origin.y;
}

- (void)setYs_y:(CGFloat)y {
    CGRect frame   = self.frame;
    frame.origin.y = y;
    self.frame     = frame;
}

//-------------
- (CGFloat)ys_width {
    return self.frame.size.width;
}

- (void)setYs_width:(CGFloat)width {
    CGRect frame     = self.frame;
    frame.size.width = width;
    self.frame       = frame;
}

//-------------
- (CGFloat)ys_height {
    return self.frame.size.height;
}

- (void)setYs_height:(CGFloat)height {
    CGRect frame      = self.frame;
    frame.size.height = height;
    self.frame        = frame;
}


#pragma mark

//-------------
- (CGFloat)ys_boundsW {
    return self.bounds.size.width;
}

- (void)setYs_boundsW:(CGFloat)boundsW {
    CGRect bounds     = self.bounds;
    bounds.size.width = boundsW;
    self.bounds       = bounds;
}

//-------------
- (CGFloat)ys_boundsH {
    return self.bounds.size.height;
}

- (void)setYs_boundsH:(CGFloat)boundsH {
    CGRect bounds      = self.bounds;
    bounds.size.height = boundsH;
    self.bounds        = bounds;
}

//-------------
- (CGFloat)ys_centerX {
    return self.center.x;
}

- (void)setYs_centerX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x       = centerX;
    self.center    = center;
}

//-------------
- (CGFloat)ys_centerY {
    return self.center.y;
}

- (void)setYs_centerY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y       = centerY;
    self.center    = center;
}


#pragma mark 

//-------------
- (CGFloat)ys_left {
    return self.frame.origin.x;
}

- (void)setYs_left:(CGFloat)ys_left {
    CGRect frame   = self.frame;
    frame.origin.x = ys_left;
    self.frame     = frame;
}

//-------------
- (CGFloat)ys_right {
//    return self.frame.origin.x + self.frame.size.width;
    return CGRectGetMaxX(self.frame);
}

- (void)setYs_right:(CGFloat)ys_right {
    CGRect frame   = self.frame;
    frame.origin.x = ys_right - frame.size.width;
    self.frame     = frame;
}

//-------------
- (CGFloat)ys_top {
    return self.frame.origin.y;
}

- (void)setYs_top:(CGFloat)ys_top {
    CGRect frame   = self.frame;
    frame.origin.y = ys_top;
    self.frame     = frame;
}

//-------------
- (CGFloat)ys_bottom {
    return CGRectGetMaxY(self.frame);
}

- (void)setYs_bottom:(CGFloat)ys_bottom  {
    CGRect frame   = self.frame;
    frame.origin.y = ys_bottom - frame.size.height;
    self.frame     = frame;
}


#pragma mark 

- (CGSize)ys_size {
    return self.frame.size;
}

- (void)setYs_size:(CGSize)ys_size {
    CGRect frame = self.frame;
    frame.size = ys_size;
    self.frame = frame;
}

@end












