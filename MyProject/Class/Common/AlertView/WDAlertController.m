//
//  WDAlertController.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/13.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDAlertController.h"
#import "WDAlertAnimator.h"

#define CV_WIDTH self.containerView.frame.size.width

CGFloat const kUDMargin = 15.0;
CGFloat const kSideMargin = 30.0;
CGFloat const kActionHeight = 40.0;

@interface WDAlertController ()

@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UIView *maskView;

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIView *actionsContainerView;

@property (nonatomic, strong) NSMutableArray *actions;
@property (nonatomic, strong) NSMutableArray *actionBtns;
@property (nonatomic, strong) WDAlertAnimator *alertAnimator;

@end

@implementation WDAlertController


#pragma mark - Initialize

- (instancetype)init {
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    [self setupSubViews];
    [self setupActionButtons];
}


- (void)initialize {
    self.alertAnimator = [[WDAlertAnimator alloc] init];
    
    self.modalPresentationStyle = UIModalPresentationCustom;
    self.transitioningDelegate = self.alertAnimator;
}

+ (instancetype)alertControllerWithTitle:(NSString *)title
                                 message:(NSString *)message
                          preferredStyle:(WDAlertControllerStyle)preferredStyle {
    WDAlertController *alert = [[WDAlertController alloc] init];
    alert.title = title;
    alert.message = message;
    alert.preferredStyle = preferredStyle;
    return alert;
}


#pragma mark - Action

- (void)addAction:(WDAlertAction *)action {
    if (action == nil) return;
    
    [self.actions addObject:action];
    [self.actionBtns addObject:[self creatActionBtnWithAlertAction:action]];
}

- (void)clickActionBtn:(UIButton *)actionBtn {
    WDAlertAction *action = [self.actions objectAtIndex:[self.actionBtns indexOfObject:actionBtn]];
    if (action.alertAction) {
        action.alertAction(action);
    }
    
    [self dismissAlertViewController];
}

- (void)dismissAlertViewController {
    [self dismissViewControllerAnimated:YES completion:NULL];
}


#pragma mark - UI

- (void)setupSubViews {
    // mask View
    _maskView = [[UIView alloc] initWithFrame:self.view.bounds];
    _maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    _maskView.tag = 1027;
    [self.view addSubview:_maskView];
    
    if (self.preferredStyle == WDAlertControllerStyleActionSheet) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(dismissAlertViewController)];
        [_maskView addGestureRecognizer:tap];
    }
    
    // containerView
    _containerView = [[UIView alloc] init];
    _containerView.backgroundColor = [UIColor yellowColor];
    _containerView.layer.cornerRadius = 5.0;
    _containerView.clipsToBounds = YES;
    _containerView.tag = 1028;
    [self.view addSubview:_containerView];
    
    // title Label
    _titleLabel = [self creatLabelWithTitle:self.title
                                   fontSize:16.0
                                  textColor:[UIColor redColor]
                                     inView:_containerView];
    
    
    // message Label
    _messageLabel = [self creatLabelWithTitle:self.message
                                     fontSize:14.0
                                    textColor:[UIColor blueColor]
                                       inView:_containerView];
    
    // actionsContainerView
    _actionsContainerView = [[UIView alloc] init];
    [_containerView addSubview:_actionsContainerView];

    
    CGFloat w = [UIScreen mainScreen].bounds.size.width - kSideMargin * 2;
    
    
    CGSize tSize = [_titleLabel sizeThatFits:CGSizeMake(w, CGFLOAT_MAX)];
    _titleLabel.frame = CGRectMake(0, kUDMargin, w, tSize.height);
    
    CGSize mSize = [_messageLabel sizeThatFits:CGSizeMake(w, CGFLOAT_MAX)];
    _messageLabel.frame = CGRectMake(0,
                                     CGRectGetMaxY(_titleLabel.frame) + 10.0,
                                     w,
                                     mSize.height);
    
    
    switch (self.preferredStyle) {
        case WDAlertControllerStyleAlert: {
            _containerView.center = self.view.center;
            _containerView.bounds = CGRectMake(0, 0, w, CGRectGetMaxY(_messageLabel.frame));
            break;
        }
        case WDAlertControllerStyleActionSheet: {
            _containerView.frame = CGRectMake(kSideMargin,
                                              [UIScreen mainScreen].bounds.size.height,
                                              w,
                                              CGRectGetMaxY(_messageLabel.frame));
            break;
        }
            
        default:
            break;
    }
}

