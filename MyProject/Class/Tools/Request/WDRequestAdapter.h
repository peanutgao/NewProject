//
//  WDRequestAdapter.h
//  MyProject
//
//  Created by Joseph Gao on 2017/5/2.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WDRequestConfig.h"

@interface WDRequestAdapter : NSObject

/**
 数据请求信号封装库
 
 @param url 请求的URL字符串
 @param params 请求参数, 没有传nil
 @param requestType 数据请求类型, 枚举值
 @param responseType 响应的数据类型, 枚举值
 @param responseClass 响应的数据的类, class类型
 @return 数据请求信号
 */
+ (RACSignal *)requestSignalWithURL:(NSString *)url
                             params:(NSDictionary *)params
                        requestType:(WDRequestType)requestType
                       responseType:(WDResponseType)responseType
                      responseClass:(Class)responseClass;


#warning TODO: ------
+ (RACSignal *)uploadSignalWithURL:(NSString *)url
                             files:(NSArray *)files
                            params:(NSDictionary *)params
                      responseType:(WDResponseType)responseType;


/**
 封装SDWebImage下载图片

 @param url 图片地址
 @param key 存储图片的key, 一般用图片的url
 @return 下载操作信号
 */
+ (RACSignal *)downloadImageSignalWithURL:(NSString *)url
                                      key:(NSString *)key;

@end
