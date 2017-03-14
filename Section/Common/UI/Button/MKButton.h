//
//  MKButton.h
//  MKButton
//
//  Created by Mike on 16/10/12.
//  Copyright © 2016年 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LinearType) {
    LinearTypeHorizontal,
    LinearTypeVertical
};

@interface MKButton : UIButton

@property (nonatomic, strong) NSValue *backgroudRect;
@property (nonatomic, strong) NSValue *contentRect;
@property (nonatomic, strong) NSValue *imageRect;
@property (nonatomic, strong) NSValue *titleRect;

@property (nonatomic, assign) LinearType linearType;
@property (nonatomic, strong) NSValue *imageOutlineEdgeInsets;
@property (nonatomic, strong) NSValue *titleOutlineEdgeInsets;

@end
