//
//  SearchViewController.m
//  DXDoctor
//
//  Created by 思 彭 on 17/3/14.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "SearchViewController.h"
#import "HotSearchViewController.h"

#import "CollectionHeaderReusableView.h"
#import "SearchCollectionViewCell.h"
#import "ItemModel.h"
#import <PYSearchViewController.h>
#import "SearchDetailViewController.h"
#import "HotSearchTagsVc.h"

#define itemWidth (K_SCREEN_WIDTH / 3)

static NSString *const searchCellID = @"searchCellID";
static NSString *const searchHeaderID = @"searchHeaderID";

@interface SearchViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PYSearchViewControllerDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSMutableArray *modelArray;

@end

@implementation SearchViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialData];
    [self setupUI];
}

#pragma mark - InitialData

- (void)initialData {
    
    NSArray *imgNameArray = @[@"disease-icon", @"article-icon", @"hot-comment-header", @"hospital-icon-1", @"hot-comment-header", @"disease-icon", @"hospital-icon-1"];
    NSArray *titleNameArray = @[@"查疾病", @"查药品", @"查文章", @"找药店", @"查疫苗", @"就医推荐", @"常见病症"];
    // 数据转model
    [imgNameArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ItemModel *model = [[ItemModel alloc]init];
        model.imageName = imgNameArray[idx];
        model.titleName = titleNameArray[idx];
        [self.modelArray addObject:model];
    }];
}

#pragma mark - 设置界面

- (void)setupUI {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(itemWidth, itemWidth - 20);
    layout.headerReferenceSize = CGSizeMake(K_SCREEN_WIDTH, 200);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.collectionView];
    // 注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"SearchCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:searchCellID];
    [self.collectionView registerClass:[CollectionHeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:searchHeaderID];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(itemWidth, itemWidth - 20);
}

// 注意itemWidth一定要和此代理结合使用...否则不能正确排列
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.modelArray.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    CollectionHeaderReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:searchHeaderID forIndexPath:indexPath];
    headerView.searchBlock = ^(void) {
      // 跳转搜索页面
        //HotSearchViewController *hotSearchVc =  [[HotSearchViewController alloc]init];
        HotSearchTagsVc *hotSearchVc = [[HotSearchTagsVc alloc]init];
        [self.navigationController pushViewController:hotSearchVc animated:YES];
//        // 1. 创建热门搜索
//        NSArray *hotSeaches = @[@"Java", @"Python", @"Objective-C", @"Swift", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
//        // 2. 创建控制器
//        PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:NSLocalizedString(@"请输入", @"搜索编程语言") didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
//            // 开始搜索执行以下代码
//            // 如：跳转到指定控制器
//            [searchViewController.navigationController pushViewController:[[SearchDetailViewController alloc] init] animated:YES];
//        }];
//        // 3. 设置风格
//        if (indexPath.section == 0) { // 选择热门搜索
//            searchViewController.hotSearchStyle = PYHotSearchStyleDefault; // 热门搜索风格为默认
//            searchViewController.searchHistoryStyle = (NSInteger)indexPath.row; // 搜索历史风格根据选择
//        } else { // 选择搜索历史
//            searchViewController.hotSearchStyle = (NSInteger)indexPath.row; // 热门搜索风格根据选择
//            searchViewController.searchHistoryStyle = PYHotSearchStyleDefault; // 搜索历史风格为default
//        }
//        // 4. 设置代理
//        searchViewController.delegate = self;
//        // 5. 跳转到搜索控制器
//        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
//        [self presentViewController:nav animated:YES completion:nil];
    };
    return headerView;
}

#pragma mark - PYSearchViewControllerDelegate
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    if (searchText.length) { // 与搜索条件再搜索
        // 根据条件发送查询（这里模拟搜索）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ // 搜索完毕
            // 显示建议搜索结果
            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
            for (int i = 0; i < arc4random_uniform(5) + 10; i++) {
                NSString *searchSuggestion = [NSString stringWithFormat:@"搜索建议 %d", i];
                [searchSuggestionsM addObject:searchSuggestion];
            }
            // 返回
            searchViewController.searchSuggestions = searchSuggestionsM;
        });
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:searchCellID forIndexPath:indexPath];
    cell.model = self.modelArray[indexPath.item];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - 懒加载

- (NSMutableArray *)modelArray {
    
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

@end
