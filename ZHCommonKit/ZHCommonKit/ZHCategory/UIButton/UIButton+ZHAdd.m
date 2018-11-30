
//
//  UIButton+ZHAdd.m
//  ZHToolsDemo
//
//  Created by Mac on 2018/11/9.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import "UIButton+ZHAdd.h"
#import "NSObject+ZHAdd.h"


@interface UIButton ()
/** 防止重复点击,中间替换变量*/
@property (nonatomic, assign) NSTimeInterval custom_acceptEventTime;

@end

@implementation UIButton (ZHAdd)

-(void)setFont:(UIFont *)font{
    self.titleLabel.font = font;
}

-(UIFont *)font{
    return self.titleLabel.font;
}

-(void)setNormalTitle:(NSString *)normalTitle{
    [self setTitle:normalTitle forState:UIControlStateNormal];
}

-(NSString *)normalTitle{
    return self.titleLabel.text;
}

-(void)setSelectTitle:(NSString *)selectTitle{
    [self setTitle:selectTitle forState:UIControlStateSelected];
    objc_setAssociatedObject(self, @selector(selectTitle), selectTitle, OBJC_ASSOCIATION_COPY);
}

-(NSString *)selectTitle{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setNormalColor:(UIColor *)normalColor{
    [self setTitleColor:normalColor forState:UIControlStateNormal];
    objc_setAssociatedObject(self, @selector(normalColor), normalColor, OBJC_ASSOCIATION_COPY);
}

-(UIColor *)normalColor{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setSelectColor:(UIColor *)selectColor{
    [self setTitleColor:selectColor forState:UIControlStateSelected];
    objc_setAssociatedObject(self, @selector(selectColor), selectColor, OBJC_ASSOCIATION_COPY);
}

-(UIColor *)selectColor{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setNormalImage:(UIImage *)normalImage{
    [self setImage:normalImage forState:UIControlStateNormal];
    objc_setAssociatedObject(self, @selector(normalImage), normalImage, OBJC_ASSOCIATION_COPY);
}

-(UIImage *)normalImage{
    return objc_getAssociatedObject(self, _cmd);
    
}

-(void)setSelectImage:(UIImage *)selectImage{
    [self setImage:selectImage forState:UIControlStateSelected];
    objc_setAssociatedObject(self, @selector(selectImage), selectImage, OBJC_ASSOCIATION_COPY);
}

-(UIImage *)selectImage{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setNormalBackgroundImage:(UIImage *)normalBackgroundImage{
    [self setBackgroundImage:normalBackgroundImage forState:UIControlStateNormal];
    objc_setAssociatedObject(self, @selector(normalBackgroundImage), normalBackgroundImage, OBJC_ASSOCIATION_COPY);
}

-(UIImage *)normalBackgroundImage{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setSelectBackgroundImage:(UIImage *)selectBackgroundImage{
    [self setBackgroundImage:selectBackgroundImage forState:UIControlStateSelected];
    objc_setAssociatedObject(self, @selector(selectBackgroundImage), selectBackgroundImage, OBJC_ASSOCIATION_COPY);
}

-(UIImage *)selectBackgroundImage{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setAddRadiu:(CGFloat)addRadiu{
    self.clipsToBounds = YES;
    self.layer.cornerRadius = addRadiu;
    objc_setAssociatedObject(self, @selector(addRadiu), @(addRadiu), OBJC_ASSOCIATION_ASSIGN);
}

-(CGFloat)addRadiu{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (NSTimeInterval )custom_acceptEventInterval{
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}

- (void)setCustom_acceptEventInterval:(NSTimeInterval)custom_acceptEventInterval{
    objc_setAssociatedObject(self,@selector(custom_acceptEventInterval), @(custom_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval )custom_acceptEventTime{
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}

- (void)setCustom_acceptEventTime:(NSTimeInterval)custom_acceptEventTime{
    objc_setAssociatedObject(self, @selector(custom_acceptEventTime), @(custom_acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)setClickBlock:(MClickBlock)clickBlock{
    [self removeTarget:self action:@selector(buttonClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    if (clickBlock) {
        if (self.custom_acceptEventInterval > 0) {
            self.custom_acceptEventTime = NSDate.date.timeIntervalSince1970;
        }
        [self addTarget:self action:@selector(buttonClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(MClickBlock)clickBlock{
    return objc_getAssociatedObject(self, _cmd);
}


/**
 改变按钮的响应区域（上左下右分别增加或减小多少  正数为增加 负数为减小）

 @return return value description
 */
- (UIEdgeInsets)clickEdgeInsets
{
    return [objc_getAssociatedObject(self, @selector(clickEdgeInsets)) UIEdgeInsetsValue];
}

- (void)setClickEdgeInsets:(UIEdgeInsets)clickEdgeInsets
{
    objc_setAssociatedObject(self, @selector(clickEdgeInsets), [NSValue valueWithUIEdgeInsets:clickEdgeInsets], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    if (UIEdgeInsetsEqualToEdgeInsets(self.clickEdgeInsets, UIEdgeInsetsZero))
    {
        return [super pointInside:point withEvent:event];
    }
    else
    {
        CGRect large = UIEdgeInsetsInsetRect(self.bounds, self.clickEdgeInsets);
        return CGRectContainsPoint(large, point) ? YES : NO;
    }
}
//=========================================================

#pragma mark - Method

-(void)buttonClickEvent:(UIButton *)sender{
    if (self.clickBlock) {
        self.clickBlock();
    }
}

#pragma mark - 防止重复点击事件

+ (void)load{
    
    SEL sysSEL = @selector(sendAction:to:forEvent:);
    SEL customSEL = @selector(custom_sendAction:to:forEvent:);
    
    [self zh_addInstanceMethonWithOriginalSelector:sysSEL swizzledSelector:customSEL];
}

- (void)custom_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    
    // 如果想要设置统一的间隔时间，可以在此处加上以下几句
    // 值得提醒一下：如果这里设置了统一的时间间隔，会影响UISwitch,如果想统一设置，又不想影响UISwitch，建议将UIControl分类，改成UIButton分类，实现方法是一样的
     if (self.custom_acceptEventInterval <= 0) {
         // 如果没有自定义时间间隔，则默认为2秒
        self.custom_acceptEventInterval = 2;
     }
    
    // 是否小于设定的时间间隔
    BOOL needSendAction = (NSDate.date.timeIntervalSince1970 - self.custom_acceptEventTime >= self.custom_acceptEventInterval);
    
    // 更新上一次点击时间戳
    if (self.custom_acceptEventInterval > 0) {
        self.custom_acceptEventTime = NSDate.date.timeIntervalSince1970;
    }
    
    // 两次点击的时间间隔小于设定的时间间隔时，才执行响应事件
    if (needSendAction) {
        [self custom_sendAction:action to:target forEvent:event];
        
    }
}

- (void)layoutButtonWithEdgeInsetsStyle:(ButtonEdgeInsetsStyle)style imageTitleSpace:(CGFloat)space{
    /**
     *  前置知识点：titleEdgeInsets是title相对于其上下左右的inset，跟tableView的contentInset是类似的，
     *  如果只有title，那它上下左右都是相对于button的，image也是一样；
     *  如果同时有image和label，那这时候image的上左下是相对于button，右边是相对于label的；title的上右下是相对于button，左边是相对于image的。
     */
    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    CGFloat labelWidth = self.titleLabel.intrinsicContentSize.width;
    CGFloat labelHeight = self.titleLabel.intrinsicContentSize.height;
    
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    switch (style) {
        case ButtonEdgeInsetsStyleTop:
        {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth-space);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith + space/2, -imageHeight-space/2.0, 0);
        }
            break;
        case ButtonEdgeInsetsStyleLeft:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }
            break;
        case ButtonEdgeInsetsStyleBottom:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
        }
            break;
        case ButtonEdgeInsetsStyleRight:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
        }
            break;
        case ButtonEdgeInsetsStyleMind:{
            CGFloat totleWidth = imageWith + labelWidth;
            imageEdgeInsets = UIEdgeInsetsMake(0, totleWidth/4+3, 0, totleWidth/4);
            labelEdgeInsets = UIEdgeInsetsMake(0, - totleWidth/4-3, 0, totleWidth/4);
            
        }
        default:
            break;
    }
    
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}



/**
 @param timeout     总时间
 @param waitBlock   倒计时过程中可以再里面做一些操作
 @param finishBlock 完成时执行的block
 */
- (void)startTime:(NSInteger)timeout waitBlock:(void(^)(NSInteger remainTime))waitBlock finishBlock:(void(^)(void))finishBlock
{
    __block NSInteger timeOut = timeout;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeOut <= 0)
        { //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (finishBlock)
                {
                    finishBlock();
                }
                self.userInteractionEnabled = YES;
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (waitBlock)
                {
                    waitBlock(timeOut);
                }
                self.userInteractionEnabled = NO;
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}


#pragma mark -提交按钮时在中间显示一个菊花

/**
 Button 显示菊花
 static NSString *const IndicatorViewKey = @"indicatorView";
 static NSString *const ButtonTextObjectKey = @"buttonTextObject";
 */
- (void)showIndicator
{
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicator.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    [indicator startAnimating];
    
    NSString *currentButtonText = self.titleLabel.text;
    
    objc_setAssociatedObject(self, @"buttonTextObject", currentButtonText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, @"indicatorView", indicator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    self.enabled = NO;
    [self setTitle:@"" forState:UIControlStateNormal];
    [self addSubview:indicator];
}


/**
 Button 隐藏菊花
 */
- (void)hideIndicator
{
    NSString *currentButtonText = (NSString *)objc_getAssociatedObject(self, @"buttonTextObject");
    UIActivityIndicatorView *indicator = (UIActivityIndicatorView *)objc_getAssociatedObject(self, @"indicatorView");
    
    self.enabled = YES;
    [indicator removeFromSuperview];
    [self setTitle:currentButtonText forState:UIControlStateNormal];
}


@end
