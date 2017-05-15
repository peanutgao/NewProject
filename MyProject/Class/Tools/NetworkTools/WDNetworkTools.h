//
//  WDNetworkTools.h
//  MyProject
//
//  Created by Joseph Gao on 2017/5/12.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDNetworkTools : NSObject

@property (nonatomic, assign, readonly, getter=isReachable) BOOL reachable;

+ (instancetype)shareTools;

- (void)startMonitoring;
- (void)stopMonitoring;

@end
