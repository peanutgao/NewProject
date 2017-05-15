//
//  WDVersionCompare.h
//  MyProject
//
//  Created by Joseph Gao on 2017/5/5.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDVersionCompare : NSObject
/**
 比较版本号

 @param v1 第一个版本号
 @param v2 第二个版本号
 @return 如果版本号相等，返回 0, 如果第一个版本号低于第二个，返回 -1，否则返回 1.
 */
int compareVersion(const char *v1, const char *v2);
@end
