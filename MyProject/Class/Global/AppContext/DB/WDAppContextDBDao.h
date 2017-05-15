//
//  WDAppContextDBDao.h
//  MyProject
//
//  Created by Joseph Gao on 2017/5/8.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDDBDaoManager.h"

@class WDAppConfigModel;

/// app全局配置模型数据库操作类
@interface WDAppContextDBDao : NSObject

/// 保存全局配置数据
+ (RACSignal *)saveAppContextConfig:(WDAppConfigModel *)configModel;

/// 请求全局配置模型
+ (WDAppConfigModel *)quaryConfigModel;

@end
