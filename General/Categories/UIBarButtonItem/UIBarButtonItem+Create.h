//
//  UIBarButtonItem+Create.h
//
//  Created by Mike on 15/4/10.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Create)

+ (instancetype)barButtonItemWithImage:(UIImage *)image highLightedImage:(UIImage *)highlightedImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

+ (instancetype)barButtonItemWithTitle:(NSString *)title tintColor:(UIColor *)tintColor target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end
