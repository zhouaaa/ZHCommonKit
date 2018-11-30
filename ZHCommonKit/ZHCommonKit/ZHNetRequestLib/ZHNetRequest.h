//
//  NetRequst.h
//
//
//  Created by zhangweicheng on 2017/5/3.
//  Copyright © 2017年 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHNetRequestCashData.h"
#import "ZHNetClient.h"
#import "UIViewController+NetRequestLib.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>

@class ZHNetRequest;

@protocol NetRequestDelegate <NSObject>
@optional
-(void)willNetRequest:(ZHNetRequest *) netRequest casheData:(id)data;
-(void)netRequestDidFinished:(ZHNetRequest *) netRequest responseData:(id)data;
-(void)netRequestDidFailed:(ZHNetRequest * )netRequest error:(NSError*)error;
@end

typedef void (^NetRequestSuccess)(id data);
typedef void (^NetRequestFail)(NSError * error);


@interface ZHNetRequest : NSObject

@property(nonatomic,weak) id<NetRequestDelegate> delegate;
@property(nonatomic,strong) NSString * relativeURLString; //相对地址
@property(nonatomic,assign)NSInteger currentPage; //当前页面
@property(nonatomic,assign)NSInteger tag; //请求标识
@property(nonatomic,strong)id param; //传的参数
@property(nonatomic,copy) NetRequestSuccess success;
@property(nonatomic,copy) NetRequestFail fail;

@property(nonatomic)BOOL isUseCashe; //是否使用缓存 默认不使用
@property(nonatomic)BOOL isUseError; //是否使用异常view 默认不使用



/**
  delegate 不带请求参数

 @param relativeURLString relativeURLString description
 @param delegate delegate description
 @return return value description
 */
- (instancetype)initWithRelativeURLString:(nullable NSString*)relativeURLString
                                 delegate:(id)delegate;



/**
 delegate 带请求参数

 @param relativeURLString relativeURLString description
 @param delegate delegate description
 @param param param description
 @return return value description
 */
- (instancetype)initWithRelativeURLString:(nullable NSString*)relativeURLString
                                 delegate:(id)delegate
                                    param:(id)param;


/**
 block 不带请求参数

 @param relativeURLString relativeURLString description
 @param success success description
 @param fail fail description
 @return return value description
 */
- (instancetype)initWithRelativeURLString:(nullable NSString*)relativeURLString
                                  success:(NetRequestSuccess)success
                                     fail:(NetRequestFail)fail;


/**
 block 带请求参数

 @param relativeURLString relativeURLString description
 @param success success description
 @param fail fail description
 @param param param description
 @return return value description
 */
- (instancetype)initWithRelativeURLString:(nullable NSString*)relativeURLString
                                  success:(NetRequestSuccess)success
                                     fail:(NetRequestFail)fail
                                    param:(id)param;

#pragma load data


/**
  GET加载数据
 */
-(void)loadData;

/**
 GET重新加载数据
 */
-(void)reloadData;


/**
 GET 加载下一页数据
 */
-(void)loadNextPage;


/**
 GET 加载前一页数据
 */
-(void)loadPrePage;

/**
 GET 获取page页的数据

 @param page page description
 */
-(void)loadDataWithPage:(NSInteger)page;


#pragma post data


/**
 发送 POST 请求
 */
-(void)postData;


/**
 重新发送 POST 请求
 */
-(void)reloadPostData;


/**
 发送加载下一页数据 POST 请求
 */
-(void)postNextPage; //加载下一页数据

/**
 发送加载前一页数据 POST 请求
 */
-(void)postPrePage; //加载前一页数据


/**
 发送获取page页的数据 POST 请求

 @param page page description
 */
-(void)postDataWithPage:(NSInteger)page; //获取page页的数据


#pragma del data 删除数据

-(void)delData;

#pragma mark patch data 修改数据

-(void)patchData;

#pragma mark post image 上传图片

/**
 上传图片

 @param imagekey  @"users[avater]" 关键
 @param fileName  @"1111.jpg"
 @param mimeType  @"image/jpg"
 */
-(void)postImageKey:(NSString*)imagekey //@"users[avater]"
           fileName:(NSString*)fileName // @"1111.jpg"
           mimeType:(NSString*)mimeType //@"image/jpg"];
             image :(UIImage*)image;


@end
