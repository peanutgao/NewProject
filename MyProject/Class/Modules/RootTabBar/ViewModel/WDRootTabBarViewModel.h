//
//  WDRootTabBarViewModel.h
//  MyProject
//
//  Created by Joseph Gao on 2017/5/10.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDBaseViewModel.h"

@interface WDRootTabBarViewModel : WDBaseViewModel

@property (nonatomic, strong) RACSignal *configVCSignal;
@property (nonatomic, strong) RACSignal *bgImageSignal;

@end
