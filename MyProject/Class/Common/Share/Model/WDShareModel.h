//
//  WDShareModel.h
//  MyProject
//
//  Created by Joseph Gao on 2017/5/10.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDBaseModel.h"

@interface WDShareModel : WDBaseModel
/// 分享icon
@property (nonatomic, strong) NSString *thumb;
/// 分享标题
@property (nonatomic, strong) NSString *title;
/// 分享内容摘要
@property (nonatomic, strong) NSString *brief;
/// 分享链接
@property (nonatomic, strong) NSString *shareUrl;
/// 分享的图片
@property (nonatomic, strong) UIImage *image;

@end
