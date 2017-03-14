//
//  MessageHeaderView.m
//  DXDoctor
//
//  Created by 思 彭 on 17/3/14.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "MessageHeaderView.h"
#import "MKButton.h"
#import "UIColor+HexColor.h"

#define itemCountPerLine (3)
#define lineCount (2)

@implementation MessageHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = MAIN_BG_COLOR;
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    
    UIView *btnContainerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, self.height)];
    [self addSubview:btnContainerView];
    CGFloat itemW = K_SCREEN_WIDTH / itemCountPerLine;
    CGFloat itemH = btnContainerView.height;
    CGFloat buttonWH = 30.f;
    CGFloat imageX = (itemW - buttonWH) * 0.5;
    NSValue *imageRectValue = [NSValue valueWithCGRect:CGRectMake(imageX, 20, buttonWH, buttonWH)];
    NSValue *titleRectValue = [NSValue valueWithCGRect:CGRectMake(0, 0 + buttonWH + 20.f, itemW, 20)];
    NSArray *imageNameArray = @[@"article-icon", @"askdoctor_avatar", @"disease-icon"];
    NSArray *titleArray = @[@"我的收藏", @"我的关注", @"我的药箱"];
    for (NSUInteger i = 0; i < imageNameArray.count; i++) {
        NSUInteger rowNum = i / itemCountPerLine;
        NSUInteger colNum = i % itemCountPerLine;
        MKButton *button = [[MKButton alloc] initWithFrame:CGRectMake(colNum * itemW, rowNum * itemH, itemW, itemH)];
        [button setImage:[UIImage imageNamed:imageNameArray[i]] forState:UIControlStateNormal];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
        button.titleLabel.font = FONT_13;
        button.tag = i;
        button.imageRect = imageRectValue;
        button.titleRect = titleRectValue;
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btnContainerView addSubview:button];
    }
}

- (void)buttonDidClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(MessageHeaderView:buttonDidClickedAtIndex:)]) {
        [self.delegate MessageHeaderView:self buttonDidClickedAtIndex:sender.tag];
    }
}

@end
