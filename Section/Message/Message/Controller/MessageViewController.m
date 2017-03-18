//
//  MessageViewController.m
//  DXDoctor
//
//  Created by 思 彭 on 17/3/14.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "MessageViewController.h"
#import "SettingViewController.h"
#import "MessageHeaderView.h"
#import "NewMessageCell.h"
#import "FocusTableViewCell.h"
#import "CombancHUD.h"

#import "UIBarButtonItem+Create.h"

static NSString *const NewMessageCellID = @"NewMessageCellID";
static NSString *const FocusCellID = @"FocusCellID";

@interface MessageViewController () <UITableViewDelegate, UITableViewDataSource, MessageHeaderViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation MessageViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLeftItem];
    [self setUI];
}

#pragma mark - initData

#pragma mark - 设置界面

- (void)setupLeftItem {
    
    UIBarButtonItem *leftItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"btg_icon_account"] highLightedImage:nil target:self action:@selector(accountButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = leftItem;
}

#pragma mark - 设置界面

- (void)setUI {
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"NewMessageCell" bundle:nil] forCellReuseIdentifier:NewMessageCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"FocusTableViewCell" bundle:nil] forCellReuseIdentifier:FocusCellID];
    [self.view addSubview: self.tableView];
    
    MessageHeaderView *headerView = [[MessageHeaderView alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, 80)];
    headerView.delegate = self;
    self.tableView.tableHeaderView = headerView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0 == section ? 1 : 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        NewMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:NewMessageCellID forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    } else {
        FocusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FocusCellID forIndexPath:indexPath];
        cell.backgroundColor = MAIN_BG_COLOR;
        return cell;
    }
    return nil;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return FLT_EPSILON;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return FLT_EPSILON;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 70;
    } else {
        
        return 115;
//        return [tableView fd_heightForCellWithIdentifier:FocusCellID configuration:^(id cell) {
//            
//        }];
    }
    return 0.001f;
}

#pragma mark - MessageHeaderViewDelegate

- (void)MessageHeaderView:(MessageHeaderView *)headerView buttonDidClickedAtIndex:(NSUInteger)index {
    
    switch (index) {
        case 0:
//            [CombancHUD showInfoWithStatus:@"我的收藏"];
            break;
        case 1:
            [CombancHUD showInfoWithStatus:@"我的关注"];
            break;
        case 2:
            [CombancHUD showInfoWithStatus:@"我的药箱"];
            break;
        default:
            break;
    }
}

#pragma mark - Private Method

- (void)accountButtonDidClick: (UIBarButtonItem *)barItem {
    
    SettingViewController *settingVc = [[SettingViewController alloc]init];
    settingVc.navigationItem.backBarButtonItem.tintColor = MAIN_COLOR;
    [self.navigationController pushViewController:settingVc animated:YES];
}

#pragma mark - 懒加载

- (NSArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

@end
