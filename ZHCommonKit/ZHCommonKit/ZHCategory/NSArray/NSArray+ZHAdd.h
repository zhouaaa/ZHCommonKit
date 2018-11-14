//
//  NSArray+ZHAdd.h
//  ZHToolsDemo
//
//  Created by Mac on 2018/11/9.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (ZHAdd)

#pragma mark - 方法扩展

/**
 根据下标获取数据对象,越界返回为 nil
 
 @param index 索引下标
 @return 对象
 */
- (id)zh_safeObjectAtIndex:(NSInteger)index;

/**
 从数组中随机获取对象
 
 @return 对象
 */
- (id)zh_randomObject;


/**
 根据对象获取下标,如果对象为 nil 则返回NotFound
 
 @param object  对象
 @return 下标
 */
- (NSUInteger)zh_safeIndexOfObject:(id)object;

/**
 将array 数据转为 json
 
 @return json编码
 */
- (NSString *)zh_jsonStringEncoded;

/**
 根据给的 plist 文件名字返回数组
 
 @param name 文件名
 @return 数据数组
 */
+ (NSArray *)zh_getArrayFromPlistName:(NSString *)name;


@end

NS_ASSUME_NONNULL_END
