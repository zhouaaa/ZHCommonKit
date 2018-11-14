//
//  UITableView+ZHAdd.m
//  ZHToolsDemo
//
//  Created by Mac on 2018/11/9.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import "UITableView+ZHPlaceholder.h"
#import "NSObject+ZHAdd.h"
#import "UIColor+ZHAdd.h"

@interface  UITableView ()


@end

NSString * const MNoDataViewObserveKeyPath = @"frame";

@implementation UITableView (ZHPlaceholder)


+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL reloadData = @selector(reloadData);
        SEL zh_reloadData = @selector(zh_reloadData);
        [self zh_exchangeInstanceWithOriginalSelector:reloadData swizzledSelecor:zh_reloadData];
        
    });
}

#pragma mark - 创建占位图

-(void)zh_reloadData{
    [self zh_reloadData];
    //刷新完成之后检测数据量
    dispatch_async(dispatch_get_main_queue(), ^{
        //tableview默认有一个分区
        NSInteger numberOfSections = [self numberOfSections];
        BOOL havingData = NO;
        for (NSInteger i = 0; i < numberOfSections; i++) {
            NSInteger row = [self numberOfRowsInSection:i];
            if (row > 0) {
                havingData = YES;
                break;
            }
        }
        //在主线程创建 UI
        [self zh_isHavingData:havingData];
    });
}

/**
 创建占位图
 
 @param havingData  是否创建占位图,YES 不需要占位图, NO 需要占位图
 */
- (void)zh_isHavingData:(BOOL)havingData{
    //判断图片响应代理
    BOOL isImg = [self.delegate respondsToSelector:@selector(zh_noDataViewImage)];
    //判断文字响应代理
    BOOL isMsg = [self.delegate respondsToSelector:@selector(zh_noDataViewMessage)];
    //判断自定义视图响应代理
    BOOL isView = [self.delegate respondsToSelector:@selector(zh_noDataView)];
    if (isImg || isMsg || isView) {
        //任意一个响应代理,说明有占位图或文字
        //如果 tableview 有tableHeaderView,展示占位图就会被遮挡所以将占位图设置到tableFooterView上
        UIView *headerView = self.tableHeaderView;
        CGFloat Y = self.bounds.size.height * (1 - 0.618);
        CGFloat height = headerView.frame.size.height;
        if (height + 50 > Y) {
            //有表头需要将 backgroundView 移除
            self.backgroundView = nil;
            if (havingData) {
                //如果有数据,tableFooterView 移除
                self.tableFooterView = nil;
                return;
            }
            if (self.tableFooterView) {
                return;
            }
            //如果创建了自定义的加载图
            if (isView) {
                self.tableFooterView = [self.delegate performSelector:@selector(zh_noDataView)];
                return ;
            }
            //创建视图
            UIImage  *img   = nil;
            NSString *msg   = @"暂无数据";
            UIColor  *color = [UIColor zh_colorWithHex:0x9daabf];;
            
            //获取图片
            if (isImg) {
                img = [self.delegate performSelector:@selector(zh_noDataViewImage)];
            }
            
            //获取文字
            if (isMsg) {
                msg = [self.delegate performSelector:@selector(zh_noDataViewMessage)];
            }
            //获取颜色
            if ([self.delegate      respondsToSelector:@selector(zh_noDataViewMessageColor)]) {
                color = [self.delegate performSelector:@selector(zh_noDataViewMessageColor)];
            }
            if (img || msg) {
                self.tableFooterView = [self createFooterView:img message:msg color:color];
            }
            
            return;
        }
        self.tableFooterView = [UIView new];
        //不需要占位图,移除监听
        if (havingData) {
            self.backgroundView = nil;
            return ;
        }
        //如果已经存在,则不需要再次创建
        if (self.backgroundView) {
            return ;
        }
        //如果创建了自定义的加载图
        if (isView) {
            self.backgroundView = [self.delegate performSelector:@selector(zh_noDataView)];
            return ;
        }
        //使用自带的
        UIImage  *img   = nil;
        NSString *msg   = @"暂无数据";
        UIColor  *color = [UIColor zh_colorWithHex:0x9daabf];
        CGFloat  offset = 0;
        
        //获取图片
        if (isImg) {
            img = [self.delegate performSelector:@selector(zh_noDataViewImage)];
        }
        
        //获取文字
        if (isMsg) {
            msg = [self.delegate performSelector:@selector(zh_noDataViewMessage)];
        }
        //获取颜色
        if ([self.delegate      respondsToSelector:@selector(zh_noDataViewMessageColor)]) {
            color = [self.delegate performSelector:@selector(zh_noDataViewMessageColor)];
        }
        //获取偏移量
        if ([self.delegate        respondsToSelector:@selector(zh_noDataViewCenterYOffset)]) {
            offset = [[self.delegate performSelector:@selector(zh_noDataViewCenterYOffset)] floatValue];
        }
        
        if (img || msg) {
            self.backgroundView = [self createBackgroundView:img message:msg color:color offsetY:offset];
        }
    }
    
}

/**
 创建FooterView默认占位图
 
 @param image 图片
 @param message 提示语
 @param color 提示语颜色
 @return 占位视图
 */
-(UIView *)createFooterView:(UIImage *)image message:(NSString *)message color:(UIColor *)color{
    CGFloat sW = self.bounds.size.width;
    CGFloat cX = sW / 2;
    CGFloat iW = image.size.width;
    CGFloat iH = image.size.height;
    //  图片
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.frame = CGRectMake(cX - iW / 2, 20, iW, iH);
    imgView.image = image;
    
    //  文字
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = color ? color : [UIColor zh_colorWithHex:0x9daabf];
    label.text = message;
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(0, CGRectGetMaxY(imgView.frame) + 20, sW, label.font.lineHeight);
    //  视图
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, sW, CGRectGetMaxY(label.frame) + 40)];
    [view addSubview:imgView];
    [view addSubview:label];
    return view;
}


/**
 创建backgroundView默认占位图
 
 @param image  图片
 @param message 提示语
 @param color 提示语颜色
 @param offset 偏移量 + 向下偏移 - 向上偏移
 @return 占位图
 */
- (UIView *)createBackgroundView:(UIImage *)image message:(NSString *)message color:(UIColor *)color offsetY:(CGFloat)offset {
    //  计算位置, 垂直居中, 图片默认中心偏上.
    CGFloat sW = self.bounds.size.width;
    CGFloat cX = sW / 2;
    CGFloat cY = self.bounds.size.height * (1 - 0.618) + offset;
    CGFloat iW = image.size.width;
    CGFloat iH = image.size.height;
    
    //  图片
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.frame = CGRectMake(cX - iW / 2, cY - iH / 2, iW, iH);
    imgView.image = image;
    
    //  文字
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = color ? color : [UIColor zh_colorWithHex:0x9daabf];
    label.text = message;
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(0, CGRectGetMaxY(imgView.frame) + 20, sW, label.font.lineHeight);
    
    //  视图
    UIView *view = [[UIView alloc] init];
    [view addSubview:imgView];
    [view addSubview:label];
    
    //实现跟随 TableView 滚动,我这里用的是自动移除监听,不需要手动移除
    [view zh_addObserver:self forKeyPath:MNoDataViewObserveKeyPath];
    return view;
}

/**
 监听
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:MNoDataViewObserveKeyPath]) {
        
        CGRect frame = [[change objectForKey:NSKeyValueChangeNewKey] CGRectValue];
        if (frame.origin.y != 0) {
            frame.origin.y  = 0;
            self.backgroundView.frame = frame;
        }
    }
}

#pragma mark - 初始化属性



@end
