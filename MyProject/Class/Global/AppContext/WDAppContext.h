//
//  WDAppContext.h
//  MyProject
//
//  Created by Joseph Gao on 2017/5/2.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WDAppConfigModel;

/// 全局环境配置类
@interface WDAppContext : NSObject

/// 是否显示引导页, 更加版本号来判断
@property (nonatomic, assign, readonly, getter=isNeedShowGuiderView) BOOL needShowGuiderView;

/// 最新配置模型
/// latestConfigCommand 完成会执行下载最新配置请求
@property (nonatomic, strong) RACCommand *latestConfigCommand;
@property (nonatomic, strong) RACCommand *saveVersionCommand;

/// app全局配置模型
@property (nonatomic, strong) WDAppConfigModel *appConfigModel;

+ (instancetype)shareContext;

@end
