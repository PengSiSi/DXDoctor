//
//  BaseNavigationController.m
//  PSWeather
//
//  Created by 思 彭 on 16/11/16.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "BaseNavigationController.h"
#import "UIBarButtonItem+Create.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

+ (void)initialize {
    [super initialize];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    UINavigationBar *navBarAppearance = [UINavigationBar appearanceWhenContainedIn:self, nil];
#pragma clang diagnostic pop
    [navBarAppearance setShadowImage:[[UIImage alloc] init]];
    [navBarAppearance setBarTintColor:MAIN_COLOR];
    if (IOS8_OR_LATER) {
        navBarAppearance.translucent = NO;
    }
    NSDictionary *attrs = @{
                            NSFontAttributeName : [UIFont systemFontOfSize:18],
                            NSForegroundColorAttributeName : [UIColor whiteColor]};
    navBarAppearance.titleTextAttributes = attrs;
    navBarAppearance.tintColor = [UIColor whiteColor];
    
}

#pragma mark - 重写UINavigationController中的方法

- (void)viewDidLoad {
    self.navigationBar.shadowImage = [[UIImage alloc] init];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
        // 添加默认的返回按钮
        UIBarButtonItem *item = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"back-icon"] highLightedImage:nil target:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = item;
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark - back

- (void)back:(UIButton *)sender {
    [self popViewControllerAnimated:YES];
}


@end
