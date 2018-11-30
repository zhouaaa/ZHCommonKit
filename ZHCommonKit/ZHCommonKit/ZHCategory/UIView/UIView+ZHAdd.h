//
//  UIView+ZHAdd.h
//  ZHToolsDemo
//
//  Created by Mac on 2018/11/9.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ZHAdd)
#pragma mark - 属性扩展

/** frame.origin.x**/
@property (nonatomic,assign) CGFloat left;
/** frame.origin.y**/
@property (nonatomic,assign) CGFloat top;
/** frame.origin.x + frame.size.width**/
@property (nonatomic,assign) CGFloat right;
/** frame.origin.y + frame.size.height**/
@property (nonatomic,assign) CGFloat bottom;
/** frame.size.width**/
@property (nonatomic,assign) CGFloat width;
/** frame.size.height**/
@property (nonatomic,assign) CGFloat height;
/** center.x**/
@property (nonatomic,assign) CGFloat centerX;
/** center.y**/
@property (nonatomic,assign) CGFloat centerY;
/** frame.origin**/
@property (nonatomic,assign) CGPoint origin;
/** frame.size**/
@property (nonatomic,assign) CGSize  size;

/**获取当前视图所属控制器*/
@property (nonatomic, nullable,readonly)  UIViewController *   viewControl;

#pragma mark - 截图


/**
 创建当前视图截图
 
 @return 截图图片
 */
- (nullable UIImage *)zh_snapshotImage;

/**
 视图截图生成 PDF 文件
 
 @return  PDF文件
 */
- (nullable NSData *)zh_snapshotPDF;

#pragma mark - 视图特效

/**
 为视图设置阴影
 
 @param color  阴影颜色
 @param offset 阴影的 size
 @param radius 圆角
 */
- (void)setLayerShadow:(nullable UIColor *)color
                offset:(CGSize)offset radius:(CGFloat)radius;



/**
  给View添加阴影
 */
- (void) makeInsetShadow;

/**
 给View添加阴影

 @param radius radius description
 @param alpha alpha description
 */
- (void) makeInsetShadowWithRadius:(float)radius Alpha:(float)alpha;

/**
 给View添加阴影

 @param radius radius description
 @param color color description
 @param directions @"top", @"bottom", @"left", @"right"
 */
- (void) makeInsetShadowWithRadius:(float)radius Color:(UIColor *)color Directions:(NSArray *)directions;

/**
 移除当前视图中所有子视图
 */
- (void)zh_removeAllSubview;

#pragma mark - 坐标转化
//以下摘自 YYKit
- (CGPoint)convertPoint:(CGPoint)point
         toViewOrWindow:(nullable UIView *)view;

- (CGPoint)convertPoint:(CGPoint)point
       fromViewOrWindow:(nullable UIView *)view;

- (CGRect)convertRect:(CGRect)rect
       toViewOrWindow:(nullable UIView *)view;

- (CGRect)convertRect:(CGRect)rect
     fromViewOrWindow:(nullable UIView *)view;


@end

NS_ASSUME_NONNULL_END
