//
//  UIScrollView+ZHGesture.m
//  ZHToolsDemo
//
//  Created by Mac on 2018/11/12.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import "UIScrollView+ZHGesture.h"
#import <objc/message.h>



@implementation UIScrollView (ZHGesture)

+ (void)load{
    
    Method oldMethod = class_getClassMethod([UIScrollView class], @selector(gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:));
    
    Method newMethod = class_getClassMethod([self class], @selector(ZHGestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:));
    method_exchangeImplementations(oldMethod, newMethod);
}

- (BOOL)ZHGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if (self.contentOffset.x <= 0) {
        if ([otherGestureRecognizer.delegate isKindOfClass:NSClassFromString(@"_FDFullscreenPopGestureRecognizerDelegate")]) {
            return YES;
        }
    }
    return NO;
}


@end
