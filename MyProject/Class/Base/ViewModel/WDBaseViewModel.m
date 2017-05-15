//
//  WDBaseViewModel.m
//  MyProject
//
//  Created by Joseph Gao on 2017/4/30.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDBaseViewModel.h"

@implementation WDBaseViewModel

- (instancetype)init {
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
}

+ (instancetype)viewModelWithObj:(id)obj {
    WDBaseViewModel *vm = [[WDBaseViewModel alloc] init];
    return vm;
}

@end
