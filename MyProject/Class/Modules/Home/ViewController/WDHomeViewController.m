//
//  WDHomeViewController.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/2.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDHomeViewController.h"
#import "WDHomeViewModel.h"

@interface WDHomeViewController ()

@property (nonatomic, strong) WDHomeViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UILabel *testLabel;

@end

@implementation WDHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 监听用户信息名字的改变
    // 方式一:
    [RACObserve([WDUserContext shareContext].userModel, info.name) subscribeNext:^(id  _Nullable x) {
        NSLog(@"----%@", x);
    }];
    
    // 方式二:
    [RACObserve([WDUserContext shareContext].userModel.info, name) subscribeNext:^(id  _Nullable x) {
        NSLog(@"----%@", x);
    }];
    

}

- (IBAction)pushVC:(id)sender {
    [YSMediator pushViewControllerClassName:@"TestViewController"
                                 withParams:@{@"infoText": @"Apple"}
                                   animated:YES
                                   callBack:^{
                                       NSLog(@"push结束");
                                   }];
}

- (IBAction)showHUD:(id)sender {
    [WDLoadingHUD showInView:self.view withTitle:@"Hello World"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [WDLoadingHUD hiddenInView:self.view];
    });
    
}

- (IBAction)share:(id)sender {
    [WDShareHelper showShareViewInViewController:self withInfo:nil];
}

- (IBAction)alert:(id)sender {
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"My TitleMy TitleMy TitleMy TitleMy TitleMy TitleMy TitleMy Title"
//                                                               message:@"Detail Mssssssssssssssssssssssssssssssssssssssssessage"
//                                                        preferredStyle:UIAlertControllerStyleAlert];
//    [alert addAction:[UIAlertAction actionWithTitle:@"title 1" style:UIAlertActionStyleDefault handler:NULL]];
    
    
    WDAlertController *alert = [WDAlertController alertControllerWithTitle:@"My Title"
                                                                   message:@"Detail Message Detail Message Detail Message Detail Message Detail Message Detail Message Detail Message Detail Message Detail Message"
                                                            preferredStyle:WDAlertControllerStyleActionSheet];
    WDAlertAction *action = [WDAlertAction actionWithTitle:@"action0" style:WDAlertActionStyleDefault handler:^(WDAlertAction * _Nullable action) {
        
    }];
    action.enabled = NO;
    [alert addAction:action];
    [alert addAction:[WDAlertAction actionWithTitle:@"action1" style:WDAlertActionStyleCancel handler:^(WDAlertAction * _Nullable action) {
        NSLog(@"-----");
    }]];
    [alert addAction:[WDAlertAction actionWithTitle:@"action2" style:WDAlertActionStyleDestructive handler:^(WDAlertAction * _Nullable action) {
        NSLog(@"-----");
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
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
