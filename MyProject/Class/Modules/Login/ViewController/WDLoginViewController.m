//
//  WDLoginViewController.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/8.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDLoginViewController.h"
#import "WDLoginViewModel.h"

@interface WDLoginViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) WDLoginViewModel *viewModel;

@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UITextField *pwdField;
@property (nonatomic, strong) UIButton *loginBtn;

@end

@implementation WDLoginViewController


#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"登陆";
}


#pragma mark - Bind

- (void)bindViewModel {
    self.viewModel = [[WDLoginViewModel alloc] init];

    RAC(self.viewModel, userName) = RACObserve(self.nameField, text);
    RAC(self.viewModel, password) = RACObserve(self.pwdField, text);
    
    [[self.viewModel.loginCommand.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        NSLog(@"-----");
    } error:^(NSError * _Nullable error) {
        NSLog(@"--");
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

#pragma mark - Initialize

- (void)setupSubviews {
    self.nameField = [UITextField textFieldWithText:@"18601603757"
                                          textColor:[UIColor blackColor]
                                           fontSize:14.0
                                        andDelegate:self
                                             inView:self.view];
    self.nameField.backgroundColor = [UIColor yellowColor];
    
    self.pwdField = [UITextField textFieldWithText:@"888888"
                                          textColor:[UIColor blackColor]
                                           fontSize:14.0
                                        andDelegate:self
                                             inView:self.view];
    self.pwdField.backgroundColor = [UIColor yellowColor];
    
    WEAKIFLY_SELF
    self.loginBtn = [UIButton buttonWithNormalImgName:nil
                                              bgColor:[UIColor redColor]
                                               inView:self.view
                                               action:^(UIButton *btn) {
                                                   STRONGIFY_SELF
                                                   [self.viewModel.loginCommand execute:@1];

                                               }];

}

- (void)setupSubviewsLayout {
    [self.nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(100.0);
        make.left.offset(50.0);
        make.right.offset(-50.0);
        make.height.mas_equalTo(40.0);
    }];
    
    [self.pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(self.nameField);
        make.top.equalTo(self.nameField.mas_bottom).offset(35.0);
    }];
    
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.top.offset(250);
        make.centerX.equalTo(self.view);
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

#pragma mark - Lazy Loading


@end
