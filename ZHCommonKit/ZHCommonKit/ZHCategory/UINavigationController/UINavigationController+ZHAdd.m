//
//  UINavigationController+ZHAdd.m
//  ZHCommonKit
//
//  Created by Mac on 2018/11/16.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import "UINavigationController+ZHAdd.h"

@implementation UINavigationController (ZHAdd)

#pragma mark -寻找Navigation中的某个viewcontroler
- (id)findViewController:(Class)className
{
    for (UIViewController *viewController in self.viewControllers)
    {
        if ([viewController isKindOfClass:className])
        {
            return viewController;
        }
    }
    
    return nil;
}



#pragma mark -判断是否只有一个RootViewController
- (BOOL)isOnlyContainRootViewController
{
    if (self.viewControllers && self.viewControllers.count == 1)
    {
        return YES;
    }
    return NO;
}



#pragma mark -获取RootViewController
- (UIViewController *)rootViewController
{
    if (self.viewControllers && [self.viewControllers count] >0)
    {
        return [self.viewControllers firstObject];
    }
    return nil;
}



#pragma mark -返回指定的viewcontroler
- (NSArray *)popToViewControllerWithClassName:(Class)className animated:(BOOL)animated
{
    return [self popToViewController:[self findViewController:className] animated:YES];
}



#pragma mark -pop回第n层
- (NSArray *)popToViewControllerWithLevel:(NSInteger)level animated:(BOOL)animated
{
    NSInteger viewControllersCount = self.viewControllers.count;
    if (viewControllersCount > level) {
        NSInteger idx = viewControllersCount - level - 1;
        UIViewController *viewController = self.viewControllers[idx];
        return [self popToViewController:viewController animated:animated];
    } else {
        return [self popToRootViewControllerAnimated:animated];
    }
}


#pragma mark -pushVC
- (void)pushViewController:(UIViewController *)controller withTransition:(UIViewAnimationTransition)transition
{
    [UIView beginAnimations:nil context:NULL];
    if (self.childViewControllers.count != 0) {
        controller.hidesBottomBarWhenPushed = YES;
    }
    [self pushViewController:controller animated:NO];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationTransition:transition forView:self.view cache:YES];
    [UIView commitAnimations];
}



#pragma mark -popVC
- (UIViewController *)popViewControllerWithTransition:(UIViewAnimationTransition)transition
{
    [UIView beginAnimations:nil context:NULL];
    UIViewController *controller = [self popViewControllerAnimated:NO];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationTransition:transition forView:self.view cache:YES];
    [UIView commitAnimations];
    return controller;
}


@end
