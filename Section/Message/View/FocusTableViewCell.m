//
//  FocusTableViewCell.m
//  DXDoctor
//
//  Created by 思 彭 on 17/3/14.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "FocusTableViewCell.h"

@implementation FocusTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.focusButton.backgroundColor = MAIN_COLOR;
    [self.focusButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}


- (IBAction)FocusButtonClick:(id)sender {
    
}

@end
