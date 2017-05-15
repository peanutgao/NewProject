//
//  WDAlertAction.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/13.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDAlertAction.h"

@interface WDAlertAction ()

@property (nonatomic, strong) UIButton *actionBtn;

@end

@implementation WDAlertAction

+ (instancetype)actionWithTitle:(NSString *)title
                          style:(WDAlertActionStyle)style
                        handler:(void (^)(WDAlertAction *action))handler {
    WDAlertAction *action = [[WDAlertAction alloc] init];
    action->_title = title;
    action->_style = style;
    action.alertAction = handler;
    action.enabled = YES;
    return action;
}
@end
