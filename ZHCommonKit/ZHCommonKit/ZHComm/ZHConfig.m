//
//  ZHConfig.m
//  ZHCommonKit
//
//  Created by Mac on 2018/11/28.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import "ZHConfig.h"

static ZHConfig  * config;

@implementation ZHConfig

+(ZHConfig *)shareConfig
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[ZHConfig alloc] init];
    });
    return config;
}


-(instancetype)init
{
    self = [super init];
    if (self) {
        
        self.navBarTitleFontSize = 17;
        
        self.navBarTitleColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1];
        
        
        self.navBarBGImage = [UIImage imageNamed:@""];
        self.navBarShawdowImage = nil;
        self.navBarTranslucent = YES;
        self.navBarTintColor = [UIColor whiteColor];
        
        self.backConfig = [[ZHBackConfig alloc] init];
        
        self.backConfig.backImageName = @"navbar_icon_back";
    }
    return self;
}


-(void)config
{
    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
            self.navBarTitleColor,NSForegroundColorAttributeName,
            [UIFont systemFontOfSize:self.navBarTitleFontSize],NSFontAttributeName,
                        nil,nil];
    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
    
    [[UINavigationBar appearance] setBackgroundImage:self.navBarBGImage forBarMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setShadowImage:[self createImageWithColor:[UIColor clearColor]]];
    
    [[UINavigationBar appearance] setTranslucent:self.navBarTranslucent];
    
    [[UINavigationBar appearance] setBarTintColor:self.navBarTintColor];
    
}


- (UIImage *)createImageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f,0.0f,1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


@end
