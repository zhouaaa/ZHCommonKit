//
//  NSURL+ZHAdd.h
//  ZHToolsDemo
//
//  Created by Mac on 2018/11/9.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import <Foundation/Foundation.h>



NS_ASSUME_NONNULL_BEGIN

@interface NSURL (ZHAdd)

/**
 通过传入的URL地址打开外部浏览器
 
 @param urlString URL地址
 */
+ (void)zh_openBrowserWithURL:(NSString *)urlString;


@end

NS_ASSUME_NONNULL_END
