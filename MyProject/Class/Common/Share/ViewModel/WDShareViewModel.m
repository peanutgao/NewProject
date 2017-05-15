//
//  WDShareViewModel.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/11.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDShareViewModel.h"

@implementation WDShareViewModel

- (instancetype)init {
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    NSMutableArray *platforms = [NSMutableArray arrayWithCapacity:4];
    [platforms addObject:[WDShareItemModel modelWithTitle:@"微信" icon:@"Share_Wechat" shareType:WDShareTypeWechat]];
    [platforms addObject:[WDShareItemModel modelWithTitle:@"朋友圈" icon:@"Share_Moment" shareType:WDShareTypeMoment]];
    [platforms addObject:[WDShareItemModel modelWithTitle:@"QQ" icon:@"Share_QQ" shareType:WDShareTypeQQ]];
    [platforms addObject:[WDShareItemModel modelWithTitle:@"微博" icon:@"Share_Weibo" shareType:WDShareTypeWeibo]];
    
    self.platformArray = platforms.copy;
}

@end
