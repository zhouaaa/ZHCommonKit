//
//  NSMutableAttributedString+ZHAdd.m
//  ZHCommonKit
//
//  Created by Mac on 2018/11/16.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import "NSMutableAttributedString+ZHAdd.h"

@implementation NSMutableAttributedString (ZHAdd)


/*
 * @param string  字符串
 * @param block   返回attributes
 */
-(NSMutableAttributedString *)zh_makeAttributeString:(NSString *)string Attribute:(void(^)(NSMutableDictionary * attributes))block
{
    NSMutableDictionary * attributes = [NSMutableDictionary dictionary];
    block(attributes);
    NSMutableAttributedString * as = [[NSMutableAttributedString alloc] initWithString:string attributes:attributes];
    
    return as;
}



#pragma mark - 拼接属性字符串
/*
 * @param string  字符串
 * @param block   返回attributes
 */
-(NSMutableAttributedString *)zh_makeAttributeStringAdd:(NSString *)string Attribute:(void(^)(NSMutableDictionary * attributes))block
{
    NSMutableDictionary * attributes = [NSMutableDictionary dictionary];
    block(attributes);
    NSMutableAttributedString * as = [[NSMutableAttributedString alloc] initWithString:string attributes:attributes];
   
    [self appendAttributedString:as];
    
    return self;
}


@end
