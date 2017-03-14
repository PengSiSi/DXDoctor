//
//  UIBarButtonItem+Create.m
//
//  Created by Mike on 15/4/10.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "UIBarButtonItem+Create.h"

@implementation UIBarButtonItem (Create)

+ (instancetype)barButtonItemWithImage:(UIImage *)image highLightedImage:(UIImage *)highlightedImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    
    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [barButton setBackgroundImage:image forState:UIControlStateNormal];
    [barButton setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
    
    [barButton addTarget:target action:action forControlEvents:controlEvents];
    [barButton sizeToFit];
    return [[UIBarButtonItem alloc] initWithCustomView:barButton];
}

+ (instancetype)barButtonItemWithTitle:(NSString *)title tintColor:(UIColor *)tintColor target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [barButton setTitle:title forState:UIControlStateNormal];
    [barButton setTitleColor:tintColor forState:UIControlStateNormal];
    [barButton addTarget:target action:action forControlEvents:controlEvents];
//    barButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [barButton sizeToFit];
    return [[UIBarButtonItem alloc] initWithCustomView:barButton];
}

@end
