//
//  NoDataView.m
//  DXDoctor
//
//  Created by 思 彭 on 17/3/18.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "NoDataView.h"

#define kAnimateDuration 0.25f
#define viewWidth = K_SCREEN_WIDTH
#define viewHeight = 300

@interface NoDataView ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, copy) iconClicked iconClicked;

@end

@implementation NoDataView

+ (NoDataView*)shareNoDataView {
    
    static NoDataView *instance;
    if (!instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            instance = [[self alloc]init];
        });
    }
    return instance;
}

+ (instancetype)noDataView {
    
    return [[self alloc]init];
}

- (instancetype)init {
    
    if (self = [super init]) {
        [self createSubViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
    }
    return self;
}

#pragma mark - 创建子视图

- (void)createSubViews {
    
    self.backgroundColor = [UIColor redColor];
    [self addSubview:self.imgView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.subTitleLabel];
    [self layOutUI];
}

- (void)layOutUI {
    
    __weak typeof(self) weakSelf = self;
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf);
        make.height.with.mas_equalTo(100);
        make.top.mas_equalTo(100);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.imgView.mas_bottom).offset(10);
        make.left.mas_equalTo(weakSelf).offset(40);
        make.right.mas_equalTo(weakSelf).offset(-40);
    }];
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(weakSelf).offset(20);
        make.right.mas_equalTo(weakSelf).offset(-20);
    }];
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    //设置iconView的位置
//    self.imgView.center = self.center;
}

-(void)showSuper:(UIView *)view icon:(NSString *)icon {
    
    if (!view) {
        // 抛出异常
        NSException *excp = [NSException exceptionWithName:@"NoDataViewException" reason:@"未设置父视图。" userInfo:nil];
        [excp raise];
        return;
    };
    icon = icon ? icon : @"askdoctor_avatar";
    self.backgroundColor = view.backgroundColor;
    [view insertSubview:self atIndex:0];  //插在父视图中的最底层(看情况设置)
    self.imgView.image = [UIImage imageNamed:icon];
}

- (void)showWithSuper:(UIView *)view Frame:(CGRect)frame icon:(NSString *)icon {
    
    [self showSuper:view icon:icon];
    self.frame = view.frame;
}

- (void)showWithSuper:(UIView *)view Frame:(CGRect)frame icon:(NSString *)icon iconClicked:(iconClicked)iconClicked {
    
    [self showSuper:view icon:icon];
    self.iconClicked = iconClicked;
}

- (void)showCenterWithSuperView:(UIView *)view icon:(NSString *)icon {
    
    [self showSuper:view icon:icon];
    self.frame = view.bounds;
}

- (void)showCenterWithSuperView:(UIView *)view icon:(NSString *)icon iconClicked:(iconClicked)iconClicked {
    
    [self showCenterWithSuperView:view icon:icon];
    self.iconClicked=iconClicked;
}

//图片点击动画
+ (void)animationPopupWith:(UIView*)aview duration:(CGFloat)duration{
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = duration ? duration : 0.5f;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.6, 0.6, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [aview.layer addAnimation:animation forKey:nil];
}

#pragma mark - 视图的显示/移除

- (void)clear {
    
    !self ? : [self removeFromSuperview];
}

- (void)wipeOut {
    
    for (UIView *subView in self.superview.subviews) {
        if ([subView isKindOfClass:[NoDataView class]]) {
            [subView removeFromSuperview];
        }
    }
}

#pragma mark - 懒加载

- (UIImageView *)imgView {
    
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        _imgView.userInteractionEnabled=YES;
        [_imgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClicked)]];
        _imgView.frame = CGRectMake(0, 0, 100, 100);
    }
    return _imgView;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = FONT_15;
        _titleLabel.numberOfLines = 0;
        _titleLabel.text = @"暂无收藏";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor darkTextColor];
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel {
    
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc]init];
        _subTitleLabel.text = @"暂无数据";
        _subTitleLabel.font = FONT_15;
        _subTitleLabel.numberOfLines = 0;
        _subTitleLabel.textAlignment = NSTextAlignmentCenter;
        _subTitleLabel.textColor = [UIColor lightGrayColor];
    }
    return _subTitleLabel;
}

#pragma mark - Private Method

- (void)imageViewClicked {
    
    if (self.iconClicked) {
        [NoDataView animationPopupWith:self.imgView duration:kAnimateDuration];
        self.iconClicked();
    }
}

#pragma mark - Setter/Getter
- (void)setTitleString:(NSString *)titleString {
    
    self.titleLabel.text = titleString;
}

- (void)setSubTitleString:(NSString *)subTitleString {
    
    self.subTitleLabel.text = subTitleString;
}
@end
