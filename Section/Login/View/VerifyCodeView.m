//
//  VerifyCodeView.m
//  DXDoctor
//
//  Created by 思 彭 on 17/3/31.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "VerifyCodeView.h"

@interface VerifyCodeView ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *verifyCodeTextField;
@property (nonatomic, strong) UIButton *verifyCodeButton;

@end

@implementation VerifyCodeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews {
    
    self.verifyCodeTextField = [[UITextField alloc]init];
    self.verifyCodeTextField.delegate = self;
    self.verifyCodeTextField.backgroundColor = [UIColor whiteColor];
    self.verifyCodeTextField.placeholder = @"请输入收到的验证码";
    self.verifyCodeTextField.font = FONT_15;
    self.verifyCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.verifyCodeTextField becomeFirstResponder]; // 成为第一响应
    [self addSubview:self.verifyCodeTextField];
    
    self.verifyCodeButton = [UIButton buttonWithType: UIButtonTypeCustom];
    [self.verifyCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.verifyCodeButton.backgroundColor = [UIColor grayColor];
    self.verifyCodeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.verifyCodeButton setTitle:@"重新发送(60)" forState:UIControlStateNormal];
    self.verifyCodeButton.titleLabel.font = FONT_14;
    [self.verifyCodeButton addTarget:self action:@selector(countDownButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.verifyCodeButton];
//    [self layOutSubViews];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.verifyCodeTextField.frame = CGRectMake(0, 0, K_SCREEN_WIDTH * 2/3, self.height);
    self.verifyCodeButton.frame = CGRectMake(K_SCREEN_WIDTH * 2 / 3, 0, K_SCREEN_WIDTH * 1/3 - 20, self.height);
}

- (void)layOutSubViews {
    
    [self.verifyCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self).offset(10);
        make.bottom.mas_equalTo(self).offset(-10);
        make.width.mas_equalTo(self.width * 2 / 3);
    }];
    [self.verifyCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(10);
        make.bottom.right.mas_equalTo(self).offset(-10);
        make.width.mas_equalTo(self.width * 1 / 3);
    }];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (self.verifyCodeBlock) {
        self.verifyCodeBlock(textField.text);
    }
}

- (void)countDownButtonClick: (UIButton *)button {
    
}

@end
