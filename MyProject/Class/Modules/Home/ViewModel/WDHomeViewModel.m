//
//  WDHomeViewModel.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/2.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDHomeViewModel.h"

@implementation WDHomeViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    @weakify(self);
    self.requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        [self requestDataSignal];
        
        return [RACSignal empty];
    }];
}

- (RACSignal *)requestDataSignal {
    NSString *url = @"token";
    NSDictionary *params = @{
                             @"account": @"18601603757",
                             @"password": [RSA rsaPassword:@"888888"],
                             @"withAddress": @1
                             };
    
    RACSignal *signal = [WDRequestAdapter requestSignalWithURL:url
                                                    params:params
                                               requestType:WDRequestTypeGET
                                              responseType:WDResponseTypeObject
                                             responseClass:nil];
    [signal
     subscribeNext:^(id  _Nullable x) {
        NSLog(@"----%@", x);
    }
     error:^(NSError * _Nullable error) {
        NSLog(@"----%@", error);
    }
     completed:^{
        NSLog(@"----");
    }];
    
    return nil;
}

@end
