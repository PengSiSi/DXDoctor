//
//  SpecialCell.m
//  DXDoctor
//
//  Created by 思 彭 on 17/3/16.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "SpecialCell.h"

@interface SpecialCell ()

@property (nonatomic, strong) UIImageView *bgImgView; /**<背景图片 */
@property (nonatomic, strong) UILabel *titleLabel; /**<标题 */
@property (nonatomic, strong) UILabel *typeLabel; /**<类型 */

@end

@implementation SpecialCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews {
    
    self.bgImgView = [[UIImageView alloc]init];
    self.bgImgView.contentMode = UIViewContentModeScaleAspectFit;
    self.bgImgView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.bgImgView];
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.font = FONT_16;
//    self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.text = @"高血脂专题";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLabel];
    self.typeLabel = [[UILabel alloc]init];
    self.typeLabel.backgroundColor = MAIN_COLOR;
    self.typeLabel.font = FONT_14;
    self.typeLabel.textAlignment = NSTextAlignmentCenter;
    self.typeLabel.text = @"专题";
    self.typeLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:self.typeLabel];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    __weak typeof(self) weakSelf = self;
    [self.bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.mas_equalTo(weakSelf.contentView);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.contentView).offset(20);
        make.top.mas_equalTo(weakSelf.contentView).offset(20);
    }];
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).offset(15);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
    }];
}

@end
