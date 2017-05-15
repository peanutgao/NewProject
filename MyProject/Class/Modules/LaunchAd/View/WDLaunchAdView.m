//
//  WDLaunchAdView.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/2.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDLaunchAdView.h"
#import "WDLaunchAdViewModel.h"


@interface WDLaunchAdView ()

@property (nonatomic, strong) UIImageView *adImgView;
@property (nonatomic, strong) UIButton *jumpBtn;
@property (nonatomic, strong) WDLaunchAdViewModel *viewModel;

@end

@implementation WDLaunchAdView

- (void)bindWithViewModel:(WDBaseViewModel *)vm {
    if ([vm isKindOfClass:[WDLaunchAdViewModel class]]) {
        self.viewModel = (WDLaunchAdViewModel *)vm;
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        self.backgroundColor = [UIColor whiteColor];
        self.viewModel = [[WDLaunchAdViewModel alloc] init];
        
        [self setupSubvews];
        [self setupSubvewsLayout];
        [self bind];
    }
    return self;
}

- (void)bind {
    RAC(self.adImgView, image) = RACObserve(self.viewModel, adImage);
    
    @weakify(self);
    self->_showCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        [self show];
        return [RACSignal empty];
    }];
}

- (void)setupSubvews {
    WEAKIFLY_SELF
    self.adImgView = [UIImageView imageViewWithImageName:nil
                                                  inView:self
                                               tapAction:^(UIImageView *imgView, UIGestureRecognizer *tap) {
                                                   STRONGIFY_SELF
                                                   [self.viewModel.clickAdCommand execute:@1];
                                               }];
    self.jumpBtn = [UIButton buttonWithTitle:nil
                                  titleColor:[UIColor redColor]
                                    fontSize:13.0
                                     bgColor:[UIColor blueColor]
                                      inView:self
                                      action:^(UIButton *btn) {
                                          STRONGIFY_SELF
                                          [self dismiss];
                                      }];
}

- (void)setupSubvewsLayout {
    [self.adImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.jumpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 35));
        make.top.offset(40.0);
        make.right.offset(-40.0);
    }];
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    @weakify(self);
    [self.jumpBtn startCountDownWithLimitedTime:5
                                 normalTitle:@"跳过"
                                waitingTitle:@"跳过"
                               waitingEnable:YES
                                finishAction:^() {
                                    @strongify(self);
                                    [self dismiss];
                                }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
