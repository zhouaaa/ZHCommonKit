//
//  UIView+ZHAdd.m
//  ZHToolsDemo
//
//  Created by Mac on 2018/11/9.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import "UIView+ZHAdd.h"
#import <QuartzCore/QuartzCore.h>


#define kShadowViewTag 2132
#define kValidDirections [NSArray arrayWithObjects: @"top", @"bottom", @"left", @"right",nil]



@implementation UIView (ZHAdd)

#pragma mark - 坐标

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
//因为 readonly 只需要实现 get 方法
- (UIViewController *)viewControl{
    for (UIView *view = self; view; view = view.superview) {
        //这里很巧妙的运用了 view = view.superview 循环,每循环一次就会找到当前视图的父类,一直到 control.view
        UIResponder *respnder = [view nextResponder];
        if ([respnder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)respnder;
        }
    }
    return nil;
}

#pragma mark - 截图

- (nullable UIImage *)zh_snapshotImage{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}

- (nullable NSData *)zh_snapshotPDF{
    CGRect bounds = self.bounds;
    NSMutableData *data = [NSMutableData data];
    CGDataConsumerRef consumer = CGDataConsumerCreateWithCFData((__bridge  CFMutableDataRef)data);
    CGContextRef context = CGPDFContextCreate(consumer, &bounds, NULL);
    CGDataConsumerRelease(consumer);
    if (!context) {
        return nil;
    }
    CGPDFContextBeginPage(context, NULL);
    CGContextTranslateCTM(context, 0, bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    [self.layer renderInContext:context];
    CGPDFContextEndPage(context);
    CGPDFContextClose(context);
    CGContextRelease(context);
    return data;
}



/**
 添加阴影

 @param color color description
 @param offset offset description
 @param radius radius description
 */
- (void)setLayerShadow:(nullable UIColor *)color offset:(CGSize)offset radius:(CGFloat)radius{
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = 1;//阴影不透明程度
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}


- (void)makeInsetShadow
{
    NSArray *shadowDirections = [NSArray arrayWithObjects:@"top", @"bottom", @"left" , @"right" , nil];
    UIColor *color = [UIColor colorWithRed:(0.0) green:(0.0) blue:(0.0) alpha:0.5];
    
    UIView *shadowView = [self createShadowViewWithRadius:3 Color:color Directions:shadowDirections];
    shadowView.tag = kShadowViewTag;
    
    [self addSubview:shadowView];
}

- (void)makeInsetShadowWithRadius:(float)radius Alpha:(float)alpha
{
    NSArray *shadowDirections = [NSArray arrayWithObjects:@"top", @"bottom", @"left" , @"right" , nil];
    UIColor *color = [UIColor colorWithRed:(0.0) green:(0.0) blue:(0.0) alpha:alpha];
    
    UIView *shadowView = [self createShadowViewWithRadius:radius Color:color Directions:shadowDirections];
    shadowView.tag = kShadowViewTag;
    
    [self addSubview:shadowView];
}

- (void) makeInsetShadowWithRadius:(float)radius Color:(UIColor *)color Directions:(NSArray *)directions
{
    UIView *shadowView = [self createShadowViewWithRadius:radius Color:color Directions:directions];
    shadowView.tag = kShadowViewTag;
    
    [self addSubview:shadowView];
}

- (UIView *) createShadowViewWithRadius:(float)radius Color:(UIColor *)color Directions:(NSArray *)directions
{
    UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    shadowView.backgroundColor = [UIColor clearColor];
    // Ignore duplicate direction
    NSMutableDictionary *directionDict = [[NSMutableDictionary alloc] init];
    for (NSString *direction in directions) [directionDict setObject:@"1" forKey:direction];
    for (NSString *direction in directionDict) {
        // Ignore invalid direction
        if ([kValidDirections containsObject:direction])
        {
            CAGradientLayer *shadow = [CAGradientLayer layer];
            
            if ([direction isEqualToString:@"top"]) {
                [shadow setStartPoint:CGPointMake(0.5, 0.0)];
                [shadow setEndPoint:CGPointMake(0.5, 1.0)];
                shadow.frame = CGRectMake(0, 0, self.bounds.size.width, radius);
            }
            else if ([direction isEqualToString:@"bottom"])
            {
                [shadow setStartPoint:CGPointMake(0.5, 1.0)];
                [shadow setEndPoint:CGPointMake(0.5, 0.0)];
                shadow.frame = CGRectMake(0, self.bounds.size.height - radius, self.bounds.size.width, radius);
            } else if ([direction isEqualToString:@"left"])
            {
                shadow.frame = CGRectMake(0, 0, radius, self.bounds.size.height);
                [shadow setStartPoint:CGPointMake(0.0, 0.5)];
                [shadow setEndPoint:CGPointMake(1.0, 0.5)];
            } else if ([direction isEqualToString:@"right"])
            {
                shadow.frame = CGRectMake(self.bounds.size.width - radius, 0, radius, self.bounds.size.height);
                [shadow setStartPoint:CGPointMake(1.0, 0.5)];
                [shadow setEndPoint:CGPointMake(0.0, 0.5)];
            }
            shadow.colors = [NSArray arrayWithObjects:(id)[color CGColor], (id)[[UIColor clearColor] CGColor], nil];
            [shadowView.layer insertSublayer:shadow atIndex:0];
        }
    }
    return shadowView;
}


- (void)zh_removeAllSubview{
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}

#pragma mark - 坐标转化

- (CGPoint)convertPoint:(CGPoint)point toViewOrWindow:(nullable UIView *)view{
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertPoint:point toWindow:nil];
        } else {
            return [self convertPoint:point toView:nil];
        }
    }
    
    UIWindow *from = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    UIWindow *to = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    if ((!from || !to) || (from == to)) return [self convertPoint:point toView:view];
    point = [self convertPoint:point toView:from];
    point = [to convertPoint:point fromWindow:from];
    point = [view convertPoint:point fromView:to];
    return point;
}

- (CGPoint)convertPoint:(CGPoint)point fromViewOrWindow:(nullable UIView *)view{
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertPoint:point fromWindow:nil];
        } else {
            return [self convertPoint:point fromView:nil];
        }
    }
    
    UIWindow *from = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    UIWindow *to = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    if ((!from || !to) || (from == to)) return [self convertPoint:point fromView:view];
    point = [from convertPoint:point fromView:view];
    point = [to convertPoint:point fromWindow:from];
    point = [self convertPoint:point fromView:to];
    return point;
}

- (CGRect)convertRect:(CGRect)rect toViewOrWindow:(nullable UIView *)view{
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertRect:rect toWindow:nil];
        } else {
            return [self convertRect:rect toView:nil];
        }
    }
    
    UIWindow *from = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    UIWindow *to = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    if (!from || !to) return [self convertRect:rect toView:view];
    if (from == to) return [self convertRect:rect toView:view];
    rect = [self convertRect:rect toView:from];
    rect = [to convertRect:rect fromWindow:from];
    rect = [view convertRect:rect fromView:to];
    return rect;
}

- (CGRect)convertRect:(CGRect)rect fromViewOrWindow:(nullable UIView *)view{
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertRect:rect fromWindow:nil];
        } else {
            return [self convertRect:rect fromView:nil];
        }
    }
    
    UIWindow *from = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    UIWindow *to = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    if ((!from || !to) || (from == to)) return [self convertRect:rect fromView:view];
    rect = [from convertRect:rect fromView:view];
    rect = [to convertRect:rect fromWindow:from];
    rect = [self convertRect:rect fromView:to];
    return rect;
}

@end
