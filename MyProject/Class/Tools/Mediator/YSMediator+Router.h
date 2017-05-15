//
//  YSMediator+Router.h
//  Mediator
//
//  Created by Joseph Gao on 2017/4/11.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "YSMediator.h"

@interface YSMediator (Router)

// TODO: 待开发

// http://www.baidu.com
// com.apple.com://homepage?name=Jo&gender=boy
+ (void)openURL:(NSString *)urlStr withCallBack:(void(^)(__kindof NSDictionary *dict))callBack;

@end
