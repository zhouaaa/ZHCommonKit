//
//  NSDictionary+ZHAdd.m
//  ZHToolsDemo
//
//  Created by Mac on 2018/11/9.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import "NSDictionary+ZHAdd.h"
#import "NSData+ZHAdd.h"


@implementation NSDictionary (ZHAdd)

/**
 plist 数据转字典
 
 @param plist  plist数据
 @return 字典
 */
+ (NSDictionary *)zh_dictionaryWithPlistData:(NSData *)plist
{
    if (!plist) {
        return nil;
    }
    NSDictionary *dictionary = [NSPropertyListSerialization propertyListWithData:plist options:NSPropertyListImmutable format:NULL error:NULL];
    if ([dictionary isKindOfClass:[NSDictionary class]]){
        return dictionary;
    }
    return nil;
}



/**
 plist 字符串转字典
 
 @param plist  字符串
 @return  字典
 */
+ (NSDictionary *)zh_dictionaryWithPlistString:(NSString *)plist
{
    if (!plist) {
        return nil;
    }
    NSData *data = [plist dataUsingEncoding:NSUTF8StringEncoding];
    return [self zh_dictionaryWithPlistData:data];
}


/**
 将字典转为 plist 数据
 
 @return 数据
 */
- (NSData *)zh_exchangePlistData
{
    return [NSPropertyListSerialization dataWithPropertyList:self format:NSPropertyListBinaryFormat_v1_0 options:kNilOptions error:NULL];
}



/**
 字典转为string
 
 @return 字符串
 */
- (NSString *)zh_exchangePlistString
{
    NSData *xmlData = [NSPropertyListSerialization dataWithPropertyList:self format:NSPropertyListXMLFormat_v1_0 options:kNilOptions error:NULL];
    if (xmlData) return xmlData.utf8String;
    return nil;
}


//以下摘自 YYKit

/**
 将 key 排序
 
 @return  排序完毕的数组
 */
- (NSArray *)allKeysSorted
{
    return [[self allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}


/**
 将 value 通过 key 排序
 
 @return  value数组
 */
- (NSArray *)allValuesSortedByKeys
{
    NSArray *sortedKeys = [self allKeysSorted];
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (id key in sortedKeys) {
        [arr addObject:self[key]];
    }
    return [arr copy];
}

/**
 通过 key 判断 value 是否存在
 
 @param key  key
 @return YES 存在;NO 反之
 */
- (BOOL)containsObjectForKey:(id)key
{
    if (!key) return NO;
    return self[key] != nil;
}



/**
 通过 key 数组,重新将 value 生成字典
 
 @param keys  数组
 @return 新字典
 */
- (NSDictionary *)entriesForKeys:(NSArray *)keys
{
    NSMutableDictionary *dic = [NSMutableDictionary new];
    for (id key in keys) {
        id value = self[key];
        if (value) dic[key] = value;
    }
    return [dic copy];
}

/**
 将字典 json 编码
 
 @return  json 数据
 */
- (NSString *)jsonStringEncoded
{
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        if (!error) return json;
    }
    return nil;
}


#pragma mark - 字典转模型KVC实现(自动生成模型属性代码)

/**
 自动生成模型属性代码
 */
- (void)zh_createPropertyCode
{
    // 拼接属性字符串代码
    NSMutableString *codes = [NSMutableString string];
    // 遍历字典
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull value, BOOL * _Nonnull stop) {
        
        NSString *code;
        if ([value isKindOfClass:[NSString class]]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSString *%@;",key];
            
        } else if ([value isKindOfClass:NSClassFromString(@"__NSCFBoolean")]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, assign) BOOL %@;",key];
            
        } else if ([value isKindOfClass:[NSNumber class]]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, assign) NSInteger %@;",key];
            
        } else if ([value isKindOfClass:[NSArray class]]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSArray * %@;",key];
        } else if ([value isKindOfClass:[NSDictionary class]]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSDictionary * %@;",key];
        }
        // 每生成属性字符串，就自动换行。
        [codes appendFormat:@"\n%@\n",code];
    }];
    // 把拼接好的字符串打印出来
    NSLog(@"自动生成模型属性代码=====\n %@",codes);
}

@end
