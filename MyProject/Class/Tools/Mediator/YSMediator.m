//
//  YSMediator.m
//  Mediator
//
//  Created by Joseph Gao on 2017/4/6.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "YSMediator.h"

typedef NS_ENUM(NSInteger, YSMediatorShowType) {
    YSMediatorShowTypePush,
    YSMediatorShowTypePresented,
};

typedef void(^YSMediatorEnumeration)(Class cls, BOOL *stop);


@implementation YSMediator


#pragma mark - Push/Present

+ (void)pushViewControllerClassName:(NSString *)VCClassName
                         withParams:(NSDictionary *)params
                           animated:(BOOL)flag
                           callBack:(void(^)(void))callBack {
    [self jumpToTargetViewControllerClassName:VCClassName
                                   withParams:params
                                     animated:flag
                                     showType:YSMediatorShowTypePush
                                     callBack:callBack];
}

+ (void)presentViewControllerClassName:(NSString *)VCClassName
                            withParams:(NSDictionary *)params
                              animated:(BOOL)flag
                              callBack:(void(^)(void))callBack {
    [self jumpToTargetViewControllerClassName:VCClassName
                                   withParams:params
                                     animated:flag
                                     showType:YSMediatorShowTypePresented
                                     callBack:callBack];
}

+ (void)jumpToTargetViewControllerClassName:(NSString *)tCName
                    withParams:(NSDictionary *)params
                      animated:(BOOL)flag
                      showType:(YSMediatorShowType)showType
                      callBack:(void(^)(void))callBack {
    if (tCName ==  nil) return;
    if (NSClassFromString(tCName) == nil) return;
    
    // 属性赋值
    [self setPropretyWithTargetClass:NSClassFromString(tCName) Params:params handle:^(__kindof UIViewController *targetVC) {
        UIViewController *topVC = [self topViewController];
        UINavigationController *nav = nil;
        UIViewController *from = topVC;
        if ([topVC isKindOfClass:[UINavigationController class]]) {
            nav = (UINavigationController *)topVC;
            from = nav.topViewController;
            if ([nav.visibleViewController isKindOfClass:[UITabBarController class]]) {
                UITabBarController *tabBar = (UITabBarController *)nav.visibleViewController;
                from = tabBar.selectedViewController;
                if ([from isKindOfClass:[UINavigationController class]]) {
                    nav = (UINavigationController *)from;
                }
            }
        }
        else if ([topVC isKindOfClass:[UITabBarController class]]) {
            from = [(UITabBarController *)topVC selectedViewController];
            if ([from isKindOfClass:[UINavigationController class]]) {
                nav = (UINavigationController *)from;
            }
        }
        
        // 跳转
        switch (showType) {
            case YSMediatorShowTypePush: {
                targetVC.hidesBottomBarWhenPushed = YES;
                [nav pushViewController:targetVC animated:YES];
                if (callBack) {
                    callBack();
                }
                break;
            }
            case YSMediatorShowTypePresented: {
                [from presentViewController:targetVC animated:YES completion:callBack];
            }
                
            default:
                break;
        }
    }];
}


+ (void)setPropretyWithTargetClass:(Class)targetClass
                            Params:(NSDictionary *)params
                            handle:(void(^)(__kindof UIViewController *targetVC))handler {
    // TODO: xib兼容
    UIViewController *targetVC = [[targetClass alloc] init];
    if (![targetVC isKindOfClass:[UIViewController class]]) return;
    
    if ([params isKindOfClass:[NSDictionary class]] &&
        params &&
        params != (id)kCFNull) {
        
        [self enumerateTargetClass:targetClass enumeration:^(__unsafe_unretained Class cls, BOOL *stop) {
            NSMutableArray *propertiesArray = [NSMutableArray array];
            NSMutableArray *attributesArray = [NSMutableArray array];
            unsigned int outCount = 0;
            
            objc_property_t *properties = class_copyPropertyList(cls, &outCount);
            
            for (unsigned int i = 0; i < outCount; i++) {
                objc_property_t property = properties[i];
                NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
                [propertiesArray addObject:propertyName];
                
                NSString *attributeName = [NSString stringWithUTF8String:getPropertyType(property)];
                [attributesArray addObject:attributeName];
            }
            
            for (int i = 0; i < propertiesArray.count; i++) {
                NSString *property = propertiesArray[i];
                NSString *attribute = attributesArray[i];
                NSObject *value = [params objectForKey:property];
    
                if (value == nil) continue;
                if ([value isKindOfClass:NSClassFromString(attribute)] ||
                    [self isKindOfBlockClass:value]) {
                    [targetVC setValue:value forKey:property];
                }
            }
            
            free(properties);
        }];
    }

    if (handler) {
        handler(targetVC);
    }
}

+ (BOOL)isKindOfBlockClass:(id)item {
    id block = ^{};
    Class clz = [block class];
    while ([clz superclass] != [NSObject class]) {
        clz = [clz superclass];
    }
    return [item isKindOfClass:clz];
}

+ (void)enumerateTargetClass:(Class)targetClass enumeration:(YSMediatorEnumeration)enumeration {
    if (enumeration == nil) return;
    
    BOOL stop = NO;
    Class c = targetClass;
    while (c && !stop) {
        enumeration(c, &stop);
        c = class_getSuperclass(c);
        
        if (c == [NSObject class]) {
            stop = YES;
        } else {
            stop = NO;
        }
    }
    
}

static const char *getPropertyType(objc_property_t property) {
    const char *attributes = property_getAttributes(property);
    //printf("attributes=%s\n", attributes);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T' && attribute[1] != '@') {
            // it's a C primitive type:
            
            // if you want a list of what will be returned for these primitives, search online for
            // "objective-c" "Property Attribute Description Examples"
            // apple docs list plenty of examples of what you get for int "i", long "l", unsigned "I", struct, etc.
            
            NSString *name = [[NSString alloc] initWithBytes:attribute + 1 length:strlen(attribute) - 1 encoding:NSASCIIStringEncoding];
            return (const char *)[name cStringUsingEncoding:NSASCIIStringEncoding];
        }
        else if (attribute[0] == 'T' && attribute[1] == '@' && strlen(attribute) == 2) {
            // it's an ObjC id type:
            return "id";
        }
        else if (attribute[0] == 'T' && attribute[1] == '@') {
            // it's another ObjC object type:
            NSString *name = [[NSString alloc] initWithBytes:attribute + 3 length:strlen(attribute) - 4 encoding:NSASCIIStringEncoding];
            if (name) {
                return (const char *)[name cStringUsingEncoding:NSASCIIStringEncoding];
            }
            else {
                // TODO: block判断 待优化
                return "Block";
            }
            
        }
    }
    return "";
}

+ (UIViewController *)topViewController{
    return [self topViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

+ (UIViewController *)topViewController:(UIViewController *)rootViewController
{
    if (rootViewController.presentedViewController == nil) {
        return rootViewController;
    }
    
    if ([rootViewController.presentedViewController isMemberOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootViewController.presentedViewController;
        UIViewController *lastViewController = [[navigationController viewControllers] lastObject];
        return [self topViewController:lastViewController];
    }
    
    UIViewController *presentedViewController = (UIViewController *)rootViewController.presentedViewController;
    return [self topViewController:presentedViewController];
}

@end

