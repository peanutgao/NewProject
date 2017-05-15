//
//  WDRequestAdapter.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/2.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDRequestAdapter.h"
#import "WDRequestManager.h"
#import "WDResponseModel.h"

static NSString *const kNetworkErrorTips = @"网络连接错误";

@implementation WDRequestAdapter

+ (RACSignal *)requestSignalWithURL:(NSString *)url
                             params:(NSDictionary *)params
                        requestType:(WDRequestType)requestType
                       responseType:(WDResponseType)responseType
                      responseClass:(Class)responseClass {
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        // 如果网络连接错误,直接返回提示信息
        if ([WDNetworkTools shareTools].isReachable == NO) {
            [WDLoadingHUD showTips:kNetworkErrorTips];
            return nil;
        }
        
        // 请求成功操作
        RequestSuccessBlock successBlock = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
            @strongify(self);
            RACSignal *parsedSignal = [self parsedResponse:responseObject ofClass:responseClass responseType:responseType];
            [parsedSignal
             subscribeNext:^(id  _Nullable x) {
                 [subscriber sendNext:x];
             }
             error:^(NSError * _Nullable error) {
                 [subscriber sendError:error];
             }
             completed:^{
                 [subscriber sendCompleted];
                 
             }];

        };
        
        // 请求失败操作
        RequestFailureBlock failureBlock = ^(NSURLSessionDataTask *task, NSError *error){
            [subscriber sendError:error];
            [subscriber sendCompleted];
        };
        
        // 请求成功但Token失效操作
        RequestTokenInvalidBlock tokenInvalidBlock = ^(NSURLSessionDataTask *task, id response, NSError *error){
            // TODO: 处理token失效
            [subscriber sendError:error];
            [subscriber sendCompleted];
        };
        
        
        
        NSURLSessionDataTask *task = nil;
        switch (requestType) {
            case WDRequestTypeGET: {
                task = [[WDRequestManager shareManager] request:url
                                                     withParams:params
                                                    requestType:WDRequestTypeGET
                                                   invalidToken:tokenInvalidBlock
                                                        success:successBlock
                                                        failure:failureBlock];
                break;
            }
            case WDRequestTypePOST: {
                task = [[WDRequestManager shareManager] request:url
                                                     withParams:params
                                                    requestType:WDRequestTypePOST
                                                   invalidToken:tokenInvalidBlock
                                                        success:successBlock
                                                        failure:failureBlock];
                break;
            }
            case WDRequestTypeDELETE: {
                task = [[WDRequestManager shareManager] request:url
                                                     withParams:params
                                                    requestType:WDRequestTypeDELETE
                                                   invalidToken:tokenInvalidBlock
                                                        success:successBlock
                                                        failure:failureBlock];
                break;
            }
            case WDRequestTypePUT: {
                task = [[WDRequestManager shareManager] request:url
                                                     withParams:params
                                                    requestType:WDRequestTypePUT
                                                   invalidToken:tokenInvalidBlock
                                                        success:successBlock
                                                        failure:failureBlock];
                break;
            }
            default:
                break;
        }
        
        
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}


+ (RACSignal *)parsedResponse:(NSDictionary *)response ofClass:(Class)ObjClass responseType:(WDResponseType)responseType {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        if (![response isKindOfClass:[NSDictionary class]]) {
            [subscriber sendError:nil];
            [subscriber sendCompleted];
            return nil;
        }
        
        WDResponseModel *responseModel = [[WDResponseModel alloc] init];
        responseModel.msg = response[@"msg"];
        
        // 直接返回响应数据: 1.空; 2.没有设置转换的数据类型; 3.设置的转换数据类型是message
        id data = response[@"data"];
        if (data == nil
            || ObjClass == nil
            || responseType == WDResponseTypeMessage) {
            responseModel.data = data;
            [subscriber sendNext:responseModel];
            [subscriber sendCompleted];
            return nil;
        }
        
        // 根据类型转换数据
        switch (responseType) {
            case WDResponseTypeObject: {
                responseModel.data = [ObjClass mj_objectWithKeyValues:data];
                break;
            }
            case WDResponseTypeList: {
                if ([data isKindOfClass:[NSArray class]]) {
                    responseModel.data = [ObjClass mj_objectArrayWithKeyValuesArray:data];
                }
                else if ([data objectForKey:@"content"]) {
                    [WDListModel mj_setupObjectClassInArray:^NSDictionary *{
                        return @{@"content" : ObjClass};
                    }];
                    responseModel.data = [WDListModel mj_objectWithKeyValues:data];
                }
                break;
            }
            default:
                break;
        }
        
        [subscriber sendNext:responseModel];
        [subscriber sendCompleted];
        
        return nil;
    }];
}


/// SDWebImage下载图片
+ (RACSignal *)downloadImageSignalWithURL:(NSString *)url
                                      key:(NSString *)key {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:url] options:SDWebImageDownloaderLowPriority|SDWebImageDownloaderContinueInBackground progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            
        } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            if (error) {
                NSLog(@"下载图片失败: %@", error.localizedDescription);
                [subscriber sendError:error];
                [subscriber sendCompleted];
                return;
            }
            
            if (finished) {
                NSString *k = key;
                if (key == nil || [key isEqualToString:@""]) k = url;
 
                [[SDImageCache sharedImageCache] storeImage:image forKey:k completion:^{
                    NSLog(@"下载并保存图片成功!");
                    [subscriber sendNext:@{
                                           @"key" : k,
                                           @"url" : url
                                           }];
                    [subscriber sendCompleted];
                }];
            }
            
        }];
        
        return nil;
    }];
    
    return signal;
}
@end
