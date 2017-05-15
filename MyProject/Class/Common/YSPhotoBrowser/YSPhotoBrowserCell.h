//
//  YSPhotoBrowserCell.h
//  YSPhotoBrowser
//
//  Created by Joseph Gao on 2016/12/9.
//  Copyright © 2016年 Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>

#define YS_BUNDLE_IMAGE(imageName) ({\
                                    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"YSPhotoBrowser.bundle" ofType:nil];\
                                    NSBundle *sourceBundle = [NSBundle bundleWithPath:bundlePath];\
                                    NSString *iconPath = [sourceBundle pathForResource:imageName ofType:nil];\
                                    UIImage *icon = [UIImage imageWithContentsOfFile:iconPath];\
                                    icon;\
                                    });


@interface YSPhotoBrowserCell : UICollectionViewCell

@property (nonatomic, copy) NSString *imgURL;
@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, copy) void(^tapAcionHandler)(void);

- (void)resetView;

@end
