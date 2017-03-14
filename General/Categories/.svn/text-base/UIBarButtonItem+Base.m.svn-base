//
//  UIBarButtonItem+Base.m
//  Ssdfz
//
//  Created by 王楠 on 16/1/20.
//  Copyright © 2016年 Combanc. All rights reserved.
//

#import "UIBarButtonItem+Base.h"

@implementation UIBarButtonItem (Base)

+ (UIBarButtonItem *)itemWithImage:(NSString *)image higlightedImage:(NSString *)higlightedImage target:(id)target action:(SEL)action
{
    // 1.创建按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // 2.设置按钮背景图片
    UIImage *normal = [UIImage imageNamed:image];
    [btn setBackgroundImage:normal forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:higlightedImage] forState:UIControlStateHighlighted];
    btn.titleLabel.font = NAV_FONT;
    // 3.设置按钮的尺寸
    btn.bounds = CGRectMake(0, 0, normal.size.width, normal.size.height);
    
    // 4.监听按钮点击
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    // 5.返回创建好的item
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
