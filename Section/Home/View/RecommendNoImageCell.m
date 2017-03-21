//
//  RecommendNoImageCell.m
//  DXDoctor
//
//  Created by 思 彭 on 17/3/16.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "RecommendNoImageCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface RecommendNoImageCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avaterImgView;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;

@end

@implementation RecommendNoImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setListModel:(RecommendListModel *)listModel {
    
    self.titleLabel.text = listModel.title;
//    self.contentLabel.text = listModel.con
    [self.avaterImgView sd_setImageWithURL:[NSURL URLWithString:listModel.author.avatar]];
    self.authorLabel.text = listModel.author.name;
    self.sourceLabel.text = listModel.author.remarks;
}

@end
