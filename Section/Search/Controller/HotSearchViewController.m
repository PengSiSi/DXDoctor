//
//  HotSearchViewController.m
//  DXDoctor
//
//  Created by 思 彭 on 17/3/20.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "HotSearchViewController.h"
#import "SearchDetailViewController.h"
#import <PYSearch.h>
#import "FMTagsView.h"

#import "SearchTagsCell.h"
#import "HeaderView.h"

static NSString *SearchHistoryCellIdentify = @"SearchHistoryCellID";
static NSString *HotSearchCellIdentify = @"HotSearchCellID";

@interface HotSearchViewController ()<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, PYSearchViewControllerDelegate>

@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *searchHistoryMutableArray;
@property (nonatomic, strong) NSMutableArray *hotsearchMutableArray;
@property (nonatomic, strong) FMTagsView *tagsView;

@end

@implementation HotSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self setupNav];
    [self readNSUserDefaults];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [self.searchTextField removeFromSuperview];
}

-(void)readNSUserDefaults
{
    //读取数组NSArray类型的数据
    self.searchHistoryMutableArray = [USERDEFAULT_OBJ4KEY(k_searchHistoryArray) copy];
//    self.tableView.tableHeaderView = [self setHeaderView];
//    self.tableView.tableFooterView = [self setHeaderView];
    [self.tableView reloadData];
}

- (void)setupNav {
    
    self.searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(80, 5, K_SCREEN_WIDTH - 80 - 20, 30)];
    self.searchTextField.backgroundColor = MAIN_BG_COLOR;
    self.searchTextField.keyboardType = UIKeyboardTypeWebSearch;
    self.searchTextField.delegate = self;
    self.searchTextField.layer.cornerRadius = 5;
    self.searchTextField.layer.masksToBounds = YES;
//    self.navigationItem.titleView = searchTextField;
    [self.navigationController.navigationBar addSubview:self.searchTextField];
}

#pragma mark - 设置界面

- (void)setUI {
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = MAIN_BG_COLOR;
//    self.tableView.tableFooterView = [[UIView alloc]init];
//    self.tableView.estimatedRowHeight = 100;
    // 注册cell
    [self.tableView registerClass:[SearchTagsCell class] forCellReuseIdentifier:HotSearchCellIdentify];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
//    self.tableView.tableHeaderView = [self setHeaderView];
//    self.tableView.tableFooterView = [self setHeaderView];
}

- (HeaderView *)setHeaderView {

    HeaderView *headerView = [[HeaderView alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, 200)];
    headerView.dataArray = self.searchHistoryMutableArray;
    return headerView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.searchHistoryMutableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.searchHistoryMutableArray[indexPath.row];
    cell.textLabel.font = FONT_14;
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

//    if (indexPath.section == 0) {
//        
//        return [tableView fd_heightForCellWithIdentifier:HotSearchCellIdentify configuration:^(SearchTagsCell *cell) {
//            cell.dataArray = self.searchHistoryMutableArray;
//        }];
//    } else {
//        return 0.001f;
//    }
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, 30)];
    bgView.backgroundColor = MAIN_BG_COLOR;
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, K_SCREEN_WIDTH, 20)];
    [bgView addSubview:titleLabel];
    titleLabel.font = FONT_14;
    titleLabel.textColor = [UIColor lightGrayColor];
    
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    clearButton.frame = CGRectMake(K_SCREEN_WIDTH - 60, 10, 50, 20);
    clearButton.backgroundColor = MAIN_COLOR;
    clearButton.titleLabel.font = FONT_14;
    clearButton.hidden = YES;
    [clearButton setTitle:@"清空" forState:UIControlStateNormal];
    [clearButton addTarget:self action:@selector(clearHistoryButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:clearButton];
    if (section == 0) {
        titleLabel.text = @"搜索历史";
        clearButton.hidden = NO;
    } else {
        titleLabel.text = @"热门搜索";
    }
    return bgView;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (self.searchTextField.text.length == 0) {
        [CombancHUD showInfoWithStatus:@"搜索内容不能为空"];
        return;
    }
    NSMutableArray *searTXT = [[NSMutableArray alloc] init];
    if (self.searchHistoryMutableArray) {
        searTXT = [self.searchHistoryMutableArray mutableCopy];
    }
    // 判断数组中的重复数据
    if (![searTXT containsObject:self.searchTextField.text]) {
        [searTXT addObject:self.searchTextField.text];
    }
    //将上述数据全部存储到NSUserDefaults中
    USERDEFAULT_SETOBJ4KEY(searTXT, k_searchHistoryArray);
    SearchDetailViewController *detailVc = [[SearchDetailViewController alloc]init];
    [self.navigationController pushViewController:detailVc animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.searchTextField resignFirstResponder];
    return YES;
}

#pragma mark - 懒加载

- (NSMutableArray *)searchHistoryMutableArray {
    
    if (!_searchHistoryMutableArray) {
        _searchHistoryMutableArray = [NSMutableArray array];
    }
    return _searchHistoryMutableArray;
}

#pragma mark - Private Method

- (void)clearHistoryButtonDidClick {
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes removeObjectForKey:k_searchHistoryArray];
    [self readNSUserDefaults];
}

@end
