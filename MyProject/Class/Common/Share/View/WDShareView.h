//
//  WDShareView.h
//  MyProject
//
//  Created by Joseph Gao on 2017/5/10.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDBaseView.h"

@interface WDShareView : WDBaseView

@property (nonatomic, strong) RACSubject *dismissSubject;
@property (nonatomic, strong) RACSubject *itemClickedSubject;
@end
