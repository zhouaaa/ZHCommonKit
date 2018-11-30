//
//  ZHConfig.h
//  ZHCommonKit
//
//  Created by Mac on 2018/11/28.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZHBackConfig.h"


NS_ASSUME_NONNULL_BEGIN

@interface ZHConfig : NSObject

@property(nonatomic) CGFloat navBarTitleFontSize; //全局导航栏字体大小默认 17

@property(nonatomic,strong,nullable) UIColor *navBarTitleColor;//全局导航栏字体颜色 默认 333333

@property(nonatomic,strong,nullable) UIImage *navBarBGImage;//全局导航栏背景图 默认 无

@property(nonatomic,strong,nullable) UIImage *navBarShawdowImage;//全局导航栏背景图 默认 无

@property(nonatomic,strong,nullable) UIColor *navBarTintColor; //navbar的叠加颜色 默认白色

@property(nonatomic) BOOL            navBarTranslucent; //是否透明 默认yes 为不透明

@property(nonatomic,strong) ZHBackConfig *backConfig; //返回配置

+(ZHConfig *)shareConfig;

//默认配置
-(void)config;

@end

NS_ASSUME_NONNULL_END
