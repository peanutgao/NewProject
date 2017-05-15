//
//  WDBaseView.h
//  MyProject
//
//  Created by Joseph Gao on 2017/4/30.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDBaseViewIMPL.h"

/// 基础view类, 其他view模块应继承自该类,从而统一遵守 `WDBaseViewIMPL` 协议
@interface WDBaseView : UIView <WDBaseViewIMPL>

@end
