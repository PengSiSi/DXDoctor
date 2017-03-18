//
//  NewMessageCell.h
//  DXDoctor
//
//  Created by 思 彭 on 17/3/14.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewMessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *messageImgView;
@property (weak, nonatomic) IBOutlet UILabel *messageTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageContentLabel;

@end
