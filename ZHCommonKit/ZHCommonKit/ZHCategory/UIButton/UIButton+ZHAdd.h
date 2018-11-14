//
//  UIButton+ZHAdd.h
//  ZHToolsDemo
//
//  Created by Mac on 2018/11/9.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ButtonEdgeInsetsStyle) {
    ButtonEdgeInsetsStyleTop, //image在上，label在下
    ButtonEdgeInsetsStyleLeft, //image在左，label在右
    ButtonEdgeInsetsStyleBottom, //image在下，label在上
    ButtonEdgeInsetsStyleRight, //image在右，label在左
    ButtonEdgeInsetsStyleMind//image在中间, label 在中间
};

typedef void(^MClickBlock)(void);

@interface UIButton (ZHAdd)

/** 设置 font*/
@property (nonatomic,copy) UIFont *font;
/** 设置 normal 标题*/
@property (nonatomic,copy)  NSString *normalTitle;
/** 设置 selected 标题*/
@property (nonatomic,copy)  NSString *selectTitle;
/** 设置 normal 标题颜色*/
@property (nonatomic,copy)  UIColor *normalColor;
/**设置 selected 标题颜色*/
@property (nonatomic,copy) UIColor *selectColor;
/** 设置 normal 图片*/
@property (nonatomic,copy)  UIImage *normalImage;
/** 设置 select 图片*/
@property (nonatomic,copy)  UIImage *selectImage;
/** 设置 normal 背景图片*/
@property (nonatomic,copy)  UIImage *normalBackgroundImage;
/** 设置 select 背景图片*/
@property (nonatomic,copy)  UIImage *selectBackgroundImage;
/** 设置圆角->clipsToBounds*/
@property (nonatomic, assign)  CGFloat addRadiu;
/** 重复点击加间隔**/
@property (nonatomic, assign) NSTimeInterval custom_acceptEventInterval;
/** 设置 block 点击事件*/
@property (nonatomic,copy)  MClickBlock clickBlock;

/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(ButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;


@end

NS_ASSUME_NONNULL_END
