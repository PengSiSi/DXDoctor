
//
//  MKButton.m
//  MKButton
//
//  Created by Mike on 16/10/12.
//  Copyright © 2016年 Mike. All rights reserved.
//

#import "MKButton.h"

@implementation MKButton

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

- (CGRect)backgroundRectForBounds:(CGRect)bounds {
    if (_backgroudRect) return [_backgroudRect CGRectValue];
    return [super backgroundRectForBounds:bounds];
}

- (CGRect)contentRectForBounds:(CGRect)bounds {
    if (_contentRect) return [_contentRect CGRectValue];
    return [super contentRectForBounds:bounds];
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    if (_titleRect) return [_titleRect CGRectValue];
//    if (_titleOutlineEdgeInsets) {
//        UIEdgeInsets outlineEdgeInsets = [_titleOutlineEdgeInsets UIEdgeInsetsValue];
//        if (_linearType == LinearTypeHorizontal) {
//            BOOL isHorizontalFreedom = outlineEdgeInsets.left == 0 || outlineEdgeInsets.right == 0;
//            if (isHorizontalFreedom) {
//                CGFloat width = self.titleLabel;
//                CGFloat height = contentRect.size.height - outlineEdgeInsets.top - outlineEdgeInsets.bottom;
//                return CGRectMake(contentRect.size.width - width - outlineEdgeInsets.right, outlineEdgeInsets.top, width, height);
//            }
//        }
//        if (_linearType == LinearTypeVertical) {
//            BOOL isVerticalFreedom = outlineEdgeInsets.top == 0 || outlineEdgeInsets.bottom == 0;
//            if (isVerticalFreedom && self.currentImage.size.width != 0.f) {
//                CGFloat factor = self.currentImage.size.height / self.currentImage.size.width;
//                CGFloat width = contentRect.size.width - outlineEdgeInsets.left - outlineEdgeInsets.right;
//                return CGRectMake(outlineEdgeInsets.left,
//                                  outlineEdgeInsets.top,
//                                  width,
//                                  width * factor);
//                
//            }
//        }
//        CGFloat width = contentRect.size.width - outlineEdgeInsets.left - outlineEdgeInsets.right;
//        CGFloat height = contentRect.size.height - outlineEdgeInsets.top - outlineEdgeInsets.bottom;
//        return CGRectMake(outlineEdgeInsets.left, outlineEdgeInsets.top, width, height);
//        
//    }
    return [super titleRectForContentRect:contentRect];
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    if (_imageRect) return [_imageRect CGRectValue];
    if (_imageOutlineEdgeInsets) {
        UIEdgeInsets outlineEdgeInsets = [_imageOutlineEdgeInsets UIEdgeInsetsValue];
        if (_linearType == LinearTypeHorizontal) {
            BOOL isHorizontalFreedom = outlineEdgeInsets.left == 0 || outlineEdgeInsets.right == 0;
            if (isHorizontalFreedom && self.currentImage.size.height != 0.f) {
                CGFloat factor = self.currentImage.size.width / self.currentImage.size.height;
                CGFloat height = contentRect.size.height - outlineEdgeInsets.top - outlineEdgeInsets.bottom;
                return CGRectMake(outlineEdgeInsets.left,
                                  outlineEdgeInsets.top,
                                  height * factor,
                                  height);
                
            }
        }
        if (_linearType == LinearTypeVertical) {
            BOOL isVerticalFreedom = outlineEdgeInsets.top == 0 || outlineEdgeInsets.bottom == 0;
            if (isVerticalFreedom && self.currentImage.size.width != 0.f) {
                CGFloat factor = self.currentImage.size.height / self.currentImage.size.width;
                CGFloat width = contentRect.size.width - outlineEdgeInsets.left - outlineEdgeInsets.right;
                return CGRectMake(outlineEdgeInsets.left,
                                  outlineEdgeInsets.top,
                                  width,
                                  width * factor);
                
            }
        }
        CGFloat width = contentRect.size.width - outlineEdgeInsets.left - outlineEdgeInsets.right;
        CGFloat height = contentRect.size.height - outlineEdgeInsets.top - outlineEdgeInsets.bottom;
        return CGRectMake(outlineEdgeInsets.left, outlineEdgeInsets.top, width, height);
        
    }
    return [super imageRectForContentRect:contentRect];
}


@end
