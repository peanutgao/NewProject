//
//  WDShareViewController.h
//  MyProject
//
//  Created by Joseph Gao on 2017/5/10.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDBaseViewController.h"
#import "WDShareView.h"

/// 分享弹窗页面
@interface WDShareViewController : UIViewController

/// 分享数据模型
@property (nonatomic, strong) WDShareModel *shareModel;
/// 分享结果信号
@property (nonatomic, strong) RACSubject *resultSignal;

/// 遮罩
@property (nonatomic, strong) UIView *maskView;
/// 分享页
@property (nonatomic, strong) WDShareView *shareView;

@end


#pragma mark - Present Animator

@interface YSPresentAnimator : NSObject<UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate>

@end
