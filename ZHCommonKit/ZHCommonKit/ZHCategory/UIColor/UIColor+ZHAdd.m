//
//  UIColor+ZHAdd.m
//  ZHToolsDemo
//
//  Created by Mac on 2018/11/9.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import "UIColor+ZHAdd.h"

@implementation UIColor (ZHAdd)

#pragma mark - 扩展属性

-(UIImage *)image{
    return [self imageWithColor];
}

- (CGFloat)red {
    CGFloat r = 0, g, b, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return r;
}

- (CGFloat)green {
    CGFloat r, g = 0, b, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return g;
}

- (CGFloat)blue {
    CGFloat r, g, b = 0, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return b;
}

- (CGFloat)alpha {
    return CGColorGetAlpha(self.CGColor);
}

#pragma mark - 方法


-(UIImage *)imageWithColor{
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [self CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return theImage;
}

+(UIColor *)randomColor{
    int R = (arc4random() % 256);
    int G = (arc4random() % 256);
    int B = (arc4random() % 256);
    return [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1];
}

#pragma mark - 十六进制转颜色值

+ (UIColor *)m_colorWithHex:(NSInteger)hexValue{
    return [self m_colorWithHex:hexValue alpha:1.0];
}

+ (UIColor *)m_colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue{
    return  [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:alphaValue];
}

#pragma mark - 十六进制字符串转颜色值

+ (UIColor *)m_colorWithHexString:(NSString *)hexString {
    
    return [self m_getColorWithHexString:hexString
                                   alpha:1.0f];
}


+ (UIColor *)m_colorWithHexString:(NSString *)hexString
                            alpha:(CGFloat)alphaValue {
    
    return [self m_getColorWithHexString:hexString
                                   alpha:alphaValue];
}

+ (UIColor *)m_getColorWithHexString:(NSString *)hexString
                               alpha:(CGFloat)alphaValue {
    
    NSString *colorString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([colorString length] < 6) {
        
        return [UIColor blackColor];
    }
    
    if ([colorString hasPrefix:@"#"]) {
        
        colorString = [colorString substringFromIndex:1];
    }
    
    if ([colorString length] != 6) {
        
        return [UIColor blackColor];
    }
    
    NSRange range;
    
    range.location = 0;
    range.length = 2;
    
    NSString *redString = [colorString substringWithRange:range];
    
    range.location = 2;
    
    NSString *greenString = [colorString substringWithRange:range];
    
    range.location = 4;
    
    NSString *blueString = [colorString substringWithRange:range];
    
    unsigned int red, green, blue;
    
    [[NSScanner scannerWithString:redString] scanHexInt:&red];
    [[NSScanner scannerWithString:greenString] scanHexInt:&green];
    [[NSScanner scannerWithString:blueString] scanHexInt:&blue];
    
    return [UIColor colorWithRed:((float) red / 255.0f)
                           green:((float) green / 255.0f)
                            blue:((float) blue / 255.0f)
                           alpha:1.0f];
}

@end
