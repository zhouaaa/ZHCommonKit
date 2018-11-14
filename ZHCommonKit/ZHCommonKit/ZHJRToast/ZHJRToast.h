//
//  ZHJRToast.h
//  ZHCommonKit
//
//  Created by Mac on 2018/11/14.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define DEFAULT_DISPLAY_DURATION 2

@interface ZHJRToast : UIView
{
    NSString  * _Nullable  _text;
    UIButton * _Nullable _contentView;
    CGFloat _duration;
}

+ (void)showWithText:(nullable NSString *)text;
+ (void)showWithText:(nullable NSString *)text duration:(CGFloat)duration;

+ (void)showWithText:(nullable NSString *)text topOffset:(CGFloat)topOffset;
+ (void)showWithText:(nullable NSString *)text topOffset:(CGFloat)topOffset duration:(CGFloat)duration;

+ (void)showWithText:(nullable NSString *)text bottomOffset:(CGFloat)bottomOffset;
+ (void)showWithText:(nullable NSString *)text bottomOffset:(CGFloat)bottomOffset duration:(CGFloat)duration;

@end

NS_ASSUME_NONNULL_END
