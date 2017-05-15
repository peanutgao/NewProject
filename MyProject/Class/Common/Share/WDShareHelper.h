//
//  WDShareHelper.h
//  MyProject
//
//  Created by Joseph Gao on 2017/5/10.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WDShareModel.h"

@interface WDShareHelper : NSObject
/**
 显示分享页面

 @param vc 在哪个控制器中显示
 @param shareModel 分享数据模型, 自行封装
 @return 分享结果信号
 */
+ (RACSignal *)showShareViewInViewController:(UIViewController *)vc
                                    withInfo:(WDShareModel *)shareModel;

@end


