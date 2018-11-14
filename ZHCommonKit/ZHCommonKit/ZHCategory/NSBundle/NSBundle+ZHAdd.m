//
//  NSBundle+ZHAdd.m
//  ZHToolsDemo
//
//  Created by Mac on 2018/11/9.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import "NSBundle+ZHAdd.h"

@implementation NSBundle (ZHAdd)

/**
 获取 App bundle 名字
 
 @return 名字
 */
+ (NSString *)zh_getAppBundleName
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
}



/**
 获取 APP 名称
 
 @return  app名字
 */
+ (NSString *)zh_getBundleDisplayName
{
    return [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleDisplayName"];
}



/**
 获取 APP 版本号(App Store 显示的版本号->Version)
 
 @return  版本号
 */
+ (NSString *)zh_getBundleShortVersionString
{
    return [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];
}



/**
 获取 APP Build 版本号(Build 号)
 
 @return Build 号
 */
+ (NSString *)zh_getBundleVersion
{
    return [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleVersion"];
}



/**
 获取 APP Bundle Identifier
 
 @return Bundle Identifier
 */
+ (NSString *)zh_getBundleIdentifier
{
    return [[NSBundle mainBundle] bundleIdentifier];
}


@end
