//
//  UIView+ZHEmptyViewFrame.h
//  ZHCommonKit
//
//  Created by Mac on 2018/11/29.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ZHEmptyViewFrame)


@property (nonatomic, assign) CGFloat ly_x;
@property (nonatomic, assign) CGFloat ly_y;
@property (nonatomic, assign) CGFloat ly_width;
@property (nonatomic, assign) CGFloat ly_height;
@property (nonatomic, assign) CGFloat ly_centerX;
@property (nonatomic, assign) CGFloat ly_centerY;
@property (nonatomic, assign) CGSize  ly_size;
@property (nonatomic, assign) CGPoint ly_origin;
@property (nonatomic, assign, readonly) CGFloat ly_maxX;
@property (nonatomic, assign, readonly) CGFloat ly_maxY;


@end

NS_ASSUME_NONNULL_END
