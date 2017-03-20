//
//  MyFocusViewController.m
//  DXDoctor
//
//  Created by 思 彭 on 17/3/18.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "MyFocusViewController.h"
#import "NoDataView.h"

@interface MyFocusViewController ()

@end

@implementation MyFocusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的关注";

    [[NoDataView shareNoDataView]showWithSuper:self.view Frame:CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT) icon:nil iconClicked:^{
       
        // 一般是请求数据的回调
    }];
    [[NoDataView shareNoDataView]setTitleString:@"暂无关注"];
    [[NoDataView shareNoDataView]setSubTitleString:@"暂无关注"];
}

@end
