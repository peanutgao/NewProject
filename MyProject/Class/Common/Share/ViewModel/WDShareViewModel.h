//
//  WDShareViewModel.h
//  MyProject
//
//  Created by Joseph Gao on 2017/5/11.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDBaseViewModel.h"
#import "WDShareItemModel.h"

@interface WDShareViewModel : WDBaseViewModel

@property (nonatomic, strong) NSArray<WDShareItemModel *> *platformArray;

@end
