//
//  WDResponseModel.h
//  MyProject
//
//  Created by Joseph Gao on 2017/5/2.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDResponseModel : NSObject

@property (nonatomic, copy) NSString *msg;
@property (nonatomic, strong) id data;

@end


@interface WDListModel : NSObject

@property (nonatomic, strong) NSNumber      *more;
@property (nonatomic, strong) NSDictionary  *more_params;
@property (nonatomic, strong) NSDictionary  *extras;
@property (nonatomic, strong) NSArray       *content;

@end
