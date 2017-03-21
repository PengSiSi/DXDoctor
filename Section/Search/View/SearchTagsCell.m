//
//  SearchTagsCell.m
//  DXDoctor
//
//  Created by 思 彭 on 17/3/20.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "SearchTagsCell.h"
#import "FMTagsView.h"

@interface SearchTagsCell ()<FMTagsViewDelegate>

@property (nonatomic, strong) FMTagsView *tagsView;

@end

@implementation SearchTagsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews {
    
    _tagsView = [[FMTagsView alloc]init];
    [self.contentView addSubview:_tagsView];
    [_tagsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.contentView).offset(10);
        make.right.bottom.mas_equalTo(self.contentView).offset(-10);
    }];
    _tagsView.contentInsets = UIEdgeInsetsZero;
    _tagsView.tagInsets = UIEdgeInsetsMake(5, 15, 5, 15);
    _tagsView.tagBorderWidth = 1;
    _tagsView.tagcornerRadius = 2;
    _tagsView.tagBorderColor = [UIColor lightGrayColor];
    _tagsView.tagSelectedBorderColor = [UIColor lightGrayColor];
    _tagsView.tagBackgroundColor = [UIColor whiteColor];
    _tagsView.lineSpacing = 10;
    _tagsView.interitemSpacing = 10;
    _tagsView.tagFont = [UIFont systemFontOfSize:14];
    _tagsView.tagTextColor = [UIColor grayColor];
    _tagsView.tagSelectedBackgroundColor = _tagsView.tagBackgroundColor;
    _tagsView.tagSelectedTextColor = _tagsView.tagTextColor;
    _tagsView.delegate = self;
}

- (void)setDataArray:(NSArray *)dataArray {
    
    _dataArray = dataArray;
    _tagsView.tagsArray = self.dataArray;
}

#pragma mark - FMTagsViewDelegate

- (void)tagsView:(FMTagsView *)tagsView didSelectTagAtIndex:(NSUInteger)index {
    NSString *selectedKey = self.dataArray[index];
    
}

@end
