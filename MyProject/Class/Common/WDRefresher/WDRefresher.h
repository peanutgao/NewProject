//
//  WDRefresher.h
//  MyProject
//
//  Created by Joseph Gao on 2017/5/12.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WDRefreshHeader.h"
#import "WDRefreshGifHeader.h"
#import "WDRefreshFooter.h"

/// 项目上拉刷新和下拉加载更多封装类
/// 外界调用该类方法, 方便项目需求变更,普通和Gif动画切换外界无需更改代码
@interface WDRefresher : NSObject

+ (WDRefreshHeader *)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action;
+ (WDRefreshHeader *)headerWithRefreshingBlock:(void(^)(void))refreshingBlock;

+ (WDRefreshFooter *)footerWithRefreshingTarget:(id)target refreshingAction:(SEL)action;
+ (WDRefreshFooter *)footerWithRefreshingBlock:(void(^)(void))refreshingBlock;

@end
