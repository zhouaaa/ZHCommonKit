//
//  ZHTime.h
//  ZHToolsDemo
//
//  Created by Mac on 2018/11/9.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZHTime : NSObject

@property  NSTimeInterval time;
@property (nullable,weak) id mtarget;
@property (nullable,nonatomic, assign) SEL mSelector;
@property (nullable, retain) id userInfo;

/**
 设置一个定时器
 
 @param time 定时器执行时间,每几秒执行一次任务
 @param mTarget  tager
 @param mSelector  定时器执行方法
 @param repeats 是否重复调用 YES 重复调用 NO 只执行一次
 @return 定时器
 */
+ (nullable ZHTime *)scheduledTimerWithTimeInterval:(NSTimeInterval)time target:(nullable id)mTarget selector:(nullable SEL)mSelector repeats:(BOOL)repeats;

/**
 设置定时器
 
 @param time 定时器执行时间
 @param mTarget  tager
 @param mSelector  定时器执行方法
 @param userInfo 传递参数
 @param repeats 是否重复调用 YES 重复调用 NO 只执行一次
 @return 定时器
 */
+ (nullable ZHTime *)scheduledTimerWithTimeInterval:(NSTimeInterval)time target:(nullable id)mTarget selector:(nullable SEL)mSelector userInfo:(nullable id)userInfo repeats:(BOOL)repeats;
//开启定时器
- (void)reStart;
//暂停定时器
- (void)stop;
//销毁定时器
- (void)invalidate;

@end

NS_ASSUME_NONNULL_END
