//
//  WDSplashViewModel.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/3.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDSplashViewModel.h"

@implementation WDSplashViewModel

- (instancetype)init {
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.imagesArray = @[
                         @"1.jpg",
                         @"2.jpg",
                         @"3.jpg"
                         ];
}

@end
