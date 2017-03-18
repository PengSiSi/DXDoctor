//
//  RecommendViewController.m
//  DXDoctor
//
//  Created by 思 彭 on 17/3/16.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "RecommendViewController.h"
#import "RecommendCellCell.h"
#import "RecommendNoImageCell.h"
#import "PersonalRecommendCell.h"

static NSString *const recommendCellID = @"RecommendCellCellID";
static NSString *const recommendNoImageCellID = @"RecommendNoImageCell";
static NSString *const personRecommendCellID = @"PersonalRecommendCellID";

@interface RecommendViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) BOOL recommendFlag;

@end

@implementation RecommendViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialData];
    [self setUI];
}

#pragma mark - InitialData

- (void)initialData {

    // recommendFlag == 9 显示个性推荐
    self.recommendFlag = 0;
}


#pragma mark - 设置界面

- (void)setUI {
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = [[UIView alloc]init];
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"RecommendCellCell" bundle:nil] forCellReuseIdentifier:recommendCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RecommendNoImageCell" bundle:nil] forCellReuseIdentifier:recommendNoImageCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"PersonalRecommendCell" bundle:nil] forCellReuseIdentifier:personRecommendCellID];
    [self.view addSubview: self.tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // recommendFlag == YES 不显示个性推荐
    // 本来通过这个判断会出bug,还是直接改变cell的高度即可
    if (section == 0) {
        return 3;
    } else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            RecommendCellCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendCellID forIndexPath:indexPath];
            return cell;
        } else if (indexPath.row == 1 && self.recommendFlag == NO) {
            PersonalRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:personRecommendCellID forIndexPath:indexPath];
            // "关闭"
            cell.closeBlock = ^() {
                self.recommendFlag = YES;
                [self.tableView reloadData];
            };
            return cell;
        } else {
            RecommendNoImageCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendNoImageCellID forIndexPath:indexPath];
            return cell;
        }
    } else {
        if (indexPath.row == 0) {
            RecommendCellCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendCellID forIndexPath:indexPath];
            return cell;
        } else {
            RecommendNoImageCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendNoImageCellID forIndexPath:indexPath];
            return cell;
        }
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return FLT_EPSILON;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            if (self.recommendFlag == YES) {
                return 0.0001f;
            }
        } else {
            return 185;
        }
    }
    return 190;
}

@end
