//
//  NetRequst.m
//
//
//  Created by zhangweicheng on 2017/5/3.
//  Copyright © 2017年 . All rights reserved.
//

#import "ZHNetRequest.h"
#import "ZHJRToast.h"

#ifdef DEBUG
#define LLog(...) printf("[%s] %s [第%d行]: %s\n", __TIME__ ,__PRETTY_FUNCTION__ ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String])
#else
#define LLog(...)
#endif


static BOOL _isOpenLog;   // 是否已开启日志打印


@implementation ZHNetRequest

#pragma init NetRequest


/**
 delegate 不带请求参数
 
 @param relativeURLString relativeURLString description
 @param delegate delegate description
 @return return value description
 */
- (instancetype)initWithRelativeURLString:(NSString*)relativeURLString
                                 delegate:(id)delegate
{
    return [self initWithRelativeURLString:relativeURLString delegate:delegate param:nil];
}


/**
 delegate 带请求参数
 
 @param relativeURLString relativeURLString description
 @param delegate delegate description
 @param param param description
 @return return value description
 */
- (instancetype)initWithRelativeURLString:(NSString*)relativeURLString
                                 delegate:(id)delegate
                                    param:(id)param
{
    self = [super init];
    if (self) {
        [self initSetParam];
        self.delegate = delegate;
        self.relativeURLString = relativeURLString;
        self.param = param;
    }
    return self;
}



/**
 block 不带请求参数
 
 @param relativeURLString relativeURLString description
 @param success success description
 @param fail fail description
 @return return value description
 */
- (instancetype)initWithRelativeURLString:(NSString*)relativeURLString
                                  success:(NetRequestSuccess)success
                                     fail:(NetRequestFail)fail
{
    return [self initWithRelativeURLString:relativeURLString success:success fail:fail param:nil];
}


/**
 block 带请求参数
 
 @param relativeURLString relativeURLString description
 @param success success description
 @param fail fail description
 @param param param description
 @return return value description
 */
- (instancetype)initWithRelativeURLString:(NSString*)relativeURLString
                                  success:(NetRequestSuccess)success
                                     fail:(NetRequestFail)fail
                                    param:(id)param
{
    self = [super init];
    if (self) {
        [self initSetParam];
        self.relativeURLString = relativeURLString;
        self.success = success;
        self.fail = fail;
        self.param = param;
    }
    return self;
}

#pragma mark load data


/**
 GET 加载数据
 */
-(void)loadData
{
    self.currentPage = 1;
    [self loadDataWithPage:self.currentPage];
}


/**
 GET 加载数据

 @param page    带页数
 */
-(void)loadDataWithPage:(NSInteger)page
{
    //网络检查
    [ZHNetClient checkingNetworkResult:^(ZHNetClientNetworkStatus status) {
        //无网状态
        if (status == ZHNetClientStatusNotReachable) {
            [ZHJRToast showWithText:@"请先检查网络"];
            return ;
        }
    }];
    
    //设置页数
    self.currentPage = page;
    //请求前的准备
    [self setWillNetRequstWithInUseCashe:true];

    //请求路径
    NSString *tempURLString = [self returnRelativeURLStringWithPage:page];
    
    [[ZHNetClient sharedManager] GET:tempURLString
                                  parameters:self.param
                                    progress:nil
                                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                         //是否使用错误 View
                                        if (self.isUseError) {[self removeErrorView];}
                                         //网加载成功后的传旨
                                        [self setNetRequstFinishedWithData:responseObject];
                                         //是否使用缓存
                                        if (self.isUseCashe) {[[ZHNetRequestCashData shareManager] saveData:responseObject page:self.currentPage urlString:tempURLString];}
                                     }
                                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
             {
                 //传入错误信息
            [self setNetRequstFailedWithError:error];
            if (self.isUseError) {[self addErrorView];}
        }];
}



/**
 GET 重新加载数据 刷新
 */
-(void)reloadData{
    [self loadDataWithPage:1];
}

/**
 GET 加载前一页数据
 */
-(void)loadPrePage{//加载前一页数据
    self.currentPage -= 1;
    if (self.currentPage <= 0) {
        self.currentPage = 1;
    }
    [self loadDataWithPage:self.currentPage];
}


/**
 GET 加载下一页数据
 */
-(void)loadNextPage
{
    self.currentPage += 1;
    [self loadDataWithPage:self.currentPage];
}



#pragma post data


/**
 发起 POST 请求
 */
-(void)postData{
    self.currentPage = 1;
    [self postDataWithPage:self.currentPage];
}



/**
 POST 重新提交数据
 */
