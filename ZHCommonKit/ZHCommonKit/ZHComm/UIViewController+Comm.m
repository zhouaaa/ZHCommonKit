//
//  UIViewController+Comm.m
//  ZHCommonKit
//
//  Created by Mac on 2018/11/15.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import "UIViewController+Comm.h"
#import <objc/runtime.h>


static NSString *nameWithSetterGetterKey =@"nameWithSetterGetterKey";

@implementation UIViewController (Comm)

#pragma mark -找到当前视图控制器
- (UIViewController *)currentViewController
{
    UIViewController * viewController = [[UIApplication sharedApplication].delegate window].rootViewController;
    
    return [self findBestViewController:viewController];
}

#pragma mark -找到当前导航控制器
- (UINavigationController *)currentNavigatonController {
    
    UIViewController * currentViewController =  [self currentViewController];
    
    return currentViewController.navigationController;
}


/**
 当前使用的控制器

 @param vc vc description
 @return return value description
 */
- (UIViewController *)findBestViewController:(UIViewController *)vc
{
    if (vc.presentedViewController)
    {
        return [self findBestViewController:vc.presentedViewController];
    }
    else if ([vc isKindOfClass:[UISplitViewController class]])
    {
        UISplitViewController * svc = (UISplitViewController*) vc;
        if (svc.viewControllers.count > 0)
        {
            return [self findBestViewController:svc.viewControllers.lastObject];
        }
        else
        {
            return vc;
        }
        
    }
    else if ([vc isKindOfClass:[UINavigationController class]])
    {
        UINavigationController * svc = (UINavigationController*) vc;
        if (svc.viewControllers.count > 0)
        {
            return [self findBestViewController:svc.topViewController];
        }
        else
        {
            return vc;
        }
        
    }
    else if ([vc isKindOfClass:[UITabBarController class]])
    {
        UITabBarController* svc = (UITabBarController *)vc;
        if (svc.viewControllers.count > 0)
        {
            return [self findBestViewController:svc.selectedViewController];
        }
        else
        {
            return vc;
        }
        
    }
    else
    {
        return vc;
    }
}


//==========================================================


//设置返回按钮
-(void)setIsSetBackButton:(BOOL)isSetBackButton
{
    if (isSetBackButton != self.isSetBackButton) {
        objc_setAssociatedObject(self, @"isSetBackButton", [NSNumber numberWithBool:isSetBackButton], OBJC_ASSOCIATION_ASSIGN);
    }
    
    if (isSetBackButton) {
        [self ZHAddCommBackButton];
    }
}


-(BOOL)isSetBackButton
{
    return objc_getAssociatedObject(self, @"isSetBackButton");
}


/**
 添加 Button
 */
-(void)ZHAddCommBackButton
{
    UIButton *backBn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBn.frame = CGRectMake(0, 0, 50, 44);
    
    [backBn addTarget:self action:@selector(CommBackPress:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backBn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}

-(void)CommBackPress:(id)sender{
    if ([self isEqual:self.navigationController.topViewController]) {
        [self.navigationController popViewControllerAnimated:true];
    }
}


#pragma mark -退下键盘
-(void)setIsDisMissKeyBoard:(BOOL)isDisMissKeyBoard
{
    if (isDisMissKeyBoard != self.isDisMissKeyBoard) {
        objc_setAssociatedObject(self, @"isDisMissKeyBoard", [NSNumber numberWithBool:isDisMissKeyBoard], OBJC_ASSOCIATION_ASSIGN);
    }
    //此method会将self.view里所有的subview的firstResponder都resign掉
    if (isDisMissKeyBoard) {
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        UITapGestureRecognizer *singleTapGR =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAnywhereToDismissKeyboard:)];
        __weak UIViewController *weakSelf = self;
        NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
        [nc addObserverForName:UIKeyboardWillShowNotification object:nil queue:mainQuene usingBlock:^(NSNotification *note){
            [weakSelf.view addGestureRecognizer:singleTapGR];
        }];
        [nc addObserverForName:UIKeyboardWillHideNotification object:nil queue:mainQuene usingBlock:^(NSNotification *note){
            [weakSelf.view removeGestureRecognizer:singleTapGR];
        }];
    }
}

-(BOOL)isDisMissKeyBoard
{
    return  objc_getAssociatedObject(self, @"isDisMissKeyBoard");
}

- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    //此method会将self.view里所有的subview的first responder都resign掉
    [self.view endEditing:YES];
}

//===================   method  ================

#pragma mark - swizzle
+ (void)load
{
    Method method1 = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
    Method method2 = class_getInstanceMethod([self class], @selector(deallocSwizzle));
    
    method_exchangeImplementations(method1, method2);
}


- (void)setMethod:(NSString *)method
{
    objc_setAssociatedObject(self, @"MethodKey", method, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)method
{
    return objc_getAssociatedObject(self, @"MethodKey");
}


- (void)deallocSwizzle
{
    NSLog(@"%@被销毁了", [self currentViewController]);
    [self deallocSwizzle];
}



@end