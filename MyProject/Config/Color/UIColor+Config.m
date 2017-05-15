//
//  UIColor+Config.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/12.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "UIColor+Config.h"
#import "UIColor+Hex.h"

@implementation UIColor (Config)

//#64b4ff -> #0cb7f5

static const char *colorNameDB = ","
"main1#0cb7f5,main2#13c26e,main3#ffc63a,main4#ff774a,main5#f54949,main6#ff7840,main7#f15f23,main8#e44dad,main9#f14637,"
"bc0#000000,bc1#ffffff,bc2#f4f4f4,bc3#dddddd,bc4#cccccc,bc5#eeeeee,bc6#0cb7f5,bc7#0cb7f5,bc8#009bd3,bc9#d0ebf5,bc10#112b35#0.1,bc11#333333#0.3,"
"dc1#dddddd,dc2#cccccc,dc3#eeeeee,"
"tc0#ffffff,tc1#333333,tc2#666666,tc3#999999,tc4#bbbbbb,tc5#0cb8f5,tc6#333333,tc7#f54949,tc8#0cb7f5,tc9#13c26e,tc10#0cb7f5,tc11#ff774a,tc12#ffffff#0.69,tc13#555555,tc14#0E0E0E,"
"ic1#ffffff,ic2#dddddd,ic3#777777,ic4#0cb7f5,ic5#3dc4f5,ic6#ff8c66,ic7#3ec282,ic8#ffd059,ic9#4dd796,ic10#05B4F5,"
;

#pragma mark - Main Color

+ (UIColor *)main1Color{
    return [self searchForColorByName:@"main1"];
}
+ (UIColor *)main2Color{
    return [self searchForColorByName:@"main2"];
}
+ (UIColor *)main3Color{
    return [self searchForColorByName:@"main3"];
}
+ (UIColor *)main4Color{
    return [self searchForColorByName:@"main4"];
}
+ (UIColor *)main5Color{
    return [self searchForColorByName:@"main5"];
}
+ (UIColor *)main6Color{
    return [self searchForColorByName:@"main6"];
}
+ (UIColor *)main7Color{
    return [self searchForColorByName:@"main7"];
}
+ (UIColor *)main8Color{
    return [self searchForColorByName:@"main8"];
}
+ (UIColor *)main9Color{
    return [self searchForColorByName:@"main9"];
}


#pragma mark - BC Color

+ (UIColor *)bc0Color{
    return [self searchForColorByName:@"bc0"];
}
+ (UIColor *)bc1Color{
    return [self searchForColorByName:@"bc1"];
}
+ (UIColor *)bc2Color{
    return [self searchForColorByName:@"bc2"];
}
+ (UIColor *)bc3Color{
    return [self searchForColorByName:@"bc3"];
}
+ (UIColor *)bc4Color{
    return [self searchForColorByName:@"bc4"];
}
+ (UIColor *)bc5Color{
    return [self searchForColorByName:@"bc5"];
}
+ (UIColor *)bc6Color{
    return [self searchForColorByName:@"bc6"];
}
+ (UIColor *)bc7Color{
    return [self searchForColorByName:@"bc7"];
}
+ (UIColor *)bc8Color{
    return [self searchForColorByName:@"bc8"];
}
+ (UIColor *)bc9Color{
    return [self searchForColorByName:@"bc9"];
}
+ (UIColor *)bc10Color{
    return [self searchForColorByName:@"bc10"];
}
+ (UIColor *)bc11Color{
    return [self searchForColorByName:@"bc11"];
}


#pragma mark - DC Color

+ (UIColor *)dc1Color{
    return [self searchForColorByName:@"dc1"];
}
+ (UIColor *)dc2Color{
    return [self searchForColorByName:@"dc2"];
}
+ (UIColor *)dc3Color{
    return [self searchForColorByName:@"dc3"];
}


#pragma mark - TC Color

+ (UIColor *)tc0Color{
    return [self searchForColorByName:@"tc0"];
}
+ (UIColor *)tc1Color{
    return [self searchForColorByName:@"tc1"];
}
+ (UIColor *)tc2Color{
    return [self searchForColorByName:@"tc2"];
}
+ (UIColor *)tc3Color{
    return [self searchForColorByName:@"tc3"];
}
+ (UIColor *)tc4Color{
    return [self searchForColorByName:@"tc4"];
}
+ (UIColor *)tc5Color{
    return [self searchForColorByName:@"tc5"];
}
+ (UIColor *)tc6Color{
    return [self searchForColorByName:@"tc6"];
}
+ (UIColor *)tc7Color{
    return [self searchForColorByName:@"tc7"];
}
+ (UIColor *)tc8Color{
    return [self searchForColorByName:@"tc8"];
}
+ (UIColor *)tc9Color{
    return [self searchForColorByName:@"tc9"];
}
+ (UIColor *)tc10Color{
    return [self searchForColorByName:@"tc10"];
}
+ (UIColor *)tc11Color{
    return [self searchForColorByName:@"tc11"];
}
+ (UIColor *)tc12Color{
    return [self searchForColorByName:@"tc12"];
}
+ (UIColor *)tc13Color{
    return [self searchForColorByName:@"tc13"];
}
+ (UIColor *)tc14Color{
    return [self searchForColorByName:@"tc14"];
}


#pragma mark - IC Color

+ (UIColor *)ic1Color{
    return [self searchForColorByName:@"ic1"];
}
+ (UIColor *)ic2Color{
    return [self searchForColorByName:@"ic2"];
}
+ (UIColor *)ic3Color{
    return [self searchForColorByName:@"ic3"];
}
+ (UIColor *)ic4Color{
    return [self searchForColorByName:@"ic4"];
}
+ (UIColor *)ic5Color{
    return [self searchForColorByName:@"ic5"];
}
+ (UIColor *)ic6Color{
    return [self searchForColorByName:@"ic6"];
}
+ (UIColor *)ic7Color{
    return [self searchForColorByName:@"ic7"];
}
+ (UIColor *)ic8Color{
    return [self searchForColorByName:@"ic8"];
}
+ (UIColor *)ic9Color{
    return [self searchForColorByName:@"ic9"];
}
+ (UIColor *)ic10Color{
    return [self searchForColorByName:@"ic10"];
}


#pragma mark - Search

+ (UIColor *)searchForColorByName:(NSString *)cssColorName {
    UIColor *result = nil;
    const char *searchString = [[NSString stringWithFormat:@",%@#", cssColorName] UTF8String];
    const char *found = strstr(colorNameDB, searchString);
    if (found) {
        const char *after = found + strlen(searchString);
        int hex;
        if (sscanf(after, "%x", &hex) == 1) {
            result = [self colorWithHex:hex];
        }
    }
    
    return result;
}



@end
