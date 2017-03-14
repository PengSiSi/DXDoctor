//
//  UIColor+GetColor.m
//
//  Created by Mike on 15/4/10.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "UIColor+GetColor.h"

@implementation UIColor (GetColor)

- (CGFloat)red {
    CGFloat r = 0, g, b, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return r;
}

- (CGFloat)green {
    CGFloat r, g = 0, b, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return g;
}

- (CGFloat)blue {
    CGFloat r, g, b = 0, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return b;
}

- (CGFloat)alpha {
    return CGColorGetAlpha(self.CGColor);
}

+ (UIColor *)colorWithHex:(NSString *)hexColor {
    // String should be 6 or 7 characters if it includes '#'
    if ([hexColor length]  < 6)
        return nil;
    
    // strip # if it appears
    if ([hexColor hasPrefix:@"#"])
        hexColor = [hexColor substringFromIndex:1];
    
    // if the value isn't 6 characters at this point return
    // the color black
    if ([hexColor length] != 6)
        return nil;
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    NSString *rString = [hexColor substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [hexColor substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [hexColor substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+ (UIColor *)colorWithRandom6 {
    UIColor *color = nil;
    
    switch(arc4random() % 6) {
        case 0: color = [UIColor colorWithHex:@"F8661F"];break; // red
        case 1: color = [UIColor colorWithHex:@"E9C21F"];break; // orange
        case 2: color = [UIColor colorWithHex:@"4CBA6A"];break; // dark green
        case 3: color = [UIColor colorWithHex:@"2181CB"];break; // dark blue
        case 4: color = [UIColor colorWithHex:@"2CA7EA"];break; // light blue
        case 5: color = [UIColor colorWithHex:@"87B52E"];break; // light green
            
        default: break;
    }
    
    return color;
}

+ (UIColor *)colorWithRandom {
    return [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
}

- (UIColor *)colorByAddRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue {
    CGFloat r = 0, g = 0, b = 0, a = 0;
    [self getRed:&r green:&g blue:&b alpha:&a];
    r -= red; g -= green; b -= blue;
    if (r > 1.f) r = 1.f;
    if (g > 1.f) g = 1.f;
    if (b > 1.f) b = 1.f;
    return [UIColor colorWithRed:r green:g blue:b alpha:a];
}

- (UIColor *)colorByMinusRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue {
    CGFloat r = 0, g = 0, b = 0, a = 0;
    [self getRed:&r green:&g blue:&b alpha:&a];
    r -= red; g -= green; b -= blue;
    if (r < 0.f) r = 0.f;
    if (g < 0.f) g = 0.f;
    if (b < 0.f) b = 0.f;
    return [UIColor colorWithRed:r green:g blue:b alpha:a];
}

@end
