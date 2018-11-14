//
//  UILabel+ZHAdd.h
//  ZHToolsDemo
//
//  Created by Mac on 2018/11/9.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (ZHAdd)

+ (UILabel *)labelWithFrame:(CGRect)frame
                       text:(NSString *)text
                  textColor:(UIColor *)color
              textAlignment:(NSTextAlignment)alignment
                       font:(UIFont *)font;

//设置Label的行间距
- (void)setLineSpaceWithString:(CGFloat)lineSpace;


@end

NS_ASSUME_NONNULL_END
