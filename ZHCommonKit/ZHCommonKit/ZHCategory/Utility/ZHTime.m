//
//  ZHTime.m
//  ZHToolsDemo
//
//  Created by Mac on 2018/11/9.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import "ZHTime.h"

@interface ZHTime ()
{
    
    BOOL isValid;
    BOOL isRepeats;
    
}

@end

@implementation ZHTime

- (id)init{
    self = [super init];
    isValid = YES;
    isRepeats = YES;
    return self;
}

+ (nullable ZHTime *)scheduledTimerWithTimeInterval:(NSTimeInterval)time target:(nullable id)mTarget selector:(nullable SEL)mSelector repeats:(BOOL)repeats{
    ZHTime *timer = [[ZHTime alloc]init];
    timer.time = time;
    timer.mtarget = mTarget;
    timer.mSelector = mSelector;
    if (repeats) {
        [timer repeatSelector];
    }else{
        //采用 GCD 方法,用全局队列延时调用
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [mTarget performSelectorOnMainThread:mSelector withObject:nil waitUntilDone:NO];
        });
    }
    return timer;
}

+ (nullable ZHTime *)scheduledTimerWithTimeInterval:(NSTimeInterval)time target:(nullable id)mTarget selector:(nullable SEL)mSelector userInfo:(nullable id)userInfo repeats:(BOOL)repeats{
    ZHTime *timer = [[ZHTime alloc]init];
    timer.time = time;
    timer.mtarget = mTarget;
    timer.mSelector = mSelector;
    timer.userInfo = userInfo;
    if (repeats) {
        [timer repeatSelector];
    }else{
        //采用 GCD 方法,用全局队列延时调用
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [mTarget performSelectorOnMainThread:mSelector withObject:userInfo waitUntilDone:NO];
        });
    }
    return timer;
}


-(void)repeatSelector{
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.time * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //顺序执行以下代码
        //isRepeats:YES 发消息 NO 暂停发消息
        if (self->isRepeats) {
            [self.mtarget performSelectorOnMainThread:self.mSelector withObject:self.userInfo waitUntilDone:NO];
        }
        //方法中调用自己,来达到循环效果
        if (self->isValid) {
            [self repeatSelector];
        }
    });
    
}
- (void)reStart{
    isRepeats = YES;
}
- (void)stop{
    isRepeats = NO;
}
- (void)invalidate{
    isValid = NO;
}


@end
