//
//  WDAlertController.h
//  MyProject
//
//  Created by Joseph Gao on 2017/5/13.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDAlertAction.h"


@interface WDAlertController : UIViewController

@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) WDAlertControllerStyle preferredStyle;


+ (instancetype)alertControllerWithTitle:(NSString *)title
                                 message:(NSString *)message
                          preferredStyle:(WDAlertControllerStyle)preferredStyle;

- (void)addAction:(WDAlertAction *)action;

@end
