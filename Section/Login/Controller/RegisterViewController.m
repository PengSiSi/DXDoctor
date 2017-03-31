//
//  RegisterViewController.m
//  DXDoctor
//
//  Created by 思 彭 on 17/3/31.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "RegisterViewController.h"
#import "VerifyCodeViewController.h"

@interface RegisterViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, copy) NSString *telStr;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initailUI];
    [self setupUI];
}

- (void)initailUI {
    
    self.navigationItem.title = @"快速注册";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancle:)];
}

- (void)setupUI {
    
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 40, K_SCREEN_WIDTH - 20, 44)];
    self.textField.delegate = self;
    self.textField.backgroundColor = [UIColor whiteColor];
    self.textField.placeholder = @"请输入手机号";
    self.textField.font = FONT_15;
    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    [self.textField becomeFirstResponder]; // 成为第一响应
    [self.view addSubview:self.textField];
    
    self.nextButton = [UIButton buttonWithType: UIButtonTypeCustom];
    self.nextButton.frame = CGRectMake(10, self.textField.height + 40 + 20, K_SCREEN_WIDTH  - 20, 44);
    self.nextButton.backgroundColor = MAIN_COLOR;
    self.nextButton.enabled = NO;
    [self.nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [self.nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.nextButton addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nextButton];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if ([self isvalidateMobile:textField.text]) {
        self.nextButton.enabled = YES;
        self.telStr = textField.text;
    } else {
        [CombancHUD showInfoWithStatus:@"手机号输入错误"];
        textField.text = nil;
        return;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.textField resignFirstResponder];
}

#pragma mark - Private Method

- (void)cancle: (UIBarButtonItem *)item {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)nextAction: (UIButton *)button {
    
    VerifyCodeViewController *vertifyCodeVc = [[VerifyCodeViewController alloc]init];
    vertifyCodeVc.telePhoneStr = self.telStr;
    [self.navigationController pushViewController:vertifyCodeVc animated:YES];
}

// 手机号码验证
- (BOOL)isvalidateMobile: (NSString *)mobilePhone {
    
    NSString *phoneRegex = @"1[34578]([0-9]){9}";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",phoneRegex];
    BOOL result = [regextestmobile evaluateWithObject:mobilePhone];
    return result;
}

@end
