//
//  UIView+ZHEmptyView.m
//  ZHCommonKit
//
//  Created by Mac on 2018/11/29.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import "UIView+ZHEmptyView.h"
#import "ZHEmptyView.h"
#import <objc/runtime.h>


@implementation UIView (ZHEmptyView)

-(void)setEmptyView:(ZHEmptyView *)emptyView
{
    if (![self.emptyView isEqual:emptyView]) {
        for (UIView *subView in self.subviews) {
            if ([subView isKindOfClass:[ZHEmptyView class]]) {
                [subView removeFromSuperview];
            }
        }
        
        emptyView.frame = self.bounds;
        [self addSubview:emptyView];
        objc_setAssociatedObject(self, @"ZHEmptyView", emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}


-(ZHEmptyView *)emptyView
{
    return  objc_getAssociatedObject(self, @"ZHEmptyView");
}


-(void)hideEmptyView;{
    self.emptyView.hidden = true;
}

-(void)showEmptyView;{
    self.emptyView.hidden = false;
}


@end
