//
//  TextViewControl.h
//  Ssdfz
//
//  Created by 潘滢 on 16/2/29.
//  Copyright © 2016年 Combanc. All rights reserved.
//  textView设置placeholder

#import <UIKit/UIKit.h>

@interface TextViewControl : UITextView
{
    //是否隐藏占位文字
    BOOL _hidePlaceholder;
}
/**
 *  占位文字
 */
@property (nonatomic, copy) NSString *placeholder;
/**
 *  占位文字的颜色
 */
@property (nonatomic, strong) UIColor *placeholderColor;

@end
