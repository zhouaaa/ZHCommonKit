//
//  NetClient.m
//  ZHEmnuKit
//
//  Created by Mac on 2018/11/13.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import "ZHNetClient.h"

@implementation ZHNetClient

static ZHNetClient * client = nil;

+(ZHNetClient *)sharedManager
{
    return client;
}

+(void)initWithBasicURL:(nullable NSString*)basicURL isOpenLog:(BOOL)isOpenLog
{
    [ZHNetClient initWithBasicURL:basicURL
                       pageSize:0
                   pageKeywords:nil
               pageSizeKeywords:nil
              tokenHeadKeywords:nil
          deiviceClientKeywords:nil
                      isOpenLog:isOpenLog];
}

+(void)initWithBasicURL:(nullable NSString*)basicURL
               pageSize:(NSInteger)pageSize
           pageKeywords:(nullable NSString* )pageKeywords
       pageSizeKeywords:(nullable NSString* )pageSizeKeywords
      tokenHeadKeywords:(nullable NSString* )tokenHeadKeywords
  deiviceClientKeywords:(nullable NSString*)deiviceClientKeywords
              isOpenLog:(BOOL)isOpenLog
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (basicURL != nil || ![basicURL isEqualToString:@""]) {
            client = [[ZHNetClient alloc] initWithBaseURL:[NSURL URLWithString:basicURL]];
        }
        client.responseSerializer = [AFJSONResponseSerializer serializer];//设置返回数据为json
        client.requestSerializer = [AFHTTPRequestSerializer serializer];// 请求
        client.requestSerializer.stringEncoding = NSUTF8StringEncoding;
        client.requestSerializer.timeoutInterval= 30;
        client.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                           @"text/json",
                           @"text/javascript",
                           @"text/html",
                           @"text/plain",
                           @"image/*",
                           @"application/rss+xml",nil];
        
        client.pageSize = pageSize <= 0? 10:pageSize;
        client.pageKeywords = pageKeywords == nil || [pageKeywords isEqualToString:@""]?@"page":pageKeywords;
        client.pageSizeKeywords = pageSizeKeywords == nil || [pageSizeKeywords isEqualToString:@""]?@"pageSize":pageSizeKeywords;
        client.tokenHeadKeywords = tokenHeadKeywords == nil || [tokenHeadKeywords isEqualToString:@""]?@"token":tokenHeadKeywords;
        client.deiviceClientKeywords = deiviceClientKeywords == nil || [deiviceClientKeywords isEqualToString:@""] ?@"DeiviceClient":deiviceClientKeywords;
        client.isOpenLog = isOpenLog;
    });
}


/**
 监听网络状态的变化
 
 @param networkStatus networkStatus description
 */
+ (void)checkingNetworkResult:(void (^)(ZHNetClientNetworkStatus status))networkStatus
{
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager startMonitoring];
    //添加状态
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusUnknown) {
            //未知状态
            if (networkStatus) networkStatus(ZHNetClientStatusUnknown);
            
        }else if (status == AFNetworkReachabilityStatusNotReachable){
            //无网络
            if (networkStatus) networkStatus(ZHNetClientStatusNotReachable);
            
        }else if (status == AFNetworkReachabilityStatusReachableViaWWAN){
            //移动设备网络
            if (networkStatus) networkStatus(ZHNetClientStatusReachableViaWWAN);
            
        }else if (status == AFNetworkReachabilityStatusReachableViaWiFi){
            //wifi
            if (networkStatus) networkStatus(ZHNetClientStatusReachableViaWiFi);
            
        }
    }];
}


@end
