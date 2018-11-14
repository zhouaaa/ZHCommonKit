//
//  NetClient.h
//  ZHEmnuKit
//
//  Created by Mac on 2018/11/13.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import "AFHTTPSessionManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHNetClient : AFHTTPSessionManager

+(ZHNetClient *)sharedManager;


+(void)initWithBasicURL:(nullable NSString *)basicURL isOpenLog:(BOOL )isOpenLog; //必须初始化一个


+(void)initWithBasicURL:(nullable NSString *)basicURL
               pageSize:(NSInteger)pageSize
           pageKeywords:(nullable NSString *)pageKeywords
       pageSizeKeywords:(nullable NSString *)pageSizeKeywords
      tokenHeadKeywords:(nullable NSString *)tokenHeadKeywords
  deiviceClientKeywords:(nullable NSString *)deiviceClientKeywords
              isOpenLog:(BOOL )isOpenLog;

@property(nonatomic,assign)NSInteger pageSize; //页面大小 默认为10
@property(nonatomic,copy)NSString *pageKeywords; //页关键词 默认为page
@property(nonatomic,copy)NSString *pageSizeKeywords; //页面大小关键词 默认为pagesize
@property(nonatomic,copy)NSString *tokenHeadKeywords; //token头部关键词 默认为 token
@property(nonatomic,copy)NSString *deiviceClientKeywords; //设备头部关键词 默认为 DeiviceClient

@property (nonatomic) BOOL isOpenLog;//是否开启log

@end

NS_ASSUME_NONNULL_END
