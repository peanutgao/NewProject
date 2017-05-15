//
//  WDUserInfoModel.h
//  MyProject
//
//  Created by Joseph Gao on 2017/5/8.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDBaseModel.h"

typedef NS_ENUM(NSInteger, WDGenderType) {
    WDGenderTypeMale,
    WDGenderTypeFemale,
    WDGenderTypeOther,
};

/// 用户详细信息数据模型
@interface WDUserInfoModel : WDBaseModel

@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *idcard;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, assign) WDGenderType gender;

@end
