//
//  WDShareItemModel.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/11.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDShareItemModel.h"

@implementation WDShareItemModel

+ (instancetype)modelWithTitle:(NSString *)title
                          icon:(NSString *)icon
                     shareType:(WDShareType)shareType {
    WDShareItemModel *item = [[WDShareItemModel alloc] init];
    item.title = title;
    item.icon = icon;
    item.shareType = shareType;
    return item;
}


@end
