//
//  APIMarco.h
//  MyProject
//
//  Created by Joseph Gao on 2017/5/12.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#ifndef APIMarco_h
#define APIMarco_h



//------------------------------------------------------------------------------
#pragma mark - 公钥
/// 公钥
#define PUBKEY @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCDGHjtLwTJP9ehWYM3Dmwg9eTX3gDAFwQMyL1edXKPOjyUucWml7O8VF8adQgLH8fM1PoZSKHGliE0rZ3q6o1jh4lkF1CLIqWRbZ4ObKM2i1w5O2VP9lMKyWTrRM/R9RWxCgwINb/QQmbmNLTVruh4YG1Q0QTK2dQLnIh0oANdpwIDAQAB"


//------------------------------------------------------------------------------
#pragma mark - 全局接口

#define API_BIND_ALIAS @"utils/push/alias"                      // 个推绑定别名接口
#define API_UNBIND_ALIAS @"utils/push"                          //解绑个推别名

#define APP_TAB_BAR_IMAGES @"spec/common/appNavigationBar"      //底部Tab接口


//------------------------------------------------------------------------------
#pragma mark - 模块接口
#define API_LOGIN @"token"  // 用户登陆接口


#endif /* APIMarco_h */
