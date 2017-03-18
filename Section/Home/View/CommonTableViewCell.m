//
//  CommonTableViewCell.m
//  DXDoctor
//
//  Created by 思 彭 on 17/3/18.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "CommonTableViewCell.h"

@interface CommonTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation CommonTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews {
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.font = FONT_15;
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.textColor = [UIColor darkGrayColor];
    self.titleLabel.text = @"吹风机还能治病???不知道你就真的太了可惜了呀!!!";
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.titleLabel];
    self.imgView = [[UIImageView alloc]init];
    self.imgView.contentMode = UIViewContentModeScaleAspectFit;
    self.imgView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.imgView];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    __weak typeof(self) weakSelf = self;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.contentView).offset(10);
        make.top.mas_equalTo(weakSelf.contentView).offset(10);
        make.width.mas_equalTo(K_SCREEN_WIDTH * 0.7);
        make.bottom.mas_equalTo(weakSelf.contentView).offset(-10);
    }];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.contentView).offset(-10);
        make.top.mas_equalTo(self.titleLabel);
        make.bottom.mas_equalTo(weakSelf.contentView).offset(-10);
        make.width.mas_equalTo(K_SCREEN_WIDTH * 0.2);
    }];
}


@end
