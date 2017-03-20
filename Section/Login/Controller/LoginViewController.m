//
//  LoginViewController.m
//  DXDoctor
//
//  Created by 思 彭 on 17/3/20.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginTableViewCell.h"

static NSString *const LogginCellIdentify = @"LogCellID";

@interface LoginViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *imagesArray;
@property (nonatomic, strong) NSArray *titlesArray;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    [self initialData];
    [self setupNavItem];
    [self setUI];
}

- (void)initialData {
    
    self.imagesArray = @[@"SmallWeixin", @"SmallWeibo", @"SmallQQ"];
    self.titlesArray = @[@"通过微信账号登录", @"通过微博账号登录", @"通过QQ账号登录"];
}

- (void)setupNavItem {
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancleDidClick)];
    self.navigationItem.leftBarButtonItem.tintColor = MAIN_COLOR;
}

#pragma mark - 设置界面

- (void)setUI {
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = MAIN_BG_COLOR;
    self.tableView.tableFooterView = [[UIView alloc]init];
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"LoginTableViewCell" bundle:nil] forCellReuseIdentifier:LogginCellIdentify];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.imagesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LoginTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LogginCellIdentify forIndexPath:indexPath];
    cell.logTipImgView.image = [UIImage imageNamed:@"self.imagesArray[indexPath.row]"];
    cell.logginTextLabel.text = self.titlesArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 180;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UILabel *label;
    if (section == 0) {
        UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, 30)];
        textLabel.text = @"无需密码,快速登录";
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = FONT_14;
        label = textLabel;
    }
    return label;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, 100)];
    headerView.backgroundColor = MAIN_BG_COLOR;
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, K_SCREEN_WIDTH, 30)];
    textLabel.text = @"或者";
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.font = FONT_15;
    [headerView addSubview:textLabel];
    // 两个按钮
    NSArray *buttonTitleArray = @[@"通过手机/邮箱注册", @"快速注册"];
    UIView *buttonContainView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(textLabel.frame), K_SCREEN_WIDTH, 80)];
    [headerView addSubview:buttonContainView];
    for (NSInteger i = 0; i < buttonTitleArray.count; i++) {
        UIButton *button = [UIButton buttonWithType: UIButtonTypeCustom];
        button.frame = CGRectMake(20, (i * 30) + 10 + (i * 10), K_SCREEN_WIDTH - 40, 30);
        button.layer.borderColor = [UIColor lightGrayColor].CGColor;
        button.layer.borderWidth = 0.5;
        [button setTitle:buttonTitleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        button.titleLabel.font = FONT_14;
        [button addTarget:self action:@selector(registerVuttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [buttonContainView addSubview:button];
    }
    return headerView;
}

#pragma mark - Private Method

- (void)cancleDidClick {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)registerVuttonDidClick: (UIButton *)button {
    
}

@end
