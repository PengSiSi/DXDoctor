//
//  UIView+AdjustFrame.m
//
//  Created by Mike on 15/4/10.
//  Copyright © 2015年 Mike. All rights reserved.

#import "UIView+AdjustFrame.h"

@implementation UIView (AdjustFrame)

#pragma mark - setter

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

#pragma mark - getter

- (CGFloat)x {
    return self.frame.origin.x;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (CGSize)size {
    return self.frame.size;
}

- (CGPoint)origin {
    return self.frame.origin;
}

@end

@implementation UIScrollView (AdjustInsets)

- (void)setContentInsetTop:(CGFloat)contentInsetTop {
    UIEdgeInsets edgeInsets = self.contentInset;
    edgeInsets.top = contentInsetTop;
    self.contentInset = edgeInsets;
}

- (void)setContentInsetLeft:(CGFloat)contentInsetLeft {
    UIEdgeInsets edgeInsets = self.contentInset;
    edgeInsets.left = contentInsetLeft;
    self.contentInset = edgeInsets;
}

- (void)setContentInsetBottom:(CGFloat)contentInsetBottom {
    UIEdgeInsets edgeInsets = self.contentInset;
    edgeInsets.bottom = contentInsetBottom;
    self.contentInset = edgeInsets;
}

- (void)setContentInsetRight:(CGFloat)contentInsetRight {
    UIEdgeInsets edgeInsets = self.contentInset;
    edgeInsets.right = contentInsetRight;
    self.contentInset = edgeInsets;
}

- (CGFloat)contentInsetTop {
    return self.contentInset.top;
}

- (CGFloat)contentInsetLeft {
    return self.contentInset.left;
}

- (CGFloat)contentInsetBottom {
    return self.contentInset.bottom;
}

- (CGFloat)contentInsetRight {
    return self.contentInset.right;
}

@end
