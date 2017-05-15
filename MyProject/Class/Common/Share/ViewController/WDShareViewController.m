//
//  WDShareViewController.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/10.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDShareViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WeiboSDK.h"


#define SHARE_VIEW_HEIGHT 300.0

typedef NS_ENUM(NSInteger, WDShareType) {
    WDShareTypeWechat,
    WDShareTypeMoment,
    WDShareTypeQQ,
    WDShareTypeWeibo
};



@interface WDShareViewController ()


@end

@implementation WDShareViewController

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    [self setupSubviews];
    [self bind];
}

- (void)bind {
    @weakify(self);
    [self.shareView.dismissSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self dismissViewControllerAnimated:YES completion:NULL];
    }];
    
    
    [self.shareView.itemClickedSubject subscribeNext:^(NSNumber * _Nullable x) {
        @strongify(self);
        [self doActionWithShareType:[x integerValue]];
    }];
}


#pragma mark - Action

- (void)doActionWithShareType:(WDShareType)shareType {
    id image = [NSURL URLWithString:self.shareModel.thumb];
    if (self.shareModel.image) image = self.shareModel.image;
    
    switch (shareType) {
        case WDShareTypeWechat:
            [self shareToWechatWithImage:image];
            break;
        case WDShareTypeMoment:
            [self shareToMomentWithImage:image];
            break;
        case WDShareTypeQQ:
            [self shareToQQWithImage:image];
            break;
        case WDShareTypeWeibo:
            [self shareToWeiboWithImage:image];
            break;
        default:
            break;
    }
}


#pragma mark - Share

/// 分享微信好友
- (void)shareToWechatWithImage:(UIImage *)image {
    [self shareToTencentWithType:SSDKPlatformSubTypeWechatSession image:image];
}

/// 分享微信朋友圈
- (void)shareToMomentWithImage:(UIImage *)image {
    [self shareToTencentWithType:SSDKPlatformSubTypeWechatTimeline image:image];
}

/// 分享QQ好友
- (void)shareToQQWithImage:(UIImage *)image {
    [self shareToTencentWithType:SSDKPlatformSubTypeQQFriend image:image];
}

- (void)shareToTencentWithType:(SSDKPlatformType)platformType image:(UIImage *)image {
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupWeChatParamsByText:self.shareModel.brief
                                       title:self.shareModel.title
                                         url:[NSURL URLWithString:self.shareModel.shareUrl]
                                  thumbImage:self.shareModel.thumb
                                       image:image musicFileURL:nil
                                     extInfo:nil
                                    fileData:nil
                                emoticonData:nil
                                        type:SSDKContentTypeAuto
                          forPlatformSubType:platformType];
    
    [ShareSDK share:platformType
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         [self sendResultSignalWithState:state];
     }];
}


/// 分享新浪微博
- (void)shareToWeiboWithImage:(UIImage *)image {
    [ShareSDK cancelAuthorize:SSDKPlatformTypeSinaWeibo];
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKEnableUseClientShare];
    
    SSDKContentType type = SSDKContentTypeAuto;
    if ([WeiboSDK isWeiboAppInstalled] && self.shareModel.shareUrl.length > 0) {
        type = SSDKContentTypeWebPage;
    }
    else{
        self.shareModel.brief = [self.shareModel.brief stringByAppendingString:self.shareModel.shareUrl];
        
    }

    [shareParams SSDKSetupSinaWeiboShareParamsByText:self.shareModel.brief
                                               title:self.shareModel.title
                                               image:image
                                                 url:[NSURL URLWithString:self.shareModel.shareUrl]
                                            latitude:0
                                           longitude:0
                                            objectID:nil
                                                type:type];
    
    [ShareSDK share:SSDKPlatformTypeSinaWeibo
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         [self sendResultSignalWithState:state];
     }];

}


- (void)sendResultSignalWithState:(SSDKResponseState)state {
    switch (state) {
        case SSDKResponseStateSuccess: {
            [self.resultSignal sendNext:@"分享成功"];
            [self.resultSignal sendCompleted];
            break;
        }
        case SSDKResponseStateFail: {
            [self.resultSignal sendNext:@"分享失败"];
            [self.resultSignal sendCompleted];
            break;
        }
        case SSDKResponseStateCancel: {
            [self.resultSignal sendNext:@"取消分享"];
            [self.resultSignal sendCompleted];
            break;
        }
        default:
            break;
    }
}


#pragma mark - Initialize

- (void)setupSubviews {
    self.maskView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    self.maskView.alpha = 0;
    [self.view addSubview:self.maskView];
    
    
    self.shareView = [[WDShareView alloc] initWithFrame:CGRectMake(0,
                                                                   SCREEN_HEIGHT - SHARE_VIEW_HEIGHT,
                                                                   SCREEN_WIDTH,
                                                                   SHARE_VIEW_HEIGHT)];
    [self.view addSubview:self.shareView];

    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [self.maskView addGestureRecognizer:tap];
    @weakify(self);
    [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        @strongify(self);
        [self dismissViewControllerAnimated:YES completion:NULL];
    }];
}




@end
