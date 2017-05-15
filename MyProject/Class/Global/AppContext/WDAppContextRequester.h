//
//  WDAppContextRequester.h
//  MyProject
//
//  Created by Joseph Gao on 2017/5/5.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 全局环境配置数据请求类
@interface WDAppContextRequester : NSObject

@property (nonatomic, strong) RACCommand *loadDBDataCommand;
@property (nonatomic, strong) RACCommand *downloadLatestDataCommand;

@end
