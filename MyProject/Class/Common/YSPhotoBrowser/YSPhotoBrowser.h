//
//  YSPhotoBrowser.h
//  YSPhotoBrowser
//
//  Created by Joseph Gao on 2016/12/10.
//  Copyright © 2016年 Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YSPhotoBrowser;
@protocol YSPhotoBrowserDatasource <NSObject>

@required

/**
 YSPhotoBrowser 数据源方法, 必须实现!
 返回可以是UIImage类型的对象, 也可以是图片URL NSString对象

 @param photoBrowser YSPhotoBrowser 对象
 @param index 对应索引的UIImage或者image链接
 @return UIImage类型的对象, 或者图片URL NSString对象
 */
- (id)photoBrowser:(YSPhotoBrowser *)photoBrowser imageOrURLStringForIndex:(NSInteger)index;

@optional

/**
 小图UIImageView, 非必选
 如果实现了, 消失时会返回到小图图片的原始位置
 如果没有实现, 则会渐变消失, `不会`返回到原始位置

 @param photoBrowser SPhotoBrowser 对象
 @param index 小图索引
 @return 小图的UIImageView对象
 */
- (UIImageView *)photoBrowser:(YSPhotoBrowser *)photoBrowser thumbImageViewForIndex:(NSInteger)index;

@end


@protocol YSPhotoBrowserDelegate <NSObject>

@optional
- (void)photoBrowser:(YSPhotoBrowser *)photoBrowser didClickedImage:(UIImage *)image atIndex:(NSInteger)index;

- (void)photoBrowser:(YSPhotoBrowser *)photoBrowser downloadImage:(UIImage *)image atIndex:(NSInteger)index error:(NSError *)error;

@end

@interface YSPhotoBrowser : UIView

@property (nonatomic, assign) NSInteger imagesCount;
@property (nonatomic, assign) CGFloat showDuration;
@property (nonatomic, assign) CGFloat dismissDuration;
@property (nonatomic, assign, getter=isCanDownloadImage) BOOL canDownloadImage;

@property (nonatomic, weak) id<YSPhotoBrowserDatasource> dataSource;
@property (nonatomic, weak) id<YSPhotoBrowserDelegate> delegate;

- (instancetype)initWithImagesCount:(NSUInteger)imagesCount;
+ (instancetype)photoBrowserWithImagesCount:(NSUInteger)imagesCount;

- (void)showPhotoBrowserWithClickedImgView:(UIImageView *)clickedImgView atIndex:(NSInteger)index;

@end
