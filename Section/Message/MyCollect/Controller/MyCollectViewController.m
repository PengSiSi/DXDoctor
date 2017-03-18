//
//  MyCollectViewController.m
//  DXDoctor
//
//  Created by 思 彭 on 17/3/18.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "MyCollectViewController.h"
#import "NoDataView.h"
#import "CombancHUD.h"

@interface MyCollectViewController ()

@end

@implementation MyCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    
    [[NoDataView shareNoDataView]showWithSuper:self.view Frame:CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT) icon:nil];
    
//    [[NoDataView shareNoDataView]showCenterWithSuperView:self.view icon:@"" iconClicked:^{
//      
//        [CombancHUD showInfoWithStatus:@"无数据!!!"];
//    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [[NoDataView shareNoDataView]clear];
}

@end
