//
//  YSPhotoBrowserMarco.h
//  YSPhotoBrowser
//
//  Created by Joseph Gao on 2016/12/9.
//  Copyright © 2016年 Joseph. All rights reserved.
//

#ifndef YSPhotoBrowserMarco_h
#define YSPhotoBrowserMarco_h

#import "UIView+FrameExt.h"

#define YS_KEY_WINDOW       [UIApplication sharedApplication].keyWindow
#define YS_SCREEN_BOUNDS    [UIScreen mainScreen].bounds
#define YS_SCREEN_WIDTH     [UIScreen mainScreen].bounds.size.width
#define YS_SCREEN_HEIGHT    [UIScreen mainScreen].bounds.size.height

#define YS_BACKGROUND_COLOR [UIColor blackColor]
//#define YS_BACKGROUND_COLOR [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1]

#define YS_BUNDLE_IMAGE(imageName) ({\
                                    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"YSPhotoBrowser.bundle" ofType:nil];\
                                    NSBundle *sourceBundle = [NSBundle bundleWithPath:bundlePath];\
                                    NSString *iconPath = [sourceBundle pathForResource:imageName ofType:nil];\
                                    UIImage *icon = [UIImage imageWithContentsOfFile:iconPath];\
                                    icon;\
                                    });

#define YS_PLACE_HOLDER_IMAGE YS_BUNDLE_IMAGE(@"ys_photoBrowser_image@2x.png")
#define YS_DOWNLOAD_IMAGE YS_BUNDLE_IMAGE(@"ys_pb_download_icon@2x.png")


#define YS_SPACE 10.0
#define YS_OFFSET_X YS_SPACE * 0.5
#define YS_DEFAULT_DURATION 0.25

#endif /* YSPhotoBrowserMarco_h */
