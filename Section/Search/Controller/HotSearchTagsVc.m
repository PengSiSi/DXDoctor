//
//  HotSearchTagsVc.m
//  DXDoctor
//
//  Created by 思 彭 on 17/3/31.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "HotSearchTagsVc.h"
#import "HXTagsCell.h"
#import "SearchDetailViewController.h"

static NSString *SearchHistoryCellIdentify = @"SearchHistoryCellID";
static NSString *HotSearchCellIdentify = @"HotSearchCellID";

@interface HotSearchTagsVc ()<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *searchHistoryMutableArray;
@property (nonatomic, strong) NSMutableArray *hotsearchMutableArray;
@property (nonatomic,strong) HXTagCollectionViewFlowLayout *layout;//布局layout
@property (nonatomic,strong) NSArray *selectTags;
@property (nonatomic, strong) HXTagAttribute *attribute;

@end

@implementation HotSearchTagsVc

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

- (NSArray *)tags {
    
    return @[@"过敏性鼻炎",@"咳嗽",@"感冒",@"流感",@"手足口病",@"手术",@"便秘",@"过敏性鼻炎",@"咳嗽",@"感冒",@"流感",@"手足口病",@"手术",@"便秘",@"过敏性鼻炎",@"咳嗽",@"感冒",@"流感",@"手足口病",@"手术",@"便秘",@"过敏性鼻炎",@"咳嗽",@"感冒",@"流感",@"手足口病",@"手术",@"便秘",@"过敏性鼻炎",@"咳嗽",@"感冒",@"流感",@"手足口病",@"手术",@"便秘"];
}

- (NSArray *)tags1 {
    
    return @[@"过敏性鼻炎",@"咳嗽",@"感冒",@"流感"];
}

-(void)readNSUserDefaults
{
    //读取数组NSArray类型的数据
    self.searchHistoryMutableArray = [USERDEFAULT_OBJ4KEY(k_searchHistoryArray) copy];
    [self.tableView reloadData];
}

- (void)setupNav {
    
    self.searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(80, 5, K_SCREEN_WIDTH - 80 - 20, 30)];
    self.searchTextField.backgroundColor = MAIN_BG_COLOR;
    self.searchTextField.keyboardType = UIKeyboardTypeWebSearch;
    self.searchTextField.delegate = self;
    self.searchTextField.layer.cornerRadius = 5;
    self.searchTextField.layer.masksToBounds = YES;
    [self.navigationController.navigationBar addSubview:self.searchTextField];
}

#pragma mark - 设置界面

- (void)setUI {
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = MAIN_BG_COLOR;
    // 注册cell
    [self.tableView registerClass:[HXTagsCell class] forCellReuseIdentifier:HotSearchCellIdentify];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HXTagsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        cell = [[HXTagsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    }
    
    if (indexPath.section == 0) {
        
        cell.tags = self.searchHistoryMutableArray;
    } else {
        cell.tags = self.tags;
    }
    cell.selectedTags = [NSMutableArray arrayWithArray:_selectTags];
    cell.layout = self.layout;
    cell.completion = ^(NSArray *selectTags,NSInteger currentIndex) {
        NSLog(@"selectTags:%@ currentIndex:%ld",selectTags, (long)currentIndex);
        _selectTags = selectTags;
    };
    [cell reloadData];
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
    
//    if (indexPath.section == 1) {
//        
//        CGFloat height = [HXTagsCell getCellHeightWithTags:self.tags1 layout:self.layout tagAttribute:nil width:tableView.frame.size.width];
//        return height;
//    } else {
    
        CGFloat height = [HXTagsCell getCellHeightWithTags:self.searchHistoryMutableArray layout:self.layout tagAttribute:nil width:tableView.frame.size.width];
        return height;
//    }
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
    SearchDetailViewController *searchDetailVc = [[SearchDetailViewController alloc]init];
    [self.navigationController pushViewController:searchDetailVc animated:YES];
    //将上述数据全部存储到NSUserDefaults中
    USERDEFAULT_SETOBJ4KEY(searTXT, k_searchHistoryArray);
    [[NSUserDefaults standardUserDefaults]synchronize];
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

- (HXTagCollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [HXTagCollectionViewFlowLayout new];
        _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return _layout;
}

#pragma mark - Private Method

- (void)clearHistoryButtonDidClick {
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes removeObjectForKey:k_searchHistoryArray];
    [self readNSUserDefaults];
}

@end