-(void)reloadPostData
{
    self.currentPage = 1;
    [self postDataWithPage:self.currentPage];
}


/**
 POST 加载下一页数据
 */
-(void)postNextPage
{
    self.currentPage += 1;
    [self postDataWithPage:self.currentPage];
}



/**
 POST 加载前一页数据
 */
-(void)postPrePage
{
    self.currentPage -= 1;
    if (self.currentPage <= 0) {
        self.currentPage = 1;
    }
    [self postDataWithPage:self.currentPage];
}


/**
 POST 请求

 @param page page description
 */
-(void)postDataWithPage:(NSInteger)page
{
    //网络检查
    [ZHNetClient checkingNetworkResult:^(ZHNetClientNetworkStatus status) {
        //无网状态
        if (status == ZHNetClientStatusNotReachable) {
            [ZHJRToast showWithText:@"请先检查网络"];
            return ;
        }
    }];
    
    //设置页数
    self.currentPage = page;
    //请求前的准备
    [self setWillNetRequstWithInUseCashe:true];
    
    //请求路径
    NSString *tempURLString = [self returnRelativeURLStringWithPage:page];
    
    //断言
    NSAssert(tempURLString != nil, @"url不能为空");
    
    [[ZHNetClient sharedManager] POST:tempURLString parameters:self.param progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (self.isUseError) { //移除错误提示
                    [self removeErrorView];
                }
                //缓存
                if (self.isUseCashe) {
                    [[ZHNetRequestCashData shareManager] saveData:responseObject page:self.currentPage urlString:tempURLString];
                }
                
                [self setNetRequstFinishedWithData:responseObject];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self setNetRequstFailedWithError:error];
                if (self.isUseError) { //加错误提示
                    [self addErrorView];
                }
            }];
}

-(void)initSetParam{
    _currentPage = 1;
}

#pragma mark 设置头部参数
-(void)setHeadParam{
    [self setToken];
    [self setDevice];
    [self setISOpenLog];
}

#pragma mark 设置token
-(void)setToken{
    ZHNetClient *nc = [ZHNetClient sharedManager];
    NSString * token = [[NSUserDefaults standardUserDefaults] objectForKey:nc.tokenHeadKeywords];
    if (token != nil) {
        ZHNetClient * client = [ZHNetClient sharedManager];
        AFHTTPRequestSerializer *tempRequestSerializer = client.requestSerializer;
        [tempRequestSerializer setValue:token forHTTPHeaderField:client.tokenHeadKeywords];
    }
}

#pragma mark 设置设备参数
-(void)setDevice{
    NSString *deviceString = @"IOS";
    if (UIUserInterfaceIdiomPad == [UIDevice currentDevice].userInterfaceIdiom) {
        deviceString = @"iPad";
    }
    else if (UIUserInterfaceIdiomPhone == [UIDevice currentDevice].userInterfaceIdiom){
        deviceString = @"iPhone";
    }
    ZHNetClient * client = [ZHNetClient sharedManager];
    AFHTTPRequestSerializer *tempRequestSerializer = client.requestSerializer;
    [tempRequestSerializer setValue:deviceString forHTTPHeaderField:client.deiviceClientKeywords];
}


#pragma mark 设置开启Log
-(void)setISOpenLog
{
    _isOpenLog = [ZHNetClient sharedManager].isOpenLog;
}

#pragma del data 删除数据
-(void)delData;
{
    [self setWillNetRequstWithInUseCashe:false];
    
    NSString *tempURLString = [self returnRelativeURLStringWithPage:0];
    [[ZHNetClient sharedManager] DELETE:tempURLString
                           parameters:self.param
                              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                  [self setNetRequstFinishedWithData:responseObject];
                              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                  [self setNetRequstFailedWithError:error];
                              }];
}

#pragma mark patch data 修改数据
-(void)patchData;{
    [self setWillNetRequstWithInUseCashe:false];
    
    NSString *tempURLString = [self returnRelativeURLStringWithPage:0];
    [[ZHNetClient sharedManager] PATCH:tempURLString
                           parameters:self.param
                              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                  [self setNetRequstFinishedWithData:responseObject];
                              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                  [self setNetRequstFailedWithError:error];
                              }];
}

