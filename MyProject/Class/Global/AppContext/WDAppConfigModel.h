//
//  WDAppConfigModel.h
//  MyProject
//
//  Created by Joseph Gao on 2017/5/3.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDBaseModel.h"

/// 环境全局配置模型类
@interface WDAppConfigModel : WDBaseModel

@property (nonatomic, copy) NSString *adURL;
@property (nonatomic, copy) NSString *adImageURL;

@end
