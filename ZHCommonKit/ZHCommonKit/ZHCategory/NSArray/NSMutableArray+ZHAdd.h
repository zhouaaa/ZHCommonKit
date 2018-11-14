//
//  NSMutableArray+ZHAdd.h
//  ZHToolsDemo
//
//  Created by Mac on 2018/11/9.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (ZHAdd)

#pragma mark - 方法扩展

/**
 向数组里安全加入一个对象
 
 @param object  对象
 */
- (void)zh_safeAddObject:(id)object;

/**
 向数组安全插入对象
 
 @param object 对象
 @param index 插入下标
 */
- (void)zh_safeInserObject:(id)object
                    index:(NSInteger)index;

/**
 根据下标安全移除对象
 
 @param index 下标
 */
- (void)zh_safeRemoveObjectAtIndex:(NSInteger)index;

/**
 根据 range 安全移除对象
 
 @param range  range 范围
 */
- (void)zh_safeRemoveObjectAtRange:(NSRange)range;

/**
 移除第一个元素
 */
- (void)zh_safeRemoveFirstObject;

/**
 移除最后一个元素
 */
- (void)zh_safeRemoveLastObject;

/**
 向数组里安全加入一个 array 对象
 
 @param array  数组
 */
- (void)zh_safeAddArray:(NSArray *)array;

/**
 将对象插入到数组的首个元素位置
 
 @param object 对象
 */
- (void)zh_prependObject:(id)object;

/**
 将数组元素加入到当前数组首个元素位置
 
 @param array  数组
 */
- (void)zh_prependObjectWithArray:(NSArray *)array;

- (void)zh_insterObjectWithArray:(NSArray *)array
                          index:(NSInteger) index;

/**
 将数组元素前后颠倒
 */
- (void)reverse;


@end

NS_ASSUME_NONNULL_END
