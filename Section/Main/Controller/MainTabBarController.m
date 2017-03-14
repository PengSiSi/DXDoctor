//
//  MainTabBarController.m
//  DXDoctor
//
//  Created by 思 彭 on 17/3/14.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "MainTabBarController.h"
#import "BaseNavigationController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTabBar];
}

- (void)setTabBar {
    
    NSArray *normalImage = @[@"home-page_doucment_button_not-click", @"home-page_search_button_not-click",@"home-page_doucment_button_not-click"];
    NSArray *selectImage = @[@"home-page_doucment_button_click", @"home-page_search_button_click",@"home-page_doucment_button_click"];
    NSArray *vcClass = @[@"HomeViewController", @"SearchViewController", @"MessageViewController"];
//    NSArray *tabbarTitleAray = @[@"首页",@"搜索",@"消息"];
    NSArray *titleArray = @[@"首页",@"搜索",@"消息"];
    NSMutableArray *allArray = [NSMutableArray array];
    
    for (int i = 0; i < normalImage.count; i++) {
        Class cla = NSClassFromString(vcClass[i]);
        UIViewController *vc = [[cla alloc] init];
        vc.title = titleArray[i];
        vc.navigationItem.title = titleArray[i];
        [vc.tabBarItem setTitle:titleArray[i]];
        [vc.tabBarItem setImage:[[UIImage imageNamed:normalImage[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [vc.tabBarItem setSelectedImage:[[UIImage imageNamed:selectImage[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
        [allArray addObject:nav];
    }
    //设置navigationBar样式
    [self setUpNavigationBarAppearance];
    //tabBarItem 的选中和不选中文字属性
    [self setUpTabBarItemTextAttributes];
    
    // 这句必须写!
    self.viewControllers = allArray;
}

/**
 *  设置navigationBar样式
 */
- (void)setUpNavigationBarAppearance {
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    UIImage *backgroundImage = nil;
    NSDictionary *textAttributes = nil;
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        backgroundImage = [UIImage imageNamed:@"navigationBar_BG"];
        
        textAttributes = @{
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
                           NSForegroundColorAttributeName: [UIColor whiteColor],
                           };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        backgroundImage = [UIImage imageNamed:@"navigationBar_BG"];
        
        textAttributes = @{
                           UITextAttributeFont: [UIFont boldSystemFontOfSize:18],
                           UITextAttributeTextColor: [UIColor blackColor],
                           UITextAttributeTextShadowColor: [UIColor clearColor],
                           UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }
    
    [navigationBarAppearance setBackgroundImage:backgroundImage
                                  forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}

/**
 *  tabBarItem 的选中和不选中文字属性
 */
- (void)setUpTabBarItemTextAttributes {
    
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = MAIN_COLOR;
    
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // 设置背景图片
//    UITabBar *tabBarAppearance = [UITabBar appearance];
    //    [tabBarAppearance setBackgroundImage:[UIImage imageNamed:@"tabbarBG"]];
//    tabBarAppearance.barTintColor = MAIN_COLOR;
}
@end
