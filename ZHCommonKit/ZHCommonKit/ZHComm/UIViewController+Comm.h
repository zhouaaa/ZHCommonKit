//
//  UIViewController+Comm.h
//  ZHCommonKit
//
//  Created by Mac on 2018/11/15.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Comm)

#pragma mark -找到当前视图控制器


/**
 找到当前视图控制器

 @return return value currentViewController
 */
-(UIViewController *)currentViewController;

#pragma mark -找到当前导航控制器


/**
 找到当前导航控制器

 @return currentNavigatonController
 */
-(UINavigationController *)currentNavigatonController;



/**
 是否设置返回按钮
 */
@property (nonatomic) BOOL isSetBackButton;

/**
 放下键盘
 */
@property (nonatomic) BOOL isDisMissKeyBoard;

/**
 事件方法
 */
@property (copy, nonatomic) NSString *method;




@end

NS_ASSUME_NONNULL_END
