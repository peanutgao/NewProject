//
//  WDRootTabBarController.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/10.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDRootTabBarController.h"
#import "WDRootTabBarViewModel.h"

@interface WDRootTabBarController ()

@property (nonatomic, strong) WDRootTabBarViewModel *viewModel;
@property (nonatomic, strong) UIImageView * backImageView;

@end

@implementation WDRootTabBarController

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialize];
    [self bind];
}


#pragma mark - Bind

- (void)bind {
    self.viewModel = [[WDRootTabBarViewModel alloc] init];
    
    @weakify(self);
    [self.viewModel.configVCSignal subscribeNext:^(NSArray * _Nullable x) {
        @strongify(self);
        self.viewControllers = x;
    }];
    
    RAC(self.backImageView, image) = self.viewModel.bgImageSignal;
    
}

- (void)initialize {
    //去掉系统的线
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    [[UITabBar appearance] setBarTintColor: [UIColor whiteColor]];  // 修改tabBar颜色
    
    // 设置背景图片
    self.backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49.)];
    self.backImageView.image = [UIImage imageNamed:@"背景条安卓"];
    self.backImageView.clipsToBounds = YES;
    [self.tabBar insertSubview:self.backImageView atIndex:0];
    
    // 顶部添加线条
    UIView *line = [[UIView alloc] init];
    line.frame = CGRectMake(0, 0, self.tabBar.frame.size.width, 1);
    line.backgroundColor = [UIColor redColor];
    [self.tabBar insertSubview:line atIndex:0];
}

@end
