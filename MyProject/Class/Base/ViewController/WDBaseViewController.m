//
//  WDBaseViewController.m
//  MyProject
//
//  Created by Joseph Gao on 2017/4/30.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDBaseViewController.h"

@interface WDBaseViewController ()

@end

@implementation WDBaseViewController

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubviews];
    [self setupSubviewsLayout];
    [self bindViewModel];
}


#pragma mark - Bind

- (void)bindViewModel {
    
}


#pragma mark - Initialize

- (void)setupSubviews {
    
}

- (void)setupSubviewsLayout {
}


#pragma mark - Lazy Loading

@end
