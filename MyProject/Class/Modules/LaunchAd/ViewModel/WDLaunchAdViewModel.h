//
//  WDLaunchAdViewModel.h
//  MyProject
//
//  Created by Joseph Gao on 2017/5/2.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDBaseViewModel.h"

@interface WDLaunchAdViewModel : WDBaseViewModel

@property (nonatomic, strong, readonly) UIImage *adImage;

@property (nonatomic, assign, readonly, getter=isHaveAdImage) BOOL haveAdImage;

@property (nonatomic, strong) RACCommand *downloadAdCommand;
@property (nonatomic, strong) RACCommand *loadAdCommand;
@property (nonatomic, strong) RACCommand *clickAdCommand;


@end
