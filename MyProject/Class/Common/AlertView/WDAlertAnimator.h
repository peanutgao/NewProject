//
//  WDAlertAnimator.h
//  MyProject
//
//  Created by Joseph Gao on 2017/5/13.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WDAlertEnum.h"

@interface WDAlertAnimator : NSObject<UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>

+ (instancetype)animatorWithPresentionStyle:(WDAlertControllerStyle)style;

@end
