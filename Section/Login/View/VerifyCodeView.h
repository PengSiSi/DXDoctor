//
//  VerifyCodeView.h
//  DXDoctor
//
//  Created by 思 彭 on 17/3/31.
//  Copyright © 2017年 思 彭. All rights reserved.

// 短信验证码封装

#import <UIKit/UIKit.h>

typedef void(^textFieldDidEndEditBlock)(NSString *verifyCodeStr);

@interface VerifyCodeView : UIView

@property (nonatomic, copy) textFieldDidEndEditBlock verifyCodeBlock;

@end
