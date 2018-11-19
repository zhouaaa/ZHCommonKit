//
//  UILabel+ZHAdd.m
//  ZHToolsDemo
//
//  Created by Mac on 2018/11/9.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import "UILabel+ZHAdd.h"
#import <CoreText/CoreText.h>


@implementation UILabel (ZHAdd)


+ (UILabel *)labelWithFrame:(CGRect)frame
                       text:(NSString *)text
                  textColor:(UIColor *)color
              textAlignment:(NSTextAlignment)alignment
                       font:(UIFont *)font
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    if (!color) {
        color = [UIColor blackColor];
    }
    if (!font) {
        font = [UIFont systemFontOfSize:15];
    }
    label.text = text;
    label.textColor = color;
    label.textAlignment = alignment;
    label.font = font;
    return label;
}

#pragma mark - 设置指定label某些文字之间的间距
- (void)zh_labelTextSpacingValue:(NSInteger)spacing Range:(NSRange)range
{
    // 方法一：#import <CoreText/CoreText.h>
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    // 调整间距
    [attributedString addAttribute:(__bridge NSString *)kCTKernAttributeName value:@(spacing) range:range];
    self.attributedText = attributedString;
    
    
    // 方法二：  富文本
    /**
     NSMutableAttributedString *attributeString =  [[NSMutableAttributedString alloc] initWithString:self.text];
     CGSize attributeSize = [attributeString.string sizeWithAttributes:@{NSFontAttributeName:self.font}];
     CGSize adjustedSize = CGSizeMake(ceilf(attributeSize.width), ceilf(attributeSize.height));
     CGSize frame = self.frame.size;
     NSNumber *wordSpace = [NSNumber numberWithInt:((frame.width-adjustedSize.width)/(attributeString.length-1))];
     // 调整指定位置文字间距
     [attributeString addAttribute:NSKernAttributeName value:wordSpace range:range];
     */
}

- (void)setLineSpaceWithString:(CGFloat)lineSpace
{
    NSMutableAttributedString *attributedString =
    [[NSMutableAttributedString alloc] initWithString:self.text];
    NSMutableParagraphStyle *paragraphStyle =  [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    
    //调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName
                             value:paragraphStyle
                             range:NSMakeRange(0, [self.text length])];
    self.attributedText = attributedString;
}


@end