- (void)setupActionButtons {
    switch (self.preferredStyle) {
        case WDAlertControllerStyleAlert: {
            [self prepareAlertStyleLayout];
            break;
        }
        case WDAlertControllerStyleActionSheet: {
            [self prepareActionSheetStyleLayout];
            break;
        }
        default:
            break;
    }
}

- (void)prepareActionSheetStyleLayout {
    __block UIButton *preBtn = nil;
    __block CGFloat y = CGRectGetMaxY(_messageLabel.frame);
    
    [self.actionBtns enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.containerView addSubview:obj];
        [self setupActionBtnEnable:obj withAction:self.actions[idx]];
        
        obj.frame = CGRectMake(0, y, CV_WIDTH, kActionHeight);
        y = CGRectGetMaxY(obj.frame);
        
        preBtn = obj;
    }];

    CGFloat totalH = CGRectGetMaxY(preBtn.frame);
    _containerView.frame = CGRectMake(_containerView.frame.origin.x,
                                      [UIScreen mainScreen].bounds.size.height - totalH,
                                      CV_WIDTH,
                                      totalH);
}

- (void)prepareAlertStyleLayout {
    __block UIButton *preBtn = nil;
    __block UIView *bottomView = nil;
    __block CGFloat y = CGRectGetMaxY(_messageLabel.frame);

    if (self.actionBtns.count <= 0) {
        bottomView = _messageLabel;
    }
    else if (self.actionBtns.count == 1) {
        UIButton *obj = self.actionBtns.firstObject;
        obj.frame = CGRectMake(0, y, CV_WIDTH, kActionHeight);
        [self.containerView addSubview:obj];
        [self setupActionBtnEnable:obj withAction:self.actions[0]];
        
        bottomView = obj;
    }
    else if (self.actionBtns.count == 2) {
        __block CGFloat x = 0;
        [self.actionBtns enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.containerView addSubview:obj];
            [self setupActionBtnEnable:obj withAction:self.actions[idx]];
            
            if (preBtn) x = CGRectGetMaxX(preBtn.frame);
            obj.frame = CGRectMake(x, y, CV_WIDTH * 0.5, kActionHeight);
            
            bottomView = obj;
        }];
    }
    else {
        [self.actionBtns enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.containerView addSubview:obj];
            [self setupActionBtnEnable:obj withAction:self.actions[idx]];
            
            obj.frame = CGRectMake(0, y, CV_WIDTH, kActionHeight);
            y = CGRectGetMaxY(obj.frame) + 1;
            bottomView = obj;
        }];
    }
    
    // 重新设置容器的尺寸
    _containerView.bounds = CGRectMake(0, 0, CV_WIDTH, CGRectGetMaxY(bottomView.frame) + kUDMargin);
}

- (void)setupActionBtnEnable:(UIButton *)btn withAction:(WDAlertAction *)action {
    btn.enabled = action.isEnabled;
}

- (UILabel *)creatLabelWithTitle:(NSString *)title
                        fontSize:(CGFloat)fontSize
                       textColor:(UIColor *)color
                          inView:(UIView *)inView {
    UILabel *l = [[UILabel alloc] init];
    l.text = title;
    l.font = [UIFont systemFontOfSize:fontSize];
    l.textColor = color ?: [UIColor blackColor];
    l.textAlignment = NSTextAlignmentCenter;
    l.numberOfLines = 0;
    
    if (inView && [inView isKindOfClass:[UIView class]]) [inView addSubview:l];
    
    return l;
}

- (UIButton *)creatActionBtnWithAlertAction:(WDAlertAction *)action  {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:action.title forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickActionBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIColor *titleColor = [UIColor blackColor];
    UIColor *bcColor = [UIColor whiteColor];
    switch (action.style) {
        case WDAlertActionStyleDefault: {
            titleColor = [UIColor blackColor];
            bcColor = [UIColor whiteColor];
            break;
        }
        case WDAlertActionStyleCancel: {
            titleColor = [UIColor whiteColor];
            bcColor = [UIColor blueColor];
            break;
        }
        case WDAlertActionStyleDestructive: {
            titleColor = [UIColor whiteColor];
            bcColor = [UIColor redColor];
            break;
        }
        default:
            break;
    }
    
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.backgroundColor = bcColor;
    
    return btn;
}



#pragma mark - Lazy Loading

- (NSMutableArray *)actions {
    if (!_actions) {
        _actions = [NSMutableArray array];
    }
    return _actions;
}

- (NSMutableArray *)actionBtns {
    if (!_actionBtns) {
        _actionBtns = [NSMutableArray array];
    }
    return _actionBtns;
}


#pragma mark - Other

- (void)dealloc {
    
}
@end

