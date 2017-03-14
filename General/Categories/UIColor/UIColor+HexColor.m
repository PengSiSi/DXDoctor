//
//  UIColor+HexColor.m
//  changpingSchoolTeacher
//
//  Created by 王楠 on 16/10/15.
//  Copyright © 2016年 combanc. All rights reserved.
//

#import "UIColor+HexColor.h"

@implementation UIColor (HexColor)

+ (UIColor *)colorWithHex:(NSString *)hex {
//    hex = [hex stringByReplacingOccurrencesOfString:@"#" withString:@""];
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hex];
    [scanner setScanLocation:1];
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16) / 255.0
                           green:((rgbValue & 0xFF00) >> 8) / 255.0
                            blue:(rgbValue & 0xFF) / 255.0
                           alpha:1.0];
}
@end
