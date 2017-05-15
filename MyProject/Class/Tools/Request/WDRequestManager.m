//
//  WDRequestManager.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/1.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDRequestManager.h"
#import "AFNetworking.h"
#import "MF_Base64Additions.h"
#import "HappyDNS.h"
#import "WDSecurityPolicy.h"
#import "WDSignatureManager.h"
#import "WDResponseChecking.h"

@implementation WDRequestManager

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    static WDRequestManager *instance = nil;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.requestCachePolicy = NSURLRequestReloadIgnoringCacheData;
        instance = [[WDRequestManager alloc] initWithBaseURL:[NSURL URLWithString:kServerBaseURL]
                                        sessionConfiguration:configuration];
        
        instance.securityPolicy = [WDSecurityPolicy securityPolicy];
        instance.requestSerializer = [AFJSONRequestSerializer serializer];
        [instance.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:
                                                                @"application/json",
                                                                @"charset=UTF-8",
                                                                @"text/plain",
                                                                @"text/javascript",
                                                                @"text/html",
                                                                @"image/*", nil]];
    });
    
    return instance;
}




- (NSURLSessionDataTask *)request:(NSString *)url
                       withParams:(NSDictionary *)params
                      requestType:(WDRequestType)requestType
                     invalidToken:(RequestTokenInvalidBlock)invalidToken
                          success:(RequestSuccessBlock)success
                          failure:(RequestFailureBlock)failure {
    NSLog(@"Request_POST:\nURL: %@\nParams: %@", url, params);
    
    RequestSuccessBlock successBlock = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        [self responseComplete:responseObject
                      dataTask:task
                  invalidToken:invalidToken
                       success:success
                       failure:failure];
    };
    
    RequestFailureBlock failureBlock = ^(NSURLSessionDataTask *task, NSError *error){
        NSLog(@"url----> %@\n%@", url, error);
        if (failure) {
            failure(task, error);
        }
    };
    
    RequestTokenInvalidBlock tokenInvalidBlock = ^(NSURLSessionDataTask *task, id response, NSError *error){
        NSLog(@"-------> Token过期");
        if (invalidToken) {
            invalidToken(task, response, error);
        }
    };
    
    switch (requestType) {
        case WDRequestTypeGET: {
            return [self requestGET:url
                             params:params
                       invalidToken:tokenInvalidBlock
                            success:successBlock
                            failure:failureBlock];
            break;
        }
        case WDRequestTypePOST: {
            return [self requestPOST:url
                              params:params
                        invalidToken:tokenInvalidBlock
                             success:successBlock
                             failure:failureBlock];
            break;
        }
        case WDRequestTypeDELETE: {
            return [self requestDELETE:url
                                params:params
                          invalidToken:tokenInvalidBlock
                               success:successBlock
                               failure:failureBlock];
            break;
        }
        case WDRequestTypePUT: {
            return [self requestPUT:url
                              params:params
                        invalidToken:tokenInvalidBlock
                             success:successBlock
                             failure:failureBlock];
            break;
        }
        default:
            break;
    }
    
    return nil;
}


#pragma mark - 处理请求

- (void)responseComplete:(id)response
                dataTask:(NSURLSessionDataTask *)task
            invalidToken:(RequestTokenInvalidBlock)invalid
                 success:(RequestSuccessBlock)success
                 failure:(RequestFailureBlock)failure {
    // 检查请求是否失败
    // 如果 响应的code == 0 就表示响应成功
    // 如果 响应失败 则自定义错误信息
    NSError *error = [WDResponseChecking checkResponseObject:response];
    if (error) {
        // 检查请求时 token 是否已经过期
        if ([WDResponseChecking isInvalidToken:error] ) {
            if (invalid) {
                invalid(task, response, error);
            }
        }
        else {  // 接口请求失败
            if (failure) {
                // 本地时间和服务器时间差超过10分钟
                if ((int)error.code == 16 && response[@"time_diff"]) {
                    self.time_diff = response[@"time_diff"];
                }
                if (failure) {
                    failure(task, error);
                }
            }
        }
    }
    else {
        if (success) {
            success(task, response);
        }
    }
}



#pragma mark - GET请求

- (NSURLSessionDataTask *)requestGET:(NSString *)url
                              params:(NSDictionary *)params
                        invalidToken:(RequestTokenInvalidBlock)invalidToken
                             success:(RequestSuccessBlock)success
                             failure:(RequestFailureBlock)failure {
    // 添加请求头信息
    [WDSignatureManager addHeader:self.requestSerializer
                           params:params
                           method:WDRequestTypeGET
                              url:url
                  isURLHaveAPITag:YES];
    return [self GET:url parameters:params progress:NULL success:success failure:failure];
}


#pragma mark - POST请求

- (NSURLSessionDataTask *)requestPOST:(NSString *)url
                               params:(NSDictionary *)params
                         invalidToken:(RequestTokenInvalidBlock)invalidToken
                              success:(RequestSuccessBlock)success
                              failure:(RequestFailureBlock)failure {
    // 添加请求头信息
    [WDSignatureManager addHeader:self.requestSerializer
                           params:params
                           method:WDRequestTypePOST
                              url:url
                  isURLHaveAPITag:YES];
    
    return [self POST:url parameters:params progress:NULL success:success failure:failure];
}


#pragma mark - DELETE请求

- (NSURLSessionDataTask *)requestDELETE:(NSString *)url
                                 params:(NSDictionary *)params
                           invalidToken:(RequestTokenInvalidBlock)invalidToken
                                success:(RequestSuccessBlock)success
                                failure:(RequestFailureBlock)failure {
    // 添加请求头信息
    [WDSignatureManager addHeader:self.requestSerializer
                           params:params
                           method:WDRequestTypeDELETE
                              url:url
                  isURLHaveAPITag:YES];

    return [self DELETE:url parameters:params success:success failure:false];
}


#pragma mark - PUT请求

- (NSURLSessionDataTask *)requestPUT:(NSString *)url
                              params:(NSDictionary *)params
                        invalidToken:(RequestTokenInvalidBlock)invalidToken
                             success:(RequestSuccessBlock)success
                             failure:(RequestFailureBlock)failure {
    // 添加请求头信息
    [WDSignatureManager addHeader:self.requestSerializer
                           params:params
                           method:WDRequestTypePUT
                              url:url
                  isURLHaveAPITag:YES];

    return [self PUT:url parameters:params success:success failure:failure];
}


#pragma mark - 上传文件

- (NSURLSessionDataTask *)requestUploadFile:(NSString *)url
                                      files:(NSArray *)datas
                                 parameters:(NSDictionary *)params
                               invalidToken:(RequestTokenInvalidBlock)invalidToken
                                    success:(RequestSuccessBlock)success
                                    failure:(RequestFailureBlock)failure {
    return nil;
}




@end
