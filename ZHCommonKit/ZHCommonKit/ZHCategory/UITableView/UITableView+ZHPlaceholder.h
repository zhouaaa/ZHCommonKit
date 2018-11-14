//
//  UITableView+ZHAdd.h
//  ZHToolsDemo
//
//  Created by Mac on 2018/11/9.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//空视图代理
@protocol MTableViewDelegate <NSObject>
@optional
//完全自定义占位图
- (UIView *)zh_noDataView;
//使用默认占位图, 提供一张图片,可不提供, 默认不显示
- (UIImage *)zh_noDataViewImage;
//使用默认占位图, 提供显示文字,可不提供, 默认为暂无数据
- (NSString *)zh_noDataViewMessage;
//使用默认占位图, 提供显示文字颜色, 可不提供, 默认为灰色
- (UIColor *)zh_noDataViewMessageColor;
//占位图CenterY的偏移量,正数为向下偏移,负数为向上偏移
- (NSNumber *)zh_noDataViewCenterYOffset;
@end

@interface UITableView (ZHPlaceholder)

@end

NS_ASSUME_NONNULL_END
