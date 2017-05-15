//
//  WDRefreshGifHeader.m
//  HCPatient
//
//  Created by ZJW on 2016/12/15.
//  Copyright © 2016年 ZJW. All rights reserved.
//

#import "WDRefreshGifHeader.h"

@interface WDRefreshGifHeader() {
    __unsafe_unretained UIImageView *_gifView;
}

/** 所有状态对应的动画图片 */
@property (strong, nonatomic) NSMutableDictionary *stateImages;
/** 所有状态对应的动画时间 */
@property (strong, nonatomic) NSMutableDictionary *stateDurations;

@end

@implementation WDRefreshGifHeader


#pragma mark - 公共方法

- (void)setImages:(NSArray *)images forState:(MJRefreshState)state {
    [self setImages:images duration:images.count * 0.1 forState:state];
}

- (void)setImages:(NSArray *)images duration:(NSTimeInterval)duration forState:(MJRefreshState)state {
    if (images == nil) return;
    
    self.stateImages[@(state)] = images;
    self.stateDurations[@(state)] = @(duration);
    
    /* 根据图片设置控件的高度 */
    UIImage *image = [images firstObject];
    if (image.size.height + 20 > self.mj_h) {
        self.mj_h = image.size.height + 20;
    }
}

#pragma mark - 实现父类的方法

- (void)prepare {
    [super prepare];
    
    // 初始化间距
    self.labelLeftInset = 20;
}

- (void)setPullingPercent:(CGFloat)pullingPercent {
    [super setPullingPercent:pullingPercent];
    NSArray *images = self.stateImages[@(MJRefreshStateIdle)];
    if (self.state != MJRefreshStateIdle || images.count == 0) return;
    // 停止动画
    [self.gifView stopAnimating];
    // 设置当前需要显示的图片
    NSUInteger index =  images.count * pullingPercent;
    if (index >= images.count) index = images.count - 1;
    self.gifView.image = images[index];
}

- (void)placeSubviews {
    [super placeSubviews];
    
    if (self.stateLabel.hidden) return;
    self.stateLabel.textAlignment = NSTextAlignmentLeft;
    self.lastUpdatedTimeLabel.textAlignment = NSTextAlignmentLeft;
    
    BOOL noConstrainsOnStatusLabel = self.stateLabel.constraints.count == 0;
    
    if (self.lastUpdatedTimeLabel.hidden) {
        if (noConstrainsOnStatusLabel) self.stateLabel.frame = self.bounds;
    } else {
        CGFloat stateLabelH = 14;
        if (noConstrainsOnStatusLabel) {
            self.stateLabel.mj_x = (self.mj_w - 80)/2.0;
            self.stateLabel.mj_y = 20;
            self.stateLabel.mj_w = 80;
            self.stateLabel.mj_h = stateLabelH;
        }
        
        // 更新时间
        if (self.lastUpdatedTimeLabel.constraints.count == 0) {
            self.lastUpdatedTimeLabel.mj_x = self.stateLabel.mj_x;
            self.lastUpdatedTimeLabel.mj_y = self.stateLabel.mj_y+stateLabelH+5;
            self.lastUpdatedTimeLabel.mj_w = self.mj_w - self.stateLabel.mj_x;
            self.lastUpdatedTimeLabel.mj_h = stateLabelH;
        }
    }
    
    if (self.gifView.constraints.count) return;

    self.gifView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-20);
    if (self.stateLabel.hidden && self.lastUpdatedTimeLabel.hidden) {
        self.gifView.contentMode = UIViewContentModeCenter;
    }
    else {
        self.gifView.contentMode = UIViewContentModeRight;
        
        CGFloat stateWidth = self.stateLabel.mj_textWith;
        CGFloat timeWidth = 0.0;
        if (!self.lastUpdatedTimeLabel.hidden) {
            timeWidth = self.lastUpdatedTimeLabel.mj_textWith;
        }
        CGFloat textWidth = MAX(stateWidth, timeWidth);
        self.gifView.mj_w = self.mj_w * 0.5 - textWidth * 0.5 - self.labelLeftInset;
        self.gifView.mj_x = self.mj_w - self.lastUpdatedTimeLabel.mj_w - self.gifView.mj_w - 12;
        self.gifView.mj_y = 10;
    }
}

- (void)setState:(MJRefreshState)state {
    MJRefreshCheckState
    
    // 根据状态做事情
    if (state == MJRefreshStatePulling || state == MJRefreshStateRefreshing) {
        NSArray *images = self.stateImages[@(state)];
        if (images.count == 0) return;
        
        [self.gifView stopAnimating];
        if (images.count == 1) { // 单张图片
            self.gifView.image = [images lastObject];
        } else { // 多张图片
            self.gifView.animationImages = images;
            self.gifView.animationDuration = [self.stateDurations[@(state)] doubleValue];
            [self.gifView startAnimating];
        }
    } else if (state == MJRefreshStateIdle) {
        [self.gifView stopAnimating];
    }
}


#pragma mark - 懒加载

- (UIImageView *)gifView {
    if (!_gifView) {
        UIImageView *gifView = [[UIImageView alloc] init];
        [self addSubview:_gifView = gifView];
    }
    return _gifView;
}

- (NSMutableDictionary *)stateImages {
    if (!_stateImages) {
        self.stateImages = [NSMutableDictionary dictionary];
    }
    return _stateImages;
}

- (NSMutableDictionary *)stateDurations {
    if (!_stateDurations) {
        self.stateDurations = [NSMutableDictionary dictionary];
    }
    return _stateDurations;
}

@end
