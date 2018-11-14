//
//  NSArray+ZHAdd.m
//  ZHToolsDemo
//
//  Created by Mac on 2018/11/9.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import "NSArray+ZHAdd.h"

@implementation NSArray (ZHAdd)

#pragma mark - 方法扩展

/**
 根据下标获取数据对象,越界返回为 nil
 
 @param index 索引下标
 @return 对象
 */
- (id)zh_safeObjectAtIndex:(NSInteger)index
{
    if (index > self.count) {
        return nil;
    }
    return [self objectAtIndex:index];
}

/**
 从数组中随机获取对象
 
 @return 对象
 */
- (id)zh_randomObject
{
    if (self.count) {
        return self[arc4random_uniform((u_int32_t)self.count)];
    }
    return nil;
}


/**
 根据对象获取下标,如果对象为 nil 则返回NotFound
 
 @param object  对象
 @return 下标
 */
- (NSUInteger)zh_safeIndexOfObject:(id)object
{
    if (object == nil) {
        
        return NSNotFound;
    }
    return [self indexOfObject:object];
}

/**
 将array 数据转为 json
 
 @return json编码
 */
- (NSString *)zh_jsonStringEncoded
{
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        if (!error) return json;
    }
    return nil;
}

/**
 根据给的 plist 文件名字返回数组
 
 @param name 文件名
 @return 数据数组
 */
+ (NSArray *)zh_getArrayFromPlistName:(NSString *)name
{
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
    if (path) {
        return [NSArray arrayWithContentsOfFile:path];
    }
    return [NSArray new];
}



@end
