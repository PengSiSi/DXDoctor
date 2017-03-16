//
//  SearchCollectionViewCell.m
//  DXDoctor
//
//  Created by 思 彭 on 17/3/15.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "SearchCollectionViewCell.h"

@interface SearchCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *imgButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation SearchCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.font = FONT_14;
    self.titleLabel.textColor = MAIN_COLOR;
}

- (void)setModel:(ItemModel *)model {
    
    _model = model;
    [self.imgButton setBackgroundImage:[UIImage imageNamed:_model.imageName] forState:UIControlStateNormal];
    self.titleLabel.text = self.model.titleName;
}

@end
