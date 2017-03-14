//
//  FocusTableViewCell.h
//  DXDoctor
//
//  Created by 思 彭 on 17/3/14.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FocusTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *recommendLabel;
@property (weak, nonatomic) IBOutlet UILabel *topContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomContentLabel;
@property (weak, nonatomic) IBOutlet UIButton *focusButton;
- (IBAction)FocusButtonClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *rightItem;

@end
