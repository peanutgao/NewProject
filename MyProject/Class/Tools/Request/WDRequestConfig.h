//
//  WDRequestConfig.h
//  MyProject
//
//  Created by Joseph Gao on 2017/5/2.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WDRequestType) {
    WDRequestTypeGET = 0,
    WDRequestTypePOST,
    WDRequestTypeDELETE,
    WDRequestTypePUT,
    WDRequestTypeUPLOAD
};

typedef NS_ENUM(NSInteger, WDResponseType) {
    WDResponseTypeObject = 0,
    WDResponseTypeList,
    WDResponseTypeMessage,
};

@interface WDRequestConfig : NSObject

/// 服务器Base URL
UIKIT_EXTERN NSString *const kServerBaseURL;
/// H5页面BaseURL
UIKIT_EXTERN NSString *const kH5BaseURL;

@end
