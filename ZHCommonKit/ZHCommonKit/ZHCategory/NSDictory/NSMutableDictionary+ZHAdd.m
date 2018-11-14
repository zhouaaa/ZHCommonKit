//
//  NSMutableDictionary+ZHAdd.m
//  ZHToolsDemo
//
//  Created by Mac on 2018/11/9.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import "NSMutableDictionary+ZHAdd.h"

@implementation NSMutableDictionary (ZHAdd)

- (void)zh_setSafeObject:(id)object
                 forKey:(id)key {
    
    if ([key isKindOfClass:[NSNull class]]) {
        
        return;
    }
    
    if ([object isKindOfClass:[NSNull class]]) {
        
        [self setValue:@""
                forKey:key];
        
    } else {
        [self setValue:object
                forKey:key];
    }
}

- (id)zh_safeObjectForKey:(id)key {
    
    if (key != nil) {
        
        return [self objectForKey:key];
        
    } else {
        
        return nil;
    }
}


- (id)zh_safeKeyForValue:(id)value {
    
    for (id key in self.allKeys) {
        
        if ([value isEqual:[self objectForKey:key]]) {
            
            return key;
        }
    }
    return nil;
}


@end
