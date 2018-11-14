//
//  NSMutableDictionary+ZHAdd.h
//  ZHToolsDemo
//
//  Created by Mac on 2018/11/9.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableDictionary (ZHAdd)
/**
 安全的存储一个键值对
 
 @param object 值
 @param key 键
 */
- (void)zh_setSafeObject:(id)object
                 forKey:(id)key;

/**
 安全的根据一个键获取对应的对象
 
 @param key key
 @return id
 */
- (id)zh_safeObjectForKey:(id)key;

/**
 安全的根据value获取对应的key
 
 @param value id object
 @return id
 */
- (id)zh_safeKeyForValue:(id)value;


@end

NS_ASSUME_NONNULL_END
