//
//  YSPhotoBrowserCell.m
//  YSPhotoBrowser
//
//  Created by Joseph Gao on 2016/12/9.
//  Copyright © 2016年 Joseph. All rights reserved.
//

#import "YSPhotoBrowserCell.h"
#import "UIImageView+WebCache.h"
#import "YSPhotoBrowserMarco.h"

typedef void(^click)(NSSet *set,UIEvent *event);

@interface YSPhotoBrowserCell()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scaleScrollView;

@end

@implementation YSPhotoBrowserCell

-  (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _setupSubvews];
        [self _addTapGesture];

    }
    return self;
}


- (void)_setupSubvews {
    UIImage *placeholderImage = YS_PLACE_HOLDER_IMAGE;
    _imageView = [[UIImageView alloc] initWithImage:placeholderImage];
    _imageView.center = self.contentView.center;
    _imageView.userInteractionEnabled = YES;
    _imageView.bounds = CGRectMake(0, 0, placeholderImage.size.width, placeholderImage.size.height);
    [self.scaleScrollView addSubview:_imageView];
    
}


- (void)_addTapGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.contentView addGestureRecognizer:tap];
}


- (void)tapAction {
    if (self.tapAcionHandler) {
        self.tapAcionHandler();
    }
}


- (void)resetView{
    if (!self.scaleScrollView) {
        return;
    }
    self.imageView.transform = CGAffineTransformIdentity;
    self.imageView.center = self.contentView.center;
    self.scaleScrollView.contentOffset = CGPointZero;//还原偏移量
    self.scaleScrollView.contentSize   = CGSizeZero;//还原容量
}


- (void)setImgURL:(NSString *)imgURL {
    _imgURL = imgURL;
    UIImage *placeholderImage = YS_PLACE_HOLDER_IMAGE;
    _imageView.bounds = CGRectMake(0, 0, placeholderImage.size.width, placeholderImage.size.height);
    [_imageView sd_setImageWithURL:[NSURL URLWithString:imgURL]
                  placeholderImage:placeholderImage
                         completed:^(UIImage * _Nullable image,
                                     NSError * _Nullable error,
                                     SDImageCacheType cacheType,
                                     NSURL * _Nullable imageURL) {
        if (error == nil) {
            self.image = image;
        }
    }];
}


- (void)setImage:(UIImage *)image {
    _image = image;
    
    if (image == nil) return;
    [self resetImageViewWithImage:image];
}


- (void)resetImageViewWithImage:(UIImage *)image {
    CGFloat imgH = image.size.height;
    CGFloat imgW = image.size.width;
    
    // 如果图片尺寸有问题,直接显示
    if (imgH == 0 || imgW == 0) {
        self.imageView.image = YS_PLACE_HOLDER_IMAGE;
        return;
    }
    else {
        self.imageView.image = image;
    }
    
    if (image.size.width > YS_SCREEN_WIDTH || image.size.height > YS_SCREEN_HEIGHT) {
        BOOL b = (YS_SCREEN_HEIGHT/YS_SCREEN_WIDTH >= image.size.height/image.size.width);
        if (b) {
            CGFloat h = image.size.height/image.size.width * YS_SCREEN_WIDTH;
            _imageView.bounds = CGRectMake(0, 0, YS_SCREEN_WIDTH, h);
        }
        else {
            CGFloat w = image.size.width/image.size.height * YS_SCREEN_HEIGHT;
            _imageView.bounds = CGRectMake(0, 0, w, YS_SCREEN_HEIGHT);
        }

    }
    else {
        _imageView.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
//        _scaleScrollView.maximumZoomScale       = 2.0;
//        _scaleScrollView.minimumZoomScale       = 1.0;
    }
}



#pragma mark - UIScrollView Delegate

// 指定缩放视图
- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    NSLog(@"%s,zooming:%d",__func__,scrollView.zooming);
    return _imageView;
}

// 缩放时调用
- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    CGFloat xcenter = scrollView.center.x , ycenter = scrollView.center.y;
    xcenter = scrollView.contentSize.width  > scrollView.ys_width  ? scrollView.contentSize.width/2  : xcenter;
    ycenter = scrollView.contentSize.height > scrollView.ys_height ? scrollView.contentSize.height/2 : ycenter;
    [_imageView setCenter:CGPointMake(xcenter, ycenter)];
}



#pragma mark - Lazy Loading

- (UIScrollView *)scaleScrollView {
    if (!_scaleScrollView) {
        _scaleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                                          0,
                                                                          self.contentView.ys_width,
                                                                          self.contentView.ys_height)];
        _scaleScrollView.userInteractionEnabled = YES;
        _scaleScrollView.maximumZoomScale       = 2.0;
        _scaleScrollView.minimumZoomScale       = 1.0;
        _scaleScrollView.bouncesZoom            = YES;
        _scaleScrollView.contentSize            =  self.bounds.size;
        _scaleScrollView.delegate               = self;
        [self.contentView addSubview:_scaleScrollView];
    }
    return _scaleScrollView;
}




@end
