//
//  SearchViewController.m
//  DXDoctor
//
//  Created by 思 彭 on 17/3/14.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "SearchViewController.h"
#import "CollectionHeaderReusableView.h"
#import "SearchCollectionViewCell.h"
#import "ItemModel.h"

#define itemWidth (K_SCREEN_WIDTH / 3)

static NSString *const searchCellID = @"searchCellID";
static NSString *const searchHeaderID = @"searchHeaderID";

@interface SearchViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

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
    return headerView;
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
