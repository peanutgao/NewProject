//
//  WDLoginViewModel.h
//  MyProject
//
//  Created by Joseph Gao on 2017/5/8.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDBaseViewModel.h"

@interface WDLoginViewModel : WDBaseViewModel

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *password;

@property (nonatomic, strong) RACCommand *loginCommand;

@end
