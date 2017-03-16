
//
//  HomeViewController.m
//  DXDoctor
//
//  Created by 思 彭 on 17/3/14.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "HomeViewController.h"
#import "ContentViewController.h"
#import "SpecialViewController.h"
#import "RecommendViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setupTitleView];
    self.title = @"丁香医生";
}

- (void)setupTitleView {
    
    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"title"]];
    imgView.frame = CGRectMake(0, 0, 50, 40);
    self.navigationItem.titleView = imgView;
}

- (instancetype)init {
    if (self = [super init]) {
        self.menuBGColor = MAIN_BG_COLOR;
        self.menuViewStyle = WMMenuViewStyleFlood;
        self.menuItemWidth = K_SCREEN_WIDTH / 6;
        self.titleSizeNormal = 14;
        self.titleSizeSelected = 14;
        self.progressColor = MAIN_COLOR; //进度条颜色
        self.progressHeight = 20;
        self.progressWidth = K_SCREEN_WIDTH / 6 - 5;
        self.titleColorSelected = [UIColor whiteColor]; //标题选中时的颜色
        self.titleColorNormal = MAIN_COLOR;  //标题非选中的颜色
        self.menuBGColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"head_background_long2"]];
        self.menuHeight = PAGEVC_MENU_HEIGHT;
    }
    return self;
}

- (NSArray *)titles {

    return @[@"推荐", @"专题", @"真相", @"两性", @"不孕不育", @"一图读懂", @"肿瘤", @"慢病", @"营养", @"母婴"];
}

#pragma mark - WMPageControllerDataSource

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    
    return self.titles.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {

    if (index == 0) {
        RecommendViewController *recommendVc = [[RecommendViewController alloc]init];
        return recommendVc;
    } else if (index == 1) {
        SpecialViewController *specialVc = [[SpecialViewController alloc]init];
        return specialVc;
    } else {
        ContentViewController *contentVc = [[ContentViewController alloc]init];
        return contentVc;
    }
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    return self.titles[index];
}

- (void)pageController:(WMPageController *)pageController willEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info {
    
}

- (void)menuView:(WMMenuView *)menu didLayoutItemFrame:(WMMenuItem *)menuItem atIndex:(NSInteger)index {
    //    NSLog(@"frame---%@", NSStringFromCGRect(menuItem.frame));
}

- (void)pageController:(WMPageController *)pageController didEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info {
    
}

@end
