//
//  UIImage+Data.m
//  zichan
//
//  Created by Mike on 16/6/29.
//  Copyright © 2016年 Mike. All rights reserved.
//

#import "UIImage+Data.h"
#import "UIImage+Modify.h"

@implementation UIImage (Data)

- (NSData *)compressedData {
    NSData *data = nil;
    data = UIImageJPEGRepresentation(self, 0.2);
    if (!data) {
        if (self.size.width && self.size.height) {
            CGFloat factor = self.size.height / self.size.width;
            CGFloat maxFileSize = 500 * 1024; // 500 K
            CGFloat width = sqrt(maxFileSize / 1.5 / factor);
            CGFloat scale = [UIScreen mainScreen].scale;
            UIImage *image = [self imageByResizeToSize:CGSizeMake(width / scale, width * factor / scale)];
            return UIImagePNGRepresentation(image);
        }
    }
    return data;
}

@end
