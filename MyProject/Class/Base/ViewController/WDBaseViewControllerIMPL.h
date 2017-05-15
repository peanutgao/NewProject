//
//  WDBaseViewControllerIMPL.h
//  MyProject
//
//  Created by Joseph Gao on 2017/5/8.
//  Copyright © 2017年 Joseph. All rights reserved.
//

@protocol WDBaseViewControllerIMPL <NSObject>

@optional
- (void)bindViewModel;
- (void)setupSubviews;
- (void)setupSubviewsLayout;

@end
