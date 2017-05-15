//
//  WDProfileViewController.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/9.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDProfileViewController.h"
#import "AppPushAssistant.h"

@interface WDProfileViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *loginSwitch;

@end

@implementation WDProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.loginSwitch.rac_newOnChannel subscribeNext:^(id  _Nullable x) {
        NSLog(@"----%@", x);
        [[AppPushAssistant shareAssistant].pushStatusCommand execute:x];
        [[[AppPushAssistant shareAssistant].pushStatusCommand.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
            NSLog(@"----");
        }];
    }];
}
- (IBAction)push:(id)sender {
    [YSMediator pushViewControllerClassName:@"TestViewController"
                                 withParams:@{@"infoText": @"Apple"}
                                   animated:YES
                                   callBack:^{
                                       NSLog(@"push结束");
                                   }];
}

- (IBAction)changeUserInfo:(id)sender {
    [WDUserContext shareContext].userModel.info.name = @"hello";
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
