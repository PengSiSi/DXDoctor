//
//  CombancHUD.m
//  changpingSchoolTeacher
//
//  Created by 王楠 on 16/9/6.
//  Copyright © 2016年 combanc. All rights reserved.
//

#import "CombancHUD.h"

#define DEFAULT_INTERVAL 1

@implementation CombancHUD

#pragma mark - show

+ (void)show {
    [SVProgressHUD show];
    [SVProgressHUD setMinimumDismissTimeInterval:DEFAULT_INTERVAL];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
}

+ (void)showWithTimeInterval:(NSTimeInterval)interval {
    [SVProgressHUD show];
    [SVProgressHUD setMinimumDismissTimeInterval:interval];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
}

+ (void)showWith:(SVProgressHUDMaskType)maskType animationType:(SVProgressHUDAnimationType)animationType hudStyle:(SVProgressHUDStyle)hudStyle timeInterval:(NSTimeInterval)interval {
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:maskType];
    [SVProgressHUD setDefaultAnimationType:animationType];
    [SVProgressHUD setDefaultStyle:hudStyle];
    [SVProgressHUD setMinimumDismissTimeInterval:interval];
}

#pragma mark - showWithStatus

+ (void)showWithStatus:(NSString *)status {
    [SVProgressHUD showWithStatus:status];
    [SVProgressHUD setMinimumDismissTimeInterval:DEFAULT_INTERVAL];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
}

+ (void)showWithStatus:(NSString *)status timeInterval:(NSTimeInterval)interval {
    [SVProgressHUD showWithStatus:status];
    [SVProgressHUD setMinimumDismissTimeInterval:interval];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
}

+ (void)showWithStatus:(NSString *)status maskType:(SVProgressHUDMaskType)maskType animationType:(SVProgressHUDAnimationType)animationType hudStyle:(SVProgressHUDStyle)hudStyle timeInterval:(NSTimeInterval)interval {
    [SVProgressHUD showWithStatus:status];
    [SVProgressHUD setDefaultMaskType:maskType];
    [SVProgressHUD setDefaultAnimationType:animationType];
    [SVProgressHUD setDefaultStyle:hudStyle];
    [SVProgressHUD setMinimumDismissTimeInterval:interval];
}

#pragma mark - showInfo

+ (void)showInfoWithStatus:(NSString *)status {
    [SVProgressHUD showInfoWithStatus:status];
    [SVProgressHUD setMinimumDismissTimeInterval:DEFAULT_INTERVAL];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
}

+(void)showInfoWithStatus:(NSString *)status maskType:(SVProgressHUDMaskType)maskType animationType:(SVProgressHUDAnimationType)animationType hudStyle:(SVProgressHUDStyle)hudStyle timeInterval:(NSTimeInterval)interval {
    [SVProgressHUD showInfoWithStatus:status];
    [SVProgressHUD setDefaultMaskType:maskType];
    [SVProgressHUD setDefaultAnimationType:animationType];
    [SVProgressHUD setDefaultStyle:hudStyle];
    [SVProgressHUD setMinimumDismissTimeInterval:interval];
}

#pragma mark - showSuccess

+ (void)showSuccessWithStatus:(NSString *)status {
    [SVProgressHUD showSuccessWithStatus:status];
    [SVProgressHUD setMinimumDismissTimeInterval:DEFAULT_INTERVAL];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
}

+ (void)showSuccessWithStatus:(NSString *)status maskType:(SVProgressHUDMaskType)maskType animationType:(SVProgressHUDAnimationType)animationType hudStyle:(SVProgressHUDStyle)hudStyle {
    [SVProgressHUD showSuccessWithStatus:status];
    [SVProgressHUD setDefaultMaskType:maskType];
    [SVProgressHUD setDefaultAnimationType:animationType];
    [SVProgressHUD setDefaultStyle:hudStyle];
}

#pragma mark - showError

+ (void)showErrorWithStatus:(NSString *)status {
    [SVProgressHUD showErrorWithStatus:status];
    [SVProgressHUD setMinimumDismissTimeInterval:DEFAULT_INTERVAL];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
}

+ (void)showErrorWithStatus:(NSString *)status maskType:(SVProgressHUDMaskType)maskType animationType:(SVProgressHUDAnimationType)animationType hudStyle:(SVProgressHUDStyle)hudStyle {
    [SVProgressHUD showErrorWithStatus:status];
    [SVProgressHUD setDefaultMaskType:maskType];
    [SVProgressHUD setDefaultAnimationType:animationType];
    [SVProgressHUD setDefaultStyle:hudStyle];
}

+ (void)showErrorWithError:(NSError *)error {
    if ([error.localizedDescription isEqualToString:@"Request failed: internal server error (500)"]) {
        [SVProgressHUD showErrorWithStatus:kREQUESTSERVICEERROR];
    }else if ([error.localizedDescription isEqualToString:@"Request failed: bad request (400)"]) {
        [SVProgressHUD showErrorWithStatus:KREQUESTERRORPASSWORD];
    }else if ([error.localizedDescription isEqualToString:@"请求超时。"]) {
        [SVProgressHUD showErrorWithStatus:KREQUESTOVERTIME];
    }else if ([error.localizedDescription isEqualToString:@"似乎已断开与互联网的连接。"]) {
        [SVProgressHUD showErrorWithStatus:KREQUESTERROR];
    }else if ([error.localizedDescription isEqualToString:@"未能连接到服务器。"]) {
        [SVProgressHUD showErrorWithStatus:kREQUESTSERVICECONNECTERROR];
    }else {
        [SVProgressHUD showErrorWithStatus:kREQUESTUNKNOWERROR];
    }
}

#pragma mark - showImage

+ (void)showImage:(UIImage *)image status:(NSString *)status {
    [SVProgressHUD showImage:image status:status];
}

+ (void)showImage:(UIImage *)image status:(NSString *)status maskType:(SVProgressHUDMaskType)maskType animationType:(SVProgressHUDAnimationType)animationType hudStyle:(SVProgressHUDStyle)hudStyle {
    [SVProgressHUD showImage:image status:status];
    [SVProgressHUD setDefaultMaskType:maskType];
    [SVProgressHUD setDefaultAnimationType:animationType];
    [SVProgressHUD setDefaultStyle:hudStyle];
}

#pragma mark - showProgress

+ (void)showProgress:(float)progress {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showProgress:progress];
}

+ (void)showProgress:(float)progress WithMaskType:(SVProgressHUDMaskType)maskType hudStyle:(SVProgressHUDStyle)hudStyle {
    [SVProgressHUD setDefaultMaskType:maskType];
    [SVProgressHUD setDefaultStyle:hudStyle];
    [SVProgressHUD showProgress:progress];
}

#pragma mark - dismiss

+ (void)dismiss {
    [SVProgressHUD dismiss];
}

+ (void)dismissWithDelay:(NSTimeInterval)delay {
    [SVProgressHUD dismissWithDelay:delay];
}
@end
