//
//  CollectionHeaderReusableView.m
//  DXDoctor
//
//  Created by 思 彭 on 17/3/14.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "CollectionHeaderReusableView.h"

@interface CollectionHeaderReusableView ()
{
    UIImageView *searchImgView;
    UIButton *searchButton;
    UIButton *scannerButton;
}
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *authorLabel;
@property (nonatomic, strong) UIView *searchView;

@end

@implementation CollectionHeaderReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = MAIN_COLOR;
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.text = @" 低盐饮食有利于身体健康. ";
    self.titleLabel.font = FONT_15;
    [self addSubview:_titleLabel];
    self.authorLabel = [[UILabel alloc]init];
    self.authorLabel.textColor = [UIColor whiteColor];
    self.authorLabel.font = FONT_15;
    self.authorLabel.text = @" -----丁香医生 ";
    [self addSubview:self.authorLabel];
    self.searchView = [[UIView alloc]init];
    self.searchView.backgroundColor = [UIColor whiteColor];
    self.searchView.layer.cornerRadius = 5;
    self.searchView.layer.masksToBounds = YES;
    [self addSubview:self.searchView];
    
    // 搜索图片
    searchImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home-page_search_button_not-click"]];
    [self.searchView addSubview:searchImgView];
    // 搜索按钮
    searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchDidClick:) forControlEvents:UIControlEventTouchUpInside];
    searchButton.titleLabel.font = FONT_14;
    [self.searchView addSubview:searchButton];
    // 条形码扫描按钮
    scannerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [scannerButton setBackgroundImage:[UIImage imageNamed:@"upc"] forState:UIControlStateNormal];
    [self.searchView addSubview:scannerButton];
}

// 布局子视图
- (void)layoutSubviews {
    [super layoutSubviews];
    __weak typeof(self) weakSelf = self;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf).offset(20);
        make.top.mas_equalTo(weakSelf).offset(20);
        make.right.mas_equalTo(weakSelf).offset(-20);
    }];
    [self.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.mas_right).offset(-20);
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).offset(10);
    }];
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf.titleLabel);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(self.authorLabel.mas_bottom).offset(20);
    }];
    [searchImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(20);
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(weakSelf.searchView);
    }];
    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(searchImgView.mas_right).offset(20);
        make.centerY.mas_equalTo(weakSelf.searchView);
    }];
    [scannerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.searchView.mas_right).offset(-20);
        make.centerY.mas_equalTo(weakSelf.searchView);
    }];
}

#pragma mark - Private Method

- (void)searchDidClick: (UIButton *)button {
    
    if (self.searchBlock) {
        self.searchBlock();
    }
}

@end
