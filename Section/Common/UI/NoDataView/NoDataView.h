//
//  NoDataView.h
//  DXDoctor
//
//  Created by 思 彭 on 17/3/18.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^iconClicked) ();

@interface NoDataView : UIView

@property (nonatomic, copy) NSString *titleString;
@property (nonatomic, copy) NSString *subTitleString;

/**
 *  创建单例(全局实例一个对象)
 *
 *  @return BJNoDataView
 */
+ (NoDataView*)shareNoDataView;
/**
 *  创建实例(全局可以实例多个对象)
 *
 *  @return BJNoDataView
 */
+ (instancetype)noDataView;

/**
 *  展示在父视图的中心
 *
 *  @param view 父视图
 *  @param icon  图片（默认no_data）
 */
- (void)showCenterWithSuperView:(UIView *)view icon:(NSString *)icon;

/**
 *  展示
 *
 *  @param view 父视图
 *  @param frame 在父视图中的frame
 *  @param icon  图片（默认no_data）
 */
- (void)showWithSuper:(UIView *)view Frame:(CGRect)frame icon:(NSString *)icon;

/**
 *  展示在父视图的中心
 *
 *  @param view       父视图
 *  @param icon        图片（默认no_data）
 *  @param iconClicked 图片点击回调
 */
- (void)showCenterWithSuperView:(UIView *)view icon:(NSString *)icon iconClicked:(iconClicked)iconClicked;

/**
 *  展示
 *
 *  @param view       父视图
 *  @param frame       在父视图中的frame
 *  @param icon        图片（默认no_data）
 *  @param iconClicked 图片点击回调
 */
- (void)showWithSuper:(UIView*)view Frame:(CGRect)frame icon:(NSString*)icon iconClicked:(iconClicked)iconClicked;

/**
 *  清除视图（推荐）
 */
- (void)clear;
/**
 *  彻底清除占位图
 */
- (void)wipeOut;

@end
