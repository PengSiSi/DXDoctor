//
//  MessageViewController.m
//  DXDoctor
//
//  Created by 思 彭 on 17/3/14.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "MessageViewController.h"
#import "SettingViewController.h"

#import "UIBarButtonItem+Create.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLeftItem];
}

#pragma mark - initData

#pragma mark - 设置界面

- (void)setupLeftItem {
    
    UIBarButtonItem *leftItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"btg_icon_account"] highLightedImage:nil target:self action:@selector(accountButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = leftItem;
}

#pragma mark - UITableViewDataSource

#pragma mark - UITableViewDelegate

#pragma mark - Private Method

- (void)accountButtonDidClick: (UIBarButtonItem *)barItem {
    
    SettingViewController *settingVc = [[SettingViewController alloc]init];
    settingVc.navigationItem.backBarButtonItem.tintColor = MAIN_COLOR;
    [self.navigationController pushViewController:settingVc animated:YES];
}

#pragma mark - 懒加载


@end
