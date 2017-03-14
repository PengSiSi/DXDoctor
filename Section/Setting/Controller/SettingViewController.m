//
//  SettingViewController.m
//  DXDoctor
//
//  Created by 思 彭 on 17/3/14.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "SettingViewController.h"
#import "LabelSwitchCell.h"

#import "UIBarButtonItem+Create.h"

static NSString *const labelSwitchCellIdentify = @"LabelSwitchCellId";

@interface SettingViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray;


@end

@implementation SettingViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self initialData];
    [self setupUI];
}

#pragma mark - initData

- (void)initialData {
    
    self.titleArray = @[@[@"立即登录"],
                        @[@"推荐给朋友", @"帮助与反馈"],
                        @[@"内置音效", @"推送消息设置"],
                        @[@"去好评", @"隐私保护", @"关于我们"]];
}

#pragma mark - 设置界面

- (void)setupUI {
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = [[UIView alloc]init];
    // 注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LabelSwitchCell" bundle:nil] forCellReuseIdentifier:labelSwitchCellIdentify];
    [self.view addSubview: self.tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return ((NSArray *)self.titleArray[section]).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 2 && indexPath.row == 0) {
        
        LabelSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:labelSwitchCellIdentify forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = @"内置音效";
        cell.titleLabel.font = FONT_15;
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        [self configureSettingTableViewCell:cell atIndexPath:indexPath];
        return cell;
    }
    return nil;
}

- (void)configureSettingTableViewCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.titleArray[indexPath.section][indexPath.row];
    cell.textLabel.font = FONT_15;
    if (indexPath.section == 0) {
        cell.textLabel.textColor = MAIN_COLOR;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, 20)];
    return titleLabel;
}

#pragma mark - 懒加载


@end
