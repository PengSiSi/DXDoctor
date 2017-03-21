//
//  HeaderView.m
//  DXDoctor
//
//  Created by 思 彭 on 17/3/21.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "HeaderView.h"
#import "FMTagsView.h"

@interface HeaderView ()<FMTagsViewDelegate>

@property (nonatomic, strong) FMTagsView *tagsView;
@property (nonatomic, strong) UILabel *hostorySearchLabel;

@end

@implementation HeaderView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
    }
    return self;
}
- (void)createSubViews {
    
    self.hostorySearchLabel = [[UILabel alloc]init];
    self.hostorySearchLabel.text = @"历史搜索";
    self.hostorySearchLabel.font = FONT_15;
    self.hostorySearchLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:self.hostorySearchLabel];
    _tagsView = [[FMTagsView alloc]init];
    [self addSubview:_tagsView];
    [self.hostorySearchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(10);
        make.top.mas_equalTo(self).offset(10);
        make.right.mas_equalTo(self).offset(-10);
        make.height.mas_equalTo(30);
    }];

    [_tagsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(10);
        make.top.mas_equalTo(self.hostorySearchLabel.mas_bottom).offset(10);
        make.right.bottom.mas_equalTo(self).offset(-10);
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
