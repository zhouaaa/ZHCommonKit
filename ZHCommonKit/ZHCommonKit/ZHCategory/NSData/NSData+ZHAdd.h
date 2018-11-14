//
//  NSData+ZHAdd.h
//  ZHToolsDemo
//
//  Created by Mac on 2018/11/9.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface NSData (ZHAdd)

/**转 utf8格式*/
@property (nonatomic, readonly) NSString *utf8String;

/**
 将 data 数据 json 格式化
 
 @return json 数据
 */
- (id)zh_jsonValueDecoded;


#pragma mark - 图片转 data

/**
 将图片转成 data 数据,可压缩
 
 @param image 图片
 @param ratio 压缩比例
 @return  data 数据
 */
+ (NSData *)zh_changeDataFromImage:(UIImage *)image
                 compressionRatio:(CGFloat)ratio;


@end

NS_ASSUME_NONNULL_END
