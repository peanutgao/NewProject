//
//  WDLaunchAdViewMananger.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/8.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDLaunchAdViewMananger.h"
#import "WDLaunchAdView.h"
#import "WDLaunchAdViewModel.h"

@interface WDLaunchAdViewMananger ()

@property (nonatomic, strong) WDLaunchAdViewModel *viewModel;
@property (nonatomic, strong) WDLaunchAdView *adView;

@end

@implementation WDLaunchAdViewMananger

- (instancetype)init {
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.viewModel = [[WDLaunchAdViewModel alloc] init];
    self.adView = [[WDLaunchAdView alloc] init];
    
    
    self->_downloadAdCommand = self.viewModel.downloadAdCommand;
    self->_showAdCommand = self.adView.showCommand;
    self->_haveAdImage = self.viewModel.isHaveAdImage;
    
    [self.adView bindWithViewModel:self.viewModel];
    [self.viewModel.loadAdCommand execute:@1]; // 加载图片
}


@end
