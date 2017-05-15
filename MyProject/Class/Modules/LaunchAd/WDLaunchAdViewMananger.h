//
//  WDLaunchAdViewMananger.h
//  MyProject
//
//  Created by Joseph Gao on 2017/5/8.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDLaunchAdViewMananger : NSObject

@property (nonatomic, assign, readonly, getter=isHaveAdImage) BOOL haveAdImage;

@property (nonatomic, strong, readonly) RACCommand *showAdCommand;
@property (nonatomic, strong, readonly) RACCommand *downloadAdCommand;

@end
