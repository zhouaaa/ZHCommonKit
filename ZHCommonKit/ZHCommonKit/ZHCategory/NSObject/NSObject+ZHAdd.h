//
//  NSObject+ZHAdd.h
//  ZHToolsDemo
//
//  Created by Mac on 2018/11/9.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>


NS_ASSUME_NONNULL_BEGIN

typedef void(^MComplete)(void);

@interface NSObject (ZHAdd)

#pragma mark - KVO
/**
 自动移除 KVO 监听
 
 @param observer  要监听的对象
 @param keyPath  监听的属性
 */
- (void)zh_addObserver:(NSObject *)observer
           forKeyPath:(NSString *)keyPath;

#pragma mark - runtime 方法

/**
 判断当前类是否可以替换 拦截方法与被拦截方法
 拦截当前类中的SEL方法,替换成自己想要的方法
 
 @param originalSelector  被拦截的方法
 @param swizzledSelector  替换的方法
 */
- (BOOL)zh_addInstanceMethonWithOriginalSelector:(SEL)originalSelector
                               swizzledSelector:(SEL)swizzledSelector;

/**
 拦截原方法,替换原来方法
 想同时执行俩个方法,只需要在执行方法里调用自己
 @param originalSelector 原方法
 @param swizzledSelector 替换方法
 */
- (void)zh_exchangeInstanceWithOriginalSelector:(SEL)originalSelector
                               swizzledSelecor:(SEL)swizzledSelector;

/**
 获取当前类中的方法列表
 
 @return  方法列表集合
 */
- (NSArray <NSString *> *)zh_getClassMethodList;

/**
 获取当前类中的属性列表
 
 @return  属性集合
 */
- (NSArray <NSString *> *)zh_getClassPropertyList;

/**
 获取当前类中的代理方法列表
 
 @return 代理方法集合
 */
- (NSArray <NSString *> *)zh_getClassProtocolList;

/**
 获取当前类中的实例变量方法列表
 
 @return 实例方法集合
 */
- (NSArray <NSString *> *)zh_getClassIVarList;

/**
 判断当前类的属性中是否包含此属性
 
 @param key 属性
 @return  YES 存在; NO 反之
 */
- (BOOL)zh_hasPropertyWithKey:(NSString *)key;

/**
 根据Key判断是否包含该成员变量
 
 @param key NSString
 @return BOOL
 */
- (BOOL)zh_hasIvarWithKey:(NSString *)key;

#pragma mark - GCD 方法

/**
 global异步执行代码
 
 @param complete  完成回调
 */
- (void)zh_globalAsyncWithComplete:(MComplete)complete;

/**
 主线程执行代码
 
 @param complete 完成回调
 */
- (void)zh_getMainAsyncWithComplete:(MComplete)complete;

/**
 延时执行
 
 @param afterSecond 延时执行
 @param complete 完成回调
 */
- (void)zh_afterSecond:(NSTimeInterval)afterSecond
             complete:(MComplete)complete;



@end

NS_ASSUME_NONNULL_END
