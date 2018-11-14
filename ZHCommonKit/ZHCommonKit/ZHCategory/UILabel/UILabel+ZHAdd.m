//
//  UILabel+ZHAdd.m
//  ZHToolsDemo
//
//  Created by Mac on 2018/11/9.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import "UILabel+ZHAdd.h"

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


