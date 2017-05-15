//
//  WDShareView.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/10.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDShareView.h"
#import "WDShareViewModel.h"

@interface WDShareView ()

@property (nonatomic, strong) UILabel *shareTitleLabel;
@property (nonatomic, strong) UIView *shareTitleLine;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIView *cancelTopLine;
@property (nonatomic, strong) UIScrollView *contentScrollView;

@property (nonatomic, strong) WDShareViewModel *viewModel;
@end

@implementation WDShareView

-  (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.shadowColor = [UIColor grayColor].CGColor;
        self.layer.shadowOpacity = 0.3;
        
        [self setupSubvews];
        [self setupSubvewsLayout];
        [self bind];
    }
    
    return self;
}

- (void)bind {
    self.viewModel = [[WDShareViewModel alloc] init];
    self.dismissSubject = [RACSubject subject];
    self.itemClickedSubject = [RACSubject subject];
    
    @weakify(self);
    [[[RACObserve(self.viewModel, platformArray) distinctUntilChanged]
      filter:^BOOL(NSArray * _Nullable value) {
        return value.count > 0;
    }]
     subscribeNext:^(NSArray<WDShareItemModel *> * _Nullable x) {
        @strongify(self);
        CGFloat sideMargin = 15.0;
        CGFloat padding = 15.0;
        CGFloat w = 75.0;
        CGFloat h = 90.0;
        [x enumerateObjectsUsingBlock:^(WDShareItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *item = [UIButton buttonWithTitle:obj.title
                                            titleColor:[UIColor redColor]
                                              fontSize:14.0
                                         normalImgName:obj.icon
                                               bgColor:nil
                                                inView:self.contentScrollView
                                                action:^(UIButton *btn) {
                                                    @strongify(self);
                                                    [self.itemClickedSubject sendNext:@(obj.shareType)];
                                                }];
            [item setImagePositionStyle:ImagePositionStyleTop imageTitleMargin:10];
            
            item.bounds = CGRectMake(0, 0, w, h);
            CGFloat centerX = sideMargin + w * 0.5 + (w + padding) * idx;
            item.center = CGPointMake(centerX, self.contentScrollView.height * 0.5);
            
        }];
         
         // 设置ScrollView的contentSize
         CGFloat totalSize = padding + (padding + w) * x.count;
         self.contentScrollView.contentSize = CGSizeMake(totalSize, 0);
    }];
}

- (void)setupSubvews {
    self.shareTitleLine = [UIView viewWithBackgroundColor:[UIColor redColor] inView:self];
    self.shareTitleLabel = [UILabel labelWithText:@"分享"
                                        textColor:[UIColor blackColor]
                                    textAlignment:NSTextAlignmentCenter
                                         fontSize:16.0
                                  backgroundColor:[UIColor whiteColor]
                                           inView:self
                                        tapAction:NULL];
    self.cancelTopLine = [UIView viewWithBackgroundColor:[UIColor redColor] inView:self];
    WEAKIFLY_SELF
    self.cancelBtn = [UIButton buttonWithTitle:@"取消"
                                    titleColor:[UIColor lightGrayColor]
                                      fontSize:16.0
                                       bgColor:nil
                                        inView:self
                                        action:^(UIButton *btn) {
                                            STRONGIFY_SELF;
                                            [self.dismissSubject sendNext:btn];
                                        }];
    
    self.contentScrollView = [[UIScrollView alloc] init];
    self.contentScrollView.backgroundColor = [UIColor yellowColor];
    self.contentScrollView.showsVerticalScrollIndicator = NO;
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.contentScrollView];
}

- (void)setupSubvewsLayout {
    CGFloat leftMargin = 55.0;
    CGFloat topMargin = 50.0;
    self.shareTitleLine.bounds = CGRectMake(0, 0, self.width - leftMargin * 2, 1.0);
    self.shareTitleLine.center = CGPointMake(self.width * 0.5, topMargin);
    
    self.shareTitleLabel.center = self.shareTitleLine.center;
    self.shareTitleLabel.bounds = CGRectMake(0, 0, 100.0, 35.0);
    
    self.contentScrollView.center = CGPointMake(self.width * 0.5, self.height * 0.5);
    self.contentScrollView.bounds = CGRectMake(0, 0, self.width, 150.0);
    
    self.cancelBtn.bounds = CGRectMake(0, 0, 100.0, 35.0);
    self.cancelBtn.bottom = self.height - 20.0;
    self.cancelBtn.centerX = self.width * 0.5;
    
    self.cancelTopLine.bounds = CGRectMake(0, 0, self.width - 15.0 * 2, 1.0);    // 15.0 两边边间距
    self.cancelTopLine.center = CGPointMake(self.width * 0.5, self.cancelBtn.y-1);
}


@end
