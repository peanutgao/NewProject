//
//  WDSplashViewManager.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/4.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDSplashViewManager.h"
#import "WDSplashViewModel.h"
#import "WDSplashView.h"

@interface WDSplashViewManager ()

@property (nonatomic, strong) WDSplashViewModel *viewModel;
@property (nonatomic, strong) WDSplashView *splashView;

@end

@implementation WDSplashViewManager

- (instancetype)init {
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.splashView = [[WDSplashView alloc] init];
    self.viewModel = [[WDSplashViewModel alloc] init];

    @weakify(self);
    self.showCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        [self.splashView bindWithViewModel:self.viewModel];
        [self.splashView.showCommand execute:@1];
        
        return [RACSignal empty];
    }];
}


@end
