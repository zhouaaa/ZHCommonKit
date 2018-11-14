//
//  NSMutableArray+ZHAdd.m
//  ZHToolsDemo
//
//  Created by Mac on 2018/11/9.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import "NSMutableArray+ZHAdd.h"

@implementation NSMutableArray (ZHAdd)


#pragma mark - 方法扩展

/**
 向数组里安全加入一个对象
 
 @param object  对象
 */
- (void)zh_safeAddObject:(id)object
{
    if (object) {
        [self addObject:object];
    }
}

/**
 向数组安全插入对象
 
 @param object 对象
 @param index 插入下标
 */
- (void)zh_safeInserObject:(id)object
                     index:(NSInteger)index
{
    if (object) {
        if (index > self.count) {
            [self insertObject:object atIndex:self.count];
        }else{
            [self insertObject:object atIndex:index];
        }
    }
}

/**
 根据下标安全移除对象
 
 @param index 下标
 */
- (void)zh_safeRemoveObjectAtIndex:(NSInteger)index
{
    if (index < self.count) {
        [self removeObjectAtIndex:index];
    }
}

/**
 根据 range 安全移除对象
 
 @param range  range 范围
 */
- (void)zh_safeRemoveObjectAtRange:(NSRange)range
{
    NSUInteger location = range.location;
    NSUInteger length   = range.length;
    if (location + length > self.count) {
        
    } else {
        [self removeObjectsInRange:range];
    }
}



/**
 移除第一个元素
 */
- (void)zh_safeRemoveFirstObject
{
    if (self.count) {
        [self removeObjectAtIndex:0];
    }
}


/**
 移除最后一个元素
 */
- (void)zh_safeRemoveLastObject
{
    if (self.count) {
        [self removeObjectAtIndex:self.count - 1];
    }
}


/**
 向数组里安全加入一个 array 对象
 
 @param array  数组
 */
- (void)zh_safeAddArray:(NSArray *)array
{
    if (array) {
        [self addObjectsFromArray:array];
    }
}



/**
 将对象插入到数组的首个元素位置
 
 @param object 对象
 */
- (void)zh_prependObject:(id)object{
    [self zh_safeInserObject:object index:0];
}



/**
 将数组元素加入到当前数组首个元素位置
 
 @param array  数组
 */
- (void)zh_prependObjectWithArray:(NSArray *)array
{
    [self zh_insterObjectWithArray:array index:0];
}



- (void)zh_insterObjectWithArray:(NSArray *)array
                           index:(NSInteger) index
{
    if (array) {
        NSInteger indexs = index;
        for (id object in array) {
            [self zh_safeInserObject:object index:indexs++];
        }
    }
}


/**
 将数组元素前后颠倒
 */
- (void)reverse
{
    NSUInteger count = self.count;
    int mid = floor(count / 2.0);
    for (NSUInteger i = 0; i < mid; i++) {
        [self exchangeObjectAtIndex:i withObjectAtIndex:(count - (i + 1))];
    }
}


@end
