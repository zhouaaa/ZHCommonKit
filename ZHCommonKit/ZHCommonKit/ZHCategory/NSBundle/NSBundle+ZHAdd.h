//
//  NSBundle+ZHAdd.h
//  ZHToolsDemo
//
//  Created by Mac on 2018/11/9.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (ZHAdd)

/**
 获取 App bundle 名字
 
 @return 名字
 */
+ (NSString *)zh_getAppBundleName;

/**
 获取 APP 名称
 
 @return  app名字
 */
+ (NSString *)zh_getBundleDisplayName;

/**
 获取 APP 版本号(App Store 显示的版本号->Version)
 
 @return  版本号
 */
+ (NSString *)zh_getBundleShortVersionString;

/**
 获取 APP Build 版本号(Build 号)
 
 @return Build 号
 */
+ (NSString *)zh_getBundleVersion;

/**
 获取 APP Bundle Identifier
 
 @return Bundle Identifier
 */
+ (NSString *)zh_getBundleIdentifier;

@end

NS_ASSUME_NONNULL_END
