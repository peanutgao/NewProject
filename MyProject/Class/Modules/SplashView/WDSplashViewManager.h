//
//  WDSplashViewManager.h
//  MyProject
//
//  Created by Joseph Gao on 2017/5/4.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 启动引导页显示管理器
@interface WDSplashViewManager : NSObject

@property (nonatomic, strong) RACCommand *showCommand;

@end
