//
//  VerifyCodeViewController.m
//  DXDoctor
//
//  Created by 思 彭 on 17/3/31.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "VerifyCodeViewController.h"
#import "VerifyCodeView.h"

@interface VerifyCodeViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) VerifyCodeView *verifyCodeView;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UITextField *verifyCodeTextField;
@property (nonatomic, strong) UIButton *verifyCodeButton;

@end

@implementation VerifyCodeViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self countDownButtonClick:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initailUI];
    [self setupUI];
}

- (void)initailUI {

    self.navigationItem.title = @" 手机注册";
}

- (void)setupUI {
    
    self.tipLabel = [[UILabel alloc]init];
    self.tipLabel.font = FONT_14;
    self.tipLabel.textColor = [UIColor lightGrayColor];
    self.tipLabel.numberOfLines = 0;
    [self.view addSubview:self.tipLabel];
    NSString *tipLabelStr = [NSString stringWithFormat:@"验证码已发送至 %@\n验证码五分钟内有效,请尽快使用",_telePhoneStr];
    self.tipLabel.text = tipLabelStr;
    [self setTextColor:self.tipLabel FontNumber:FONT_15 AndRange:NSMakeRange(0, tipLabelStr.length) AndColor:[UIColor redColor]];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.view).offset(10);
        make.right.mas_equalTo(self.view).offset(-10);
        make.height.mas_equalTo(50);
    }];
    
    self.verifyCodeView = [[VerifyCodeView alloc]init];
    self.verifyCodeView.frame = CGRectMake(10, 80, K_SCREEN_WIDTH - 20, 50);
    [self.view addSubview:self.verifyCodeView];
//    [self createSubViews];
    [self.verifyCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.tipLabel);
        make.top.mas_equalTo(self.tipLabel.mas_bottom).offset(20);
        make.height.mas_equalTo(44);
    }];
    self.verifyCodeView.verifyCodeBlock = ^(NSString *codeStr) {
      
        NSLog(@"验证码...");
    };

    self.confirmButton = [UIButton buttonWithType: UIButtonTypeCustom];
    [self.confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.confirmButton.backgroundColor = MAIN_COLOR;
    self.confirmButton.titleLabel.font = FONT_14;
    [self.confirmButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.confirmButton];
    
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.verifyCodeView.mas_bottom).offset(10);
        make.left.mas_equalTo(self.tipLabel);
        make.right.mas_equalTo(self.view).offset(-10);
        make.height.mas_equalTo(44);
    }];
    
    UIButton *noReceiveVerifyCodeButton = [UIButton buttonWithType: UIButtonTypeCustom];
    [noReceiveVerifyCodeButton setTitle:@"收不到验证码?" forState:UIControlStateNormal];
    [noReceiveVerifyCodeButton setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    noReceiveVerifyCodeButton.titleLabel.font = FONT_14;
    [noReceiveVerifyCodeButton addTarget:self action:@selector(noReceiveCodeClick:) forControlEvents:UIControlEventTouchUpInside];
    noReceiveVerifyCodeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:noReceiveVerifyCodeButton];
    [noReceiveVerifyCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.confirmButton.mas_bottom).offset(10);
        make.left.mas_equalTo(self.tipLabel);
        make.right.mas_equalTo(self.view).offset(-10);
        make.height.mas_equalTo(30);
    }];
}

- (void)createSubViews {
    
    self.verifyCodeTextField = [[UITextField alloc]init];
    self.verifyCodeTextField.delegate = self;
    self.verifyCodeTextField.backgroundColor = [UIColor whiteColor];
    self.verifyCodeTextField.placeholder = @"请输入收到的验证码";
    self.verifyCodeTextField.font = FONT_15;
    self.verifyCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.verifyCodeTextField becomeFirstResponder]; // 成为第一响应
    [self.verifyCodeView addSubview:self.verifyCodeTextField];
    
    self.verifyCodeButton = [UIButton buttonWithType: UIButtonTypeCustom];
    [self.verifyCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.verifyCodeButton.backgroundColor = [UIColor grayColor];
    self.verifyCodeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.verifyCodeButton setTitle:@"重新发送(60)" forState:UIControlStateNormal];
    self.verifyCodeButton.titleLabel.font = FONT_14;
//    [self.verifyCodeButton addTarget:self action:@selector(countDownButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.verifyCodeView addSubview:self.verifyCodeButton];
    [self layOutSubViews];
}

- (void)layOutSubViews {
    
    [self.verifyCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.verifyCodeView).offset(10);
        make.bottom.mas_equalTo(self.verifyCodeView).offset(-10);
        make.width.mas_equalTo(self.verifyCodeView.width * 2 / 3);
    }];
    [self.verifyCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.verifyCodeView).offset(10);
        make.bottom.right.mas_equalTo(self.verifyCodeView).offset(-10);
        make.width.mas_equalTo(self.verifyCodeView.width * 1 / 3);
    }];
}

#pragma mark - 倒计时

- (void)countDownButtonClick: (UIButton *)button {

    __block NSInteger time = 59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(time <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮的样式
                [self.verifyCodeButton setTitle:@"重新发送" forState:UIControlStateNormal];
                [self.verifyCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.verifyCodeButton.userInteractionEnabled = YES;
            });
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [self.verifyCodeButton setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                [self.verifyCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.verifyCodeButton.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

#pragma mark - Setter

/*
- (void)setTelePhoneStr:(NSString *)telePhoneStr {
 
    _telePhoneStr = telePhoneStr;
    [self setupUI];
    NSString *tipLabelStr = [NSString stringWithFormat:@"验证码已发送至 %@\n验证码五分钟内有效,请尽快使用",_telePhoneStr];
    self.tipLabel.text = tipLabelStr;
    [self setTextColor:self.tipLabel FontNumber:FONT_15 AndRange:NSMakeRange(0, tipLabelStr.length) AndColor:[UIColor redColor]];
}
*/

#pragma mark - Private Method

- (void)noReceiveCodeClick: (UIButton *)button {
    
}

- (void)buttonClick: (UIButton *)button {
 
    [CombancHUD showInfoWithStatus:@"请先输入验证码哟~"];
}

// 设置字符串中数字的颜色
- (void)setTextColor:(UILabel *)label FontNumber:(id)font AndRange:(NSRange)range AndColor:(UIColor *)vaColor
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
    
    NSCharacterSet* nonDigits =[[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    int remainSecond =[[label.text stringByTrimmingCharactersInSet:nonDigits] intValue];
    NSLog(@" num %d ",remainSecond);
    
    NSString *labelText = label.text;
    
    for (int i = 0; i < labelText.length; i ++) {
        //这里的小技巧，每次只截取一个字符的范围
        NSString *a = [labelText substringWithRange:NSMakeRange(i, 1)];
        //判断装有0-9的字符串的数字数组是否包含截取字符串出来的单个字符，从而筛选出符合要求的数字字符的范围NSMakeRange
        NSArray *number = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
        if ([number containsObject:a]) {
            [str setAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:FONT_16} range:NSMakeRange(i, 1)];
        }
    }
    label.attributedText = str;
}

@end
