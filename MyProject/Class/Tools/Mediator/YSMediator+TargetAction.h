//
//  YSMediator+TargetAction.h
//  Mediator
//
//  Created by Joseph Gao on 2017/4/11.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "YSMediator.h"

@interface YSMediator (TargetAction)

// TODO: 待开发

+ (void)performTarget:(NSString *)targetClass
     doInstanceAction:(NSString *)aSelector
          withObjects:(NSDictionary *)arguments
             callBack:(void(^)(id result))callBack;

+ (void)performTarget:(NSString *)targetClass
        doClassAction:(NSString *)aSelector
          withObjects:(NSDictionary *)arguments
             callBack:(void(^)(id result))callBack;

@end
