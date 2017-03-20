//
//  LoginTableViewCell.h
//  DXDoctor
//
//  Created by 思 彭 on 17/3/20.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *logTipImgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *logTipTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *logginTextLabel;

@end
