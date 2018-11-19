//
//  UINavigationController+ZHAdd.h
//  ZHCommonKit
//
//  Created by Mac on 2018/11/16.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (ZHAdd)

#pragma mark -寻找Navigation中的某个viewcontroler
- (id)findViewController:(Class)className;

#pragma mark -判断是否只有一个RootViewController
- (BOOL)isOnlyContainRootViewController;

#pragma mark -获取RootViewController
- (UIViewController *)rootViewController;

#pragma mark -返回指定的viewcontroler
- (NSArray *)popToViewControllerWithClassName:(Class)className animated:(BOOL)animated;

#pragma mark -pop回第n层
- (NSArray *)popToViewControllerWithLevel:(NSInteger)level animated:(BOOL)animated;


#pragma mark -pushVC
- (void)pushViewController:(UIViewController *)controller withTransition:(UIViewAnimationTransition)transition;

#pragma mark -popVC
- (UIViewController *)popViewControllerWithTransition:(UIViewAnimationTransition)transition;



@end

NS_ASSUME_NONNULL_END