#pragma mark post image 上传图片
-(void)postImageKey:(NSString*)imagekey //@"users[avater]"
           fileName:(NSString*)fileName // @"1111.jpg"
           mimeType:(NSString*)mimeType //@"image/jpg"];
             image :(UIImage*)image;{
    [self setWillNetRequstWithInUseCashe:false];

    NSString *tempURLString = [self returnRelativeURLStringWithPage:0];
    [[ZHNetClient sharedManager] POST:tempURLString
                         parameters:self.param
          constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
              NSData *data  = UIImageJPEGRepresentation(image, 0.7);
              [formData appendPartWithFileData:data
                                          name:imagekey
                                      fileName:fileName
                                      mimeType:mimeType];
          } progress:^(NSProgress * _Nonnull uploadProgress) {
              LLog(@"上传进度--%.1f",1.0 * uploadProgress.completedUnitCount/uploadProgress.totalUnitCount);
              
          } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              [self setNetRequstFinishedWithData:responseObject];
          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              [self setNetRequstFailedWithError:error];
          }];
}




/**
 返回相对路径 加入Page

 @param page page description
 @return return value description
 */
-(NSString*)returnRelativeURLStringWithPage:(NSInteger)page{
    if (page == 0) {
        return [_relativeURLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }
    
    NSString *tempURLString = @"";
    ZHNetClient *nc = [ZHNetClient sharedManager];
    if ([_relativeURLString containsString:@"?"]) {
        tempURLString = [NSString stringWithFormat:@"%@&%@=%ld&%@=%ld",_relativeURLString,
                         nc.pageKeywords,page,nc.pageSizeKeywords,nc.pageSize];
    }
    else{
        tempURLString = [NSString stringWithFormat:@"%@?%@=%ld&%@=%ld",_relativeURLString,
                         nc.pageKeywords,page,nc.pageSizeKeywords,nc.pageSize];
    }
    tempURLString = [tempURLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    return tempURLString;
}

#pragma mark 开始请求设置
-(void)setWillNetRequstWithInUseCashe:(BOOL)inUseCashe //inUseCashe 里面是否使用缓存 get post 为ture de patch false
{
    //设置请求头
    [self setHeadParam];
    
    //开始 Delegate 加载数据
    if([_delegate respondsToSelector:@selector(willNetRequest:casheData:)]){
        id data = nil;
        if (self.isUseCashe && inUseCashe) {
            data = [[ZHNetRequestCashData shareManager] getDataByUrlString:self.relativeURLString];
        }
        [_delegate willNetRequest:self casheData:data];
    }
    
    //Block  从缓存中成功取出数据
    if (self.success != nil && self.isUseCashe  && inUseCashe) {
        id data = [[ZHNetRequestCashData shareManager] getDataByUrlString:self.relativeURLString];
        self.success(data);
    }
    
}


/**
 请求成功 的方法

 @param responseObject responseObject description
 */
-(void)setNetRequstFinishedWithData:(id)responseObject
{
    
    if ([self.delegate respondsToSelector:@selector(netRequestDidFinished:responseData:)]) {
        [self.delegate netRequestDidFinished:self responseData:responseObject];
    }
    
    if (self.success != nil) {
        self.success(responseObject);
    }
    
    //是否开启日志打印
    if (_isOpenLog) {
        LLog(@"responseObject = %@",responseObject);
    }
}



/**
请求失败 的方法

 @param error error description
 */
-(void)setNetRequstFailedWithError:(NSError*)error
{
    
    if ([self.delegate respondsToSelector:@selector(netRequestDidFailed:error:)]) {
        [self.delegate netRequestDidFailed:self error:error];
    }
    
    if (self.fail != nil) {
        self.fail(error);
    }
    
    //是否开启日志打印
    if (_isOpenLog) {
        LLog(@"error = %@",error);
    }
}


/**
 给页面添加错误提示View
 */
-(void)addErrorView{
    if ([self.delegate isKindOfClass:[UIViewController class]]) {
        UIViewController *vc = (UIViewController*)self.delegate;
        [vc addNetRequestErrorView];
    }
}


/**
  移除错误页面
 */
-(void)removeErrorView{
    if ([self.delegate isKindOfClass:[UIViewController class]]) {
        UIViewController *vc = (UIViewController*)self.delegate;
        [vc removeNetRequestErrorView];
    }
}

@end



#pragma mark - NSDictionary,NSArray的分类
/*
*****************************************************************
 *新建NSDictionary与NSArray的分类, 控制台打印json数据中的中文
*****************************************************************
 */
#ifdef DEBUG
@implementation NSArray (PP)

- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [strM appendFormat:@"\t%@,\n", obj];
    }];
    [strM appendString:@")"];
    
    return strM;
}

@end

@implementation NSDictionary (PP)

- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *strM = [NSMutableString stringWithString:@"{\n"];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [strM appendFormat:@"\t%@ = %@;\n", key, obj];
    }];
    
    [strM appendString:@"}\n"];
    
    return strM;
}
@end
#endif
