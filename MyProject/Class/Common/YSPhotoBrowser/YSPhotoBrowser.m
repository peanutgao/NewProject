//
//  YSPhotoBrowser.m
//  YSPhotoBrowser
//
//  Created by Joseph Gao on 2016/12/10.
//  Copyright © 2016年 Joseph. All rights reserved.
//

#import "YSPhotoBrowser.h"
#import "YSPhotoBrowserMarco.h"
#import "YSPhotoBrowserCell.h"
#import <Photos/Photos.h>


static NSString *const kPBCellReuseID = @"kPBCellReuseID";

@interface YSPhotoBrowser()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIImageView *delusionImgView;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UILabel *indexLabel;
@property (nonatomic, strong) UIButton *downloadBtn;

@property (nonatomic, assign) CGRect targetImageRect;
@property (nonatomic, strong) UIImageView *targetImgView;
@property (nonatomic, assign) NSInteger currentIdx;

/// 当前显示的图片
@property (nonatomic, strong) UIImageView *currentDImgView;

@end

@implementation YSPhotoBrowser

#pragma mark - Init


+ (instancetype)photoBrowserWithImagesCount:(NSUInteger)imagesCount {
    return [[self alloc] initWithImagesCount:imagesCount];
}


- (instancetype)initWithImagesCount:(NSUInteger)imagesCount {
    if (self = [super init]) {
        self.imagesCount = imagesCount;
    }
    return self;
}


-  (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:CGRectMake(-YS_OFFSET_X, 0, YS_SCREEN_WIDTH+YS_SPACE, YS_SCREEN_HEIGHT)]) {
        self.showDuration     = YS_DEFAULT_DURATION;
        self.dismissDuration  = YS_DEFAULT_DURATION;
        self.backgroundColor  = [UIColor clearColor];
        self.canDownloadImage = YES;
        
        [self _setupSubvews];
    }
    return self;
}



#pragma mark - Action

- (void)showPhotoBrowserWithClickedImgView:(UIImageView *)clickedImgView atIndex:(NSInteger)index {
    self.currentIdx = index;
    self.targetImgView = clickedImgView;
    
    [self scrollCollectionViewToShowingPhoto];
    [self showPhotoBrowserWithClickedImgView:clickedImgView];
}


- (void)scrollCollectionViewToShowingPhoto {
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIdx inSection:0]
                                atScrollPosition:UICollectionViewScrollPositionLeft
                                        animated:NO];
}


- (void)showPhotoBrowserWithClickedImgView:(UIImageView *)clickedImgView {
    if (self.delusionImgView.image) return;
    
    [YS_KEY_WINDOW addSubview:self];
    if (clickedImgView) {
        [self prepareDelusionImageViewByClickedImgView:clickedImgView];
    }
    [self doDelusionImageViewAnim];
}


- (void)doDelusionImageViewAnim {
    self.maskView.alpha = 1.0;
    
    CGFloat imgH = self.delusionImgView.image.size.height;
    CGFloat imgW = self.delusionImgView.image.size.width;
    
    // 如果图片尺寸有问题,直接显示
    if (imgH == 0 || imgW == 0) {
        [self showCollectionView];
        [self showTool];
        return;
    }
    
    BOOL b = (YS_SCREEN_HEIGHT/YS_SCREEN_WIDTH >= imgH/imgW);
    [UIView animateWithDuration:self.showDuration animations:^{
        self.delusionImgView.center = CGPointMake(YS_SCREEN_WIDTH * 0.5+5, YS_SCREEN_HEIGHT * 0.5);
        if (b) {
            CGFloat h = imgH/imgW * YS_SCREEN_WIDTH;
            self.delusionImgView.bounds = CGRectMake(0, 0, YS_SCREEN_WIDTH, h);
        } else {
            CGFloat w = imgW/imgH * YS_SCREEN_HEIGHT;
            self.delusionImgView.bounds = CGRectMake(0, 0, w, YS_SCREEN_HEIGHT);
        }
        
    } completion:^(BOOL finished) {
        [self showCollectionView];
        [self showTool];
    }];
}


