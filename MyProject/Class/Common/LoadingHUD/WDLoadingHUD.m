//
//  WDLoadingHUD.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/11.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDLoadingHUD.h"
#import "MBProgressHUD.h"

@implementation WDLoadingHUD

+ (void)showTips:(NSString *)tips {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.label.text = tips;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hideAnimated:YES];
    });
}

+ (void)showInView:(UIView *)inView {
    return [self showInView:inView withTitle:nil];
}

+ (void)showInView:(UIView *)inView withTitle:(NSString *)title {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:inView animated:YES];
    if (title) hud.label.text = title;
    hud.mode = MBProgressHUDModeCustomView;
    hud.contentColor = [UIColor blueColor];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
        imageView.animatedImage = [FLAnimatedImage animatedImageWithGIFData:[self imageData]];
        hud.customView = imageView;
        hud.animationType = MBProgressHUDAnimationFade;
    });
}

+ (NSData *)imageData {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"WDLoadingHUD" ofType:@"bundle"];
    NSString *imgPath = [bundlePath stringByAppendingPathComponent:@"dashinfinity.gif"];
    NSData *gifData = [NSData dataWithContentsOfFile:imgPath];
    
    return gifData;
}

+ (void)hiddenInView:(UIView *)inView {
    if (inView == nil) inView = [[UIApplication sharedApplication].windows lastObject];
    
    MBProgressHUD *hud = [self HUDForView:inView];
    if (hud != nil) {
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:YES];
    }
}

+ (void)showIndeterminate {
    [self showInView:[UIApplication sharedApplication].keyWindow withTitle:nil];
}

+ (void)hiddenIndeterminate {
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
}

+ (MBProgressHUD *)HUDForView:(UIView *)view {
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:[MBProgressHUD class]]) {
            return (MBProgressHUD *)subview;
        }
    }
    return nil;
}

@end
