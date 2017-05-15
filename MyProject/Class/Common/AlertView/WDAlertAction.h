//
//  WDAlertAction.h
//  MyProject
//
//  Created by Joseph Gao on 2017/5/13.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WDAlertEnum.h"

@interface WDAlertAction : NSObject

+ (instancetype)actionWithTitle:(NSString *)title
                          style:(WDAlertActionStyle)style
                        handler:(void (^)(WDAlertAction *action))handler;

@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) WDAlertActionStyle style;
@property (nonatomic, copy) void (^alertAction)(WDAlertAction *action);
@property (nonatomic, getter=isEnabled) BOOL enabled;

@end
