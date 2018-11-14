//
//  UIColor+ZHAdd.h
//  ZHToolsDemo
//
//  Created by Mac on 2018/11/9.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (ZHAdd)

#pragma mark - 扩展属性

/** 由颜色生成纯色图片*/
@property (nonatomic,copy,readonly)  UIImage *image;
/** 颜色的 r值 0.0-1.0*/
@property (nonatomic, readonly) CGFloat red;
/** 颜色的 g值 0.0-1.0*/
@property (nonatomic, readonly) CGFloat green;
/** 颜色的 b值 0.0-1.0*/
@property (nonatomic, readonly) CGFloat blue;
/** 颜色的 alpha值 0.0-1.0*/
@property (nonatomic, readonly) CGFloat alpha;


#pragma mark - 方法

/**
 通过颜色创建纯色图片
 
 @return 图片
 */
-(UIImage *)imageWithColor;

/**
 生成随机颜色
 
 @return 颜色
 */
+(UIColor *)randomColor;

/**
 十六进制颜色 eg. 0x3e74e5
 
 @param hexValue 十六进制颜色值
 @return 颜色
 */
+ (UIColor *)zh_colorWithHex:(NSInteger)hexValue;

/**
 十六进制颜色
 
 @param hexValue  十六进制颜色色值
 @param alphaValue 透明度
 @return  颜色
 */
+ (UIColor *)zh_colorWithHex:(NSInteger)hexValue
                      alpha:(CGFloat)alphaValue;

/**
 十六进制字符串转颜色值
 
 @param hexString 十六进制的字符串, 比如: #1874de
 @return UIColor
 */
+ (UIColor *)zh_colorWithHexString:(NSString *)hexString;

/**
 十六进制字符串转颜色值
 
 @param hexString 十六进制的字符串, 比如: #1874de
 @param alphaValue 透明度
 @return UIColor
 */
+ (UIColor *)zh_colorWithHexString:(NSString *)hexString
                            alpha:(CGFloat)alphaValue;


@end

NS_ASSUME_NONNULL_END
