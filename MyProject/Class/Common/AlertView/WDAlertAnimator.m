//
//  WDAlertAnimator.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/13.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDAlertAnimator.h"
#import "WDAlertController.h"

@interface WDAlertAnimator ()

@property (nonatomic, assign) WDAlertControllerStyle style;

@end

@implementation WDAlertAnimator

#pragma mark - UIViewControllerAnimatedTransitioning

- (CGFloat)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    return (toVC.isBeingPresented) ? 0.35 : 0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    UIView *containerView = transitionContext.containerView;
    
    if (toVC.isBeingPresented) {
        [containerView addSubview:toView];
        
        UIView *maskView = [toView viewWithTag:1027];
        UIView *alertView = [toView viewWithTag:1028];
        maskView.alpha = 0.0;
        
        
        WDAlertController *vc = (WDAlertController *)toVC;
        switch (vc.preferredStyle) {
            case WDAlertControllerStyleAlert: {
                alertView.alpha = 0.0;
                alertView.transform = CGAffineTransformMakeScale(0, 0);
                [UIView animateWithDuration:[self transitionDuration:transitionContext]
                                      delay:0.0 usingSpringWithDamping:0.65
                      initialSpringVelocity:0.5
                                    options:0
                                 animations:^{
                                     maskView.alpha = 1.0;
                                     alertView.alpha = 1.0;
                                     alertView.transform = CGAffineTransformMakeScale(1, 1);
                                 }
                                 completion:^(BOOL finished) {
                                     [transitionContext completeTransition:YES];
                                 }];
                break;
            }
                
            case WDAlertControllerStyleActionSheet: {
                alertView.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(alertView.frame));
                [UIView animateWithDuration:[self transitionDuration:transitionContext]
                                      delay:0.0
                     usingSpringWithDamping:0.65
                      initialSpringVelocity:0.5
                                    options:0
                                 animations:^{
                                     maskView.alpha = 1.0;
                                     alertView.transform = CGAffineTransformMakeTranslation(0, 0);
                                 }
                                 completion:^(BOOL finished) {
                                     [transitionContext completeTransition:YES];
                                 }];
                break;
            }
            default:
                break;
        }
        
    }
    else {
        WDAlertController *vc = (WDAlertController *)fromVC;
        UIView *maskView = [fromView viewWithTag:1027];
        UIView *alertView = [fromView viewWithTag:1028];
        maskView.alpha = 1.0;
        
        switch (vc.preferredStyle) {
            case WDAlertControllerStyleAlert: {
                alertView.alpha = 1.0;
                alertView.transform = CGAffineTransformMakeScale(1, 1);
                [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
                    maskView.alpha = 0.0;
                    alertView.alpha = 0.0;
                    alertView.transform = CGAffineTransformMakeScale(0, 0);
                } completion:^(BOOL finished) {
                    [transitionContext completeTransition:YES];
                }];                break;
            }
            case WDAlertControllerStyleActionSheet: {
                alertView.transform = CGAffineTransformMakeTranslation(0, 0);
                [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
                    maskView.alpha = 0.0;
                    alertView.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(alertView.frame));
                } completion:^(BOOL finished) {
                    [transitionContext completeTransition:YES];
                }];
                break;
            }
            default:
                break;
        }
    }
}


#pragma mark - UIViewControllerTransitioning Delegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self;
}


#pragma mark - Initialize

+ (instancetype)animatorWithPresentionStyle:(WDAlertControllerStyle)style {
    return [[self alloc] initWithPresentionStyle:style];
}

- (instancetype)initWithPresentionStyle:(WDAlertControllerStyle)style {
    if (self = [super init]) {
        self.style = style;
    }
    return self;
}

@end
