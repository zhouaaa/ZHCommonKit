//
//  ZHCategoryHeader.h
//  ZHToolsDemo
//
//  Created by Mac on 2018/11/12.
//  Copyright © 2018年 周辉. All rights reserved.
//


//#import <UIKit/UIKit.h>

#pragma mark - NSArray

#import "NSArray+ZHAdd.h"


#pragma mark - NSMutableArray

#import "NSMutableArray+ZHAdd.h"


#pragma mark - NSString

#import "NSString+ZHAdd.h"
#import "NSMutableAttributedString+ZHAdd.h"

#pragma mark - UIView

#import "UIView+ZHAdd.h"


#pragma mark - NSBundle

#import "NSBundle+ZHAdd.h"

#pragma mark - NSObject

#import "NSObject+ZHAdd.h"

#pragma mark - NSData

#import "NSData+ZHAdd.h"

#pragma mark - NSDate

#import "NSDate+ZHAdd.h"

#pragma mark - UIColor

#import "UIColor+ZHAdd.h"

#pragma mark - UIButton

#import "UIButton+ZHAdd.h"

#pragma mark - UIApplication

#import "UIApplication+ZHAdd.h"

#pragma mark -  UINavigationController

#import "UINavigationController+ZHAdd.h"

#pragma mark -  UILabel

#import "UILabel+ZHAdd.h"

#pragma mark - NSURL

#import "NSURL+ZHAdd.h"

#pragma mark - NSDictionary

#import "NSDictionary+ZHAdd.h"

#import "NSMutableDictionary+ZHAdd.h"

#pragma mark - UITableView

#import "UITableView+ZHPlaceholder.h"

#pragma mark - UIScrollView

#import "UIScrollView+ZHGesture.h"

#pragma mark - Utility

#import "ZHTime.h"

#pragma mark  - UITextField

#import "UITextField+ZHHistory.h"



#ifdef DEBUG
#define NSLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define NSLog(...)
#endif


