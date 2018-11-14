//
//  NSURL+ZHAdd.m
//  ZHToolsDemo
//
//  Created by Mac on 2018/11/9.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import "NSURL+ZHAdd.h"
#import "NSString+ZHAdd.h"


@implementation NSURL (ZHAdd)

/**
 通过传入的URL地址打开外部浏览器
 
 @param urlString URL地址
 */
+ (void)zh_openBrowserWithURL:(NSString *)urlString;
{
    
    [[UIApplication sharedApplication] openURL:urlString.url];
}


@end
