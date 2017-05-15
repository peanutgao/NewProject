//
//  WDLoginViewModel.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/8.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDLoginViewModel.h"

@implementation WDLoginViewModel

- (instancetype)init {
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    @weakify(self);
    self.loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        [self loginIn];
        
        return [RACSignal empty];
    }];
}
                         
- (void)loginIn {
    NSDictionary *params = @{@"account" : self.userName,
                             @"password" : [RSA rsaPassword: self.password],
                             @"withAddress": @1
                             };
    RACSignal *signal = [WDRequestAdapter requestSignalWithURL:API_LOGIN
                                                    params:params
                                               requestType:WDRequestTypeGET
                                              responseType:WDResponseTypeObject
                                             responseClass:[WDUserModel class]];
    [signal subscribeNext:^(WDResponseModel * _Nullable x) {
        WDUserModel *model = x.data;
        if (model && [model isKindOfClass:[WDUserModel class]]) {
            [[WDUserContext shareContext] deployLoginInDataWithUserModel:model];
        }
        
    } error:^(NSError * _Nullable error) {
        NSLog(@"登陆失败%@", error.localizedDescription);
    }];
}

@end
