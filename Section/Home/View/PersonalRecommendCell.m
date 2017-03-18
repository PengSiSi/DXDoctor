//
//  PersonalRecommendCell.m
//  DXDoctor
//
//  Created by 思 彭 on 17/3/16.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "PersonalRecommendCell.h"

@interface PersonalRecommendCell ()
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UILabel *titleLibel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *openRecommendLabel;

- (IBAction)closeButtonDidClick:(id)sender;

@end

@implementation PersonalRecommendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = MAIN_BG_COLOR;
    self.openRecommendLabel.textColor = MAIN_COLOR;
}


- (IBAction)closeButtonDidClick:(id)sender {
    
    if (self.closeBlock) {
        self.closeBlock();
    }
}

@end
