//
//  NSMutableAttributedString+ZHAdd.h
//  ZHCommonKit
//
//  Created by Mac on 2018/11/16.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableAttributedString (ZHAdd)

/****  EG:
 NSMutableAttributedString * testAS = [NSMutableAttributedString makeAttributeString:@"直接创建" Attribute:^(NSMutableDictionary *attributes) {
 attributes.Font(24).Color([UIColor yellowColor]);
 }];
 [testAS makeAttributeStringAdd:@"拼接新的文字" Attribute:^(NSMutableDictionary *attributes) {
 attributes.Font(12).Color([UIColor redColor]);
 }];
 testLabel.attributedText = testAS;
 ***/


#pragma mark - 快速创建属性字符串
/*
 * @param string  字符串
 * @param block   返回attributes
 */
-(NSMutableAttributedString *)zh_makeAttributeString:(NSString *)string Attribute:(void(^)(NSMutableDictionary * attributes))block;



#pragma mark - 拼接属性字符串
/*
 * @param string  字符串
 * @param block   返回attributes
 */
-(NSMutableAttributedString *)zh_makeAttributeStringAdd:(NSString *)string Attribute:(void(^)(NSMutableDictionary * attributes))block;


@end

NS_ASSUME_NONNULL_END
