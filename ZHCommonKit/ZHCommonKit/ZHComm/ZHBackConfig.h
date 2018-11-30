//
//  ZHBackConfig.h
//  ZHCommonKit
//
//  Created by Mac on 2018/11/28.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface ZHBackConfig : NSObject

@property(nonatomic,copy,nullable) NSString * backImageName; //默认 navbar_icon_back
@property(nonatomic,copy,nullable) NSString * backTitleName; //默认 nil

@property(nonatomic,retain) UIFont * backFont;//字体大小 15


@end

NS_ASSUME_NONNULL_END
