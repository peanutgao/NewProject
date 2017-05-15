//
//  YSMediator+TargetAction.m
//  Mediator
//
//  Created by Joseph Gao on 2017/4/11.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "YSMediator+TargetAction.h"
#import <objc/runtime.h>

typedef NS_ENUM(NSInteger, MediatorMethodType) {
    MediatorMethodTypeInstance,
    MediatorMethodTypeClass,
};

@implementation YSMediator (TargetAction)

+ (void)performTarget:(NSString *)targetClass
     doInstanceAction:(NSString *)aSelector
          withObjects:(NSDictionary *)arguments
             callBack:(void(^)(id result))callBack {
    [self performTarget:targetClass
               doAction:aSelector
             methodType:MediatorMethodTypeInstance
            withObjects:arguments
               callBack:callBack];
}

+ (void)performTarget:(NSString *)targetClass
        doClassAction:(NSString *)aSelector
          withObjects:(NSDictionary *)arguments
             callBack:(void(^)(id result))callBack {
    [self performTarget:targetClass
               doAction:aSelector
             methodType:MediatorMethodTypeClass
            withObjects:arguments
               callBack:callBack];
}

+ (void)performTarget:(NSString *)targetClass
             doAction:(NSString *)aSelector
           methodType:(MediatorMethodType)methodType
          withObjects:(NSDictionary *)arguments
             callBack:(void(^)(id result))callBack {
    if ([self ys_isEmptyString:targetClass] || [self ys_isEmptyString:aSelector]) {
        NSLog(@"\n ====> !!! Warning: targetClass or aSelector is Empty");
        return;
    }
    if (NSClassFromString(targetClass) == nil) {
        NSLog(@"\n ====> !!! Warning: targetClass is nil");
        return;
    }
    
    
    NSString *actionClazz = [NSString stringWithFormat:@"%@_Action", targetClass];
    id obj = nil;
    switch (methodType) {
        case MediatorMethodTypeInstance: {
            obj = [[NSClassFromString(actionClazz) alloc] init];
            break;
        }
        case MediatorMethodTypeClass: {
            obj = NSClassFromString(actionClazz);
            break;
        }
        default:
            break;
    }
    
    SEL action = NSSelectorFromString(aSelector);
    if (![obj respondsToSelector:action]) {
        NSLog(@"\n ====> !!! Warning: %@ Can not responds To Selector: %@", targetClass, aSelector);
        return;
    }
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    id result =  [obj performSelector:action withObject:arguments];
#pragma clang diagnostic pop
    
    if (callBack) {
        callBack(result);
    }
}


#pragma mark - Other

+ (BOOL)ys_isEmptyString:(NSString *)str {
    if (str == nil ||
        [[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        return YES;
    }
    return NO;
}


@end
