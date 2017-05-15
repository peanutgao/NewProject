//
//  TestViewController.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/11.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RAC(self.infoLabel, text) = RACObserve(self, infoText);
    
}
- (IBAction)showIndeterminate:(id)sender {
    [WDLoadingHUD showIndeterminate];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [WDLoadingHUD hiddenIndeterminate];
    });
}

- (IBAction)showHUD:(id)sender {
    [WDLoadingHUD showInView:self.view withTitle:@"Hello World"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [WDLoadingHUD hiddenInView:self.view];
    });
}

- (IBAction)push:(id)sender {
    [YSMediator pushViewControllerClassName:@"WDHomeViewController"
                                 withParams:@{@"infoText": @"Apple"}
                                   animated:YES
                                   callBack:^{
                                       NSLog(@"push结束");
                                   }];
}

- (IBAction)present:(id)sender {
    [YSMediator presentViewControllerClassName:@"TestViewController"
                                    withParams:@{@"infoText": @"Apple"}
                                      animated:YES
                                      callBack:^{
                                          NSLog(@"present结束");
                                      }];
}

@end
