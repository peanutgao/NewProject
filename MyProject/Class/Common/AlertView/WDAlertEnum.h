//
//  WDAlertEnum.h
//  MyProject
//
//  Created by Joseph Gao on 2017/5/13.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#ifndef WDAlertEnum_h
#define WDAlertEnum_h

typedef NS_ENUM(NSInteger, WDAlertActionStyle) {
    WDAlertActionStyleDefault = 0,
    WDAlertActionStyleCancel,
    WDAlertActionStyleDestructive
} NS_ENUM_AVAILABLE_IOS(8_0);

typedef NS_ENUM(NSInteger, WDAlertControllerStyle) {
    WDAlertControllerStyleActionSheet = 0,
    WDAlertControllerStyleAlert
} NS_ENUM_AVAILABLE_IOS(8_0);



#endif /* WDAlertEnum_h */
