//
//  CollectionHeaderReusableView.h
//  DXDoctor
//
//  Created by 思 彭 on 17/3/14.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SearchButtonBlock)(void);

@interface CollectionHeaderReusableView : UICollectionReusableView

@property (nonatomic, copy) SearchButtonBlock searchBlock;

@end
