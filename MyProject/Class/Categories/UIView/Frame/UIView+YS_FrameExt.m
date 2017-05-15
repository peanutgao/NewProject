//
//  UIView+FrameExt.m
//
//  Created by Joseph on 14/5/26.
//  Copyright (c) 2014年 Joseph. All rights reserved.
//

#import "UIView+FrameExt.h"

@implementation UIView (YS_FrameExt)

//-------------
- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x {
    CGRect frame   = self.frame;
    frame.origin.x = x;
    self.frame     = frame;
}

//-------------
- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y {
    CGRect frame   = self.frame;
    frame.origin.y = y;
    self.frame     = frame;
}

//-------------
- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame     = self.frame;
    frame.size.width = width;
    self.frame       = frame;
}

//-------------
- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame      = self.frame;
    frame.size.height = height;
    self.frame        = frame;
}


#pragma mark

//-------------
- (CGFloat)boundsW {
    return self.bounds.size.width;
}

- (void)setBoundsW:(CGFloat)boundsW {
    CGRect bounds     = self.bounds;
    bounds.size.width = boundsW;
    self.bounds       = bounds;
}

//-------------
- (CGFloat)boundsH {
    return self.bounds.size.height;
}

- (void)setBoundsH:(CGFloat)boundsH {
    CGRect bounds      = self.bounds;
    bounds.size.height = boundsH;
    self.bounds        = bounds;
}

//-------------
- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x       = centerX;
    self.center    = center;
}

//-------------
- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y       = centerY;
    self.center    = center;
}


#pragma mark 

//-------------
- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)left {
    CGRect frame   = self.frame;
    frame.origin.x = left;
    self.frame     = frame;
}

//-------------
- (CGFloat)right {
//    return self.frame.origin.x + self.frame.size.width;
    return CGRectGetMaxX(self.frame);
}

- (void)setRight:(CGFloat)right {
    CGRect frame   = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame     = frame;
}

//-------------
- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)top {
    CGRect frame   = self.frame;
    frame.origin.y = top;
    self.frame     = frame;
}

//-------------
- (CGFloat)bottom {
    return CGRectGetMaxY(self.frame);
}

- (void)setBottom:(CGFloat)bottom  {
    CGRect frame   = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame     = frame;
}


#pragma mark 

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

@end











