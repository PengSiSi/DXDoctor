//
//  MessageHeaderView.h
//  DXDoctor
//
//  Created by 思 彭 on 17/3/14.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MessageHeaderView;

@protocol MessageHeaderViewDelegate <NSObject>

- (void)MessageHeaderView:(MessageHeaderView *)headerView buttonDidClickedAtIndex:(NSUInteger)index;

@end

@interface MessageHeaderView : UIView

@property (nonatomic, assign) id<MessageHeaderViewDelegate> delegate;

@end
