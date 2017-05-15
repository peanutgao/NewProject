//
//  WDShareHelper.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/10.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDShareHelper.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WXApi.h"
#import "WeiboSDK.h"
#import "WDShareViewController.h"
#import <objc/runtime.h>


#pragma mark - Category

@interface UIViewController (Animator)

@property (nonatomic, strong) YSPresentAnimator *presentAnimator;

@end


@implementation UIViewController (Animator)

static const char YSPresentAnimatorKey;
- (void)setPresentAnimator:(YSPresentAnimator *)presentAnimator {
    objc_setAssociatedObject(self, &YSPresentAnimatorKey, presentAnimator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (YSPresentAnimator *)presentAnimator {
    return objc_getAssociatedObject(self, &YSPresentAnimatorKey);
}

@end


@implementation WDShareHelper

+ (RACSignal *)showShareViewInViewController:(UIViewController *)vc withInfo:(WDShareModel *)shareModel {
    if (!vc) return nil;
    
    YSPresentAnimator *animator = [[YSPresentAnimator alloc] init];
    
    WDShareViewController *shareVC = [[WDShareViewController alloc] init];
    // 动态添加 presentAnimator 属性, 强引用
    shareVC.presentAnimator = animator;
    shareVC.transitioningDelegate = animator;
    shareVC.modalPresentationStyle = UIModalPresentationCustom;
    shareVC.shareModel = shareModel;
    [vc presentViewController:shareVC animated:YES completion:NULL];
    
    return shareVC.resultSignal;
}

@end


#pragma mark - Present Animator

@implementation YSPresentAnimator

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self;
}


- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    WDShareViewController *shareVC = nil;
    UIView *containerView = [transitionContext containerView];

    if (toVC.isBeingPresented) {
        shareVC = (WDShareViewController *)toVC;
        
        CGFloat shareViewH = shareVC.shareView.height;
        shareVC.maskView.alpha = 0.0;
        shareVC.shareView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, shareViewH);
        [containerView addSubview:shareVC.view];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                              delay:0 usingSpringWithDamping:1
              initialSpringVelocity:1
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             shareVC.maskView.alpha = 1.0;
                             shareVC.shareView.y = SCREEN_HEIGHT - shareViewH;
                         }
                         completion:^(BOOL finished) {
                            [transitionContext completeTransition:YES];

                         }];
    }
    else {
        shareVC = (WDShareViewController *)fromVC;
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             shareVC.maskView.alpha = 0;
                             shareVC.shareView.y = SCREEN_HEIGHT;
                         } completion:^(BOOL finished) {
                             [transitionContext completeTransition:YES];
                         }];
    }
}


@end