- (void)showCollectionView {
    _collectionView.hidden = NO;
    [self bringSubviewToFront:_collectionView];
}


- (void)prepareDelusionImageViewByClickedImgView:(UIImageView *)clickedImgView {
    CGRect rect = [self covertPositionOfClickedImgView:clickedImgView];
    self.targetImageRect = rect;
    self.delusionImgView.frame = rect;
    self.delusionImgView.image = clickedImgView.image;
    self.delusionImgView.contentMode = clickedImgView.contentMode;
    self.delusionImgView.clipsToBounds = YES;
}


- (void)hiddenPhotoBrowser {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(photoBrowser:thumbImageViewForIndex:)]) {
        _collectionView.hidden = YES;
        
        [UIView animateWithDuration:self.dismissDuration animations:^{
            _maskView.alpha = 0.0;
            _delusionImgView.frame = _targetImageRect;
            
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
    else {
        self.delusionImgView.hidden = YES;
        [UIView animateWithDuration:self.dismissDuration animations:^{
            self.alpha = 0.0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}



#pragma mark -

- (CGRect)covertPositionOfClickedImgView:(UIImageView *)imgView {
    // imgView的父控件来转换
    CGRect rect = [imgView.superview convertRect:imgView.frame toView:nil];
    return CGRectMake(rect.origin.x + YS_OFFSET_X, rect.origin.y, rect.size.width, rect.size.height);
}


- (void)resetDelusionImgViewByshowImageView:(UIImageView *)imageView {
    self.delusionImgView.image = imageView.image;
    self.delusionImgView.frame = imageView.frame;
}


- (UIImageView *)targetImageViewAtIndex:(NSInteger)index {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(photoBrowser:thumbImageViewForIndex:)]) {
        UIImageView *targetImgV = [self.dataSource photoBrowser:self thumbImageViewForIndex:index];
        if ([targetImgV isKindOfClass:[UIImageView class]]) {
            return targetImgV;
        }
        return _targetImgView;
    }
    return _targetImgView;
}


- (void)showTool {
    _indexLabel.hidden = NO;
    _downloadBtn.hidden = !self.canDownloadImage;
    [self bringSubviewToFront:_indexLabel];
    [self bringSubviewToFront:_downloadBtn];
    
    NSInteger idx = self.imagesCount == 0 ? 0 : self.currentIdx + 1;
    [self updateIndexLabelDisplayWithIndex:idx];
}


- (void)hiddenTool {
    _indexLabel.hidden = YES;
    _downloadBtn.hidden = YES;
}


- (void)updateIndexLabelDisplayWithIndex:(NSInteger)index {
    _indexLabel.text = [NSString stringWithFormat:@"%zd/%zd", index, self.imagesCount];
}



#pragma mark - Save Image

- (void)saveImageToAlbum {
    UIImageWriteToSavedPhotosAlbum([self currentDisplayImage], self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}


- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        NSLog(@"保存图片失败");
    } else {
        NSLog(@"保存保存成功");
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(photoBrowser:downloadImage:atIndex:error:)]) {
        [self.delegate photoBrowser:self downloadImage:image atIndex:self.currentIdx error:error];
    }
}


- (UIImage *)currentDisplayImage {
    YSPhotoBrowserCell *cell = (YSPhotoBrowserCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIdx inSection:0]];
    UIImage *img = cell.imageView.image;
    return img;
}


#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imagesCount;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YSPhotoBrowserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPBCellReuseID
                                                                         forIndexPath:indexPath];
    id obj = [self imageOrURLStringOfIndex:indexPath.item];
    if ([obj isKindOfClass:[NSString class]]) {
        cell.imgURL = obj;
    }
    else if ([obj isKindOfClass:[UIImage class]]) {
        cell.image = obj;
    }
    
    cell.tapAcionHandler = ^(){
        [self doTapActionWithIndexPath:indexPath];
    };
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPat {
     YSPhotoBrowserCell *reCell = (YSPhotoBrowserCell *)cell;
     [reCell resetView];
}


