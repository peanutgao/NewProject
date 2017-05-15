//
//  WDShareItemModel.h
//  MyProject
//
//  Created by Joseph Gao on 2017/5/11.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDBaseModel.h"

typedef NS_ENUM(NSInteger, WDShareType) {
    WDShareTypeWechat,
    WDShareTypeMoment,
    WDShareTypeQQ,
    WDShareTypeWeibo
};

@interface WDShareItemModel : WDBaseModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, assign) WDShareType shareType;

+ (instancetype)modelWithTitle:(NSString *)title
                          icon:(NSString *)icon
                     shareType:(WDShareType)shareType;

@end
