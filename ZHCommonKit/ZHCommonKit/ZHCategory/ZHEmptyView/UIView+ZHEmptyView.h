//
//  UIView+ZHEmptyView.h
//  ZHCommonKit
//
//  Created by Mac on 2018/11/29.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@class ZHEmptyView;

@interface UIView (ZHEmptyView)

@property(nonatomic,strong,nullable)ZHEmptyView *emptyView;


/**
 隐藏视图
 */
-(void)hideEmptyView;


/**
 显示视图
 */
-(void)showEmptyView;

@end

NS_ASSUME_NONNULL_END