- (id)imageOrURLStringOfIndex:(NSInteger)index {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(photoBrowser:imageOrURLStringForIndex:)]) {
        return [self.dataSource photoBrowser:self imageOrURLStringForIndex:index];
    }
    return nil;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger idx = scrollView.contentOffset.x/(YS_SCREEN_WIDTH+YS_SPACE) + 1;
    self.currentIdx = idx;
    [self updateIndexLabelDisplayWithIndex:idx];
}


- (void)doTapActionWithIndexPath:(NSIndexPath *)indexPath {
    YSPhotoBrowserCell *cell = (YSPhotoBrowserCell *)[_collectionView cellForItemAtIndexPath:indexPath];
    if (self.delegate && [self.delegate respondsToSelector:@selector(photoBrowser:didClickedImage:atIndex:)]) {
        [self.delegate photoBrowser:self didClickedImage:cell.imageView.image atIndex:indexPath.item];
    }
    
    // 获取要返回的目标imageView
    _targetImgView = [self targetImageViewAtIndex:indexPath.item];
    _targetImageRect = [self covertPositionOfClickedImgView:_targetImgView];
    // 重新设置动画imageView属性
    [self resetDelusionImgViewByshowImageView:cell.imageView];
    // 隐藏toolBar
    [self hiddenTool];
    // 隐藏photoBrowser
    [self hiddenPhotoBrowser];

}


#pragma mark - Setter

- (void)setShowDuration:(CGFloat)showDuration {
    if (showDuration < 0) {
        showDuration = YS_DEFAULT_DURATION;
    }
    _showDuration = showDuration;
}


- (void)setDismissDuration:(CGFloat)dismissDuration {
    if (dismissDuration < 0) {
        dismissDuration = YS_DEFAULT_DURATION;
    }
    _dismissDuration = dismissDuration;
}


- (void)setCanDownloadImage:(BOOL)canDownloadImage {
    _canDownloadImage = canDownloadImage;
    self.downloadBtn.hidden = !canDownloadImage;
}



#pragma mark - Setup UI

- (void)_setupSubvews {
    [self setupCollectionView];
    [self setupIndexLabel];
    [self setupDownloadBtn];
}


- (void)setupCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = self.bounds.size;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.hidden = YES;
    _collectionView.backgroundColor = YS_BACKGROUND_COLOR;
    [self addSubview:_collectionView];
    
    [_collectionView registerClass:[YSPhotoBrowserCell class] forCellWithReuseIdentifier:kPBCellReuseID];
}


- (void)setupIndexLabel {
    _indexLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, YS_SCREEN_HEIGHT - 48, YS_SCREEN_WIDTH, 30)];
    _indexLabel.textColor = [UIColor whiteColor];
    _indexLabel.font = [UIFont systemFontOfSize:15];
    _indexLabel.textAlignment = NSTextAlignmentCenter;
    _indexLabel.text = @"0/0";
    _indexLabel.hidden = YES;
    [self addSubview:_indexLabel];
}


- (void)setupDownloadBtn {
    _downloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _downloadBtn.ys_centerY = _indexLabel.ys_centerY;
    _downloadBtn.ys_right = YS_SCREEN_WIDTH - 20;
    _downloadBtn.bounds = CGRectMake(0, 0, 50, 50);
    UIImage *img = YS_DOWNLOAD_IMAGE;
    [_downloadBtn setImage:img forState:UIControlStateNormal];
    [_downloadBtn addTarget:self action:@selector(saveImageToAlbum) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_downloadBtn];
}



#pragma mark - Lazy Loading

- (UIImageView *)delusionImgView {
    if (!_delusionImgView) {
        _delusionImgView = [[UIImageView alloc] init];
        [self insertSubview:_delusionImgView belowSubview:_collectionView];
    }
    return _delusionImgView;
}


- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:self.bounds];
        _maskView.backgroundColor = YS_BACKGROUND_COLOR;
        _maskView.alpha = 0.0;
        [self insertSubview:_maskView belowSubview:_delusionImgView];
    }
    return _maskView;
}


@end
