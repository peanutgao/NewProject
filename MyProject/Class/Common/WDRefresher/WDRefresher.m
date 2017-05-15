//
//  WDRefresher.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/12.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDRefresher.h"

@implementation WDRefresher

#pragma mark - Header Refresh

+ (WDRefreshHeader *)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action {
    return [WDRefreshHeader headerWithRefreshingTarget:target refreshingAction:action];
    // return [WDRefreshGifHeader headerWithRefreshingTarget:target refreshingAction:action];
}

+ (WDRefreshHeader *)headerWithRefreshingBlock:(void(^)(void))refreshingBlock {
    return [WDRefreshHeader headerWithRefreshingBlock:refreshingBlock];
    // return [WDRefreshGifHeader headerWithRefreshingBlock:refreshingBlock];
}

#pragma mark - Footer Refresh

+ (WDRefreshFooter *)footerWithRefreshingTarget:(id)target refreshingAction:(SEL)action {
    return [WDRefreshFooter footerWithRefreshingTarget:target refreshingAction:action];
}

+ (WDRefreshFooter *)footerWithRefreshingBlock:(void(^)(void))refreshingBlock {
    return [WDRefreshFooter footerWithRefreshingBlock:refreshingBlock];
}



@end
