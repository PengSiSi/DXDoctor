//
//  NewMessageCell.m
//  DXDoctor
//
//  Created by 思 彭 on 17/3/14.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "NewMessageCell.h"

@implementation NewMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.messageTitleLabel.font = FONT_15;
    self.messageContentLabel.font = FONT_14;
}


@end
