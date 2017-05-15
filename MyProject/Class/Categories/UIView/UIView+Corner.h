//
//  UIView+Corner.h
//
//  Created by Joseph Gao on 2016/11/30.
//  Copyright © 2016年 Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Corner)

/**
 *  设置圆角
 *
 *  @param radius  圆角度数
 *  @param corners UIRectCorner
 */
-(void)setCornerRadius:(CGFloat)radius withRoundingCorners:(UIRectCorner)corners;

@end
