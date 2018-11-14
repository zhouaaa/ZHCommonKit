//
//  NSDate+ZHAdd.h
//  ZHToolsDemo
//
//  Created by Mac on 2018/11/9.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (ZHAdd)

#pragma mark - 日期扩展属性
/** 当前日期的年*/
@property (nonatomic, readonly) NSInteger year;
/** 月(1-12)*/
@property (nonatomic, readonly) NSInteger month;
/** 天(1-31)*/
@property (nonatomic, readonly) NSInteger day;
/** 小时(0-23)*/
@property (nonatomic, readonly) NSInteger hour;
/** 分钟(0-59)*/
@property (nonatomic, readonly) NSInteger minute;
/** 秒(0-59)*/
@property (nonatomic, readonly) NSInteger second;
/** 毫秒*/
@property (nonatomic, readonly) NSInteger nanosecond;
/** 第几周*/
@property (nonatomic, readonly) NSInteger weekday;

@property (nonatomic, readonly) NSInteger weekdayOrdinal;
/** 基于月第几周(1-5)*/
@property (nonatomic, readonly) NSInteger weekOfMonth;
/** 基于年第几周(1-53)*/
@property (nonatomic, readonly) NSInteger weekOfYear;
/** 一年的一个星期的组成部分*/
@property (nonatomic, readonly) NSInteger yearForWeekOfYear;
/** 第几季度*/
@property (nonatomic, readonly) NSInteger quarter;
/** 是否为闰月*/
@property (nonatomic, readonly) BOOL isLeapMonth;
/** 是否为闰年*/
@property (nonatomic, readonly) BOOL isLeapYear;
/** 是否为今天*/
@property (nonatomic, readonly) BOOL isToday;
/** 是否为昨天*/
@property (nonatomic, readonly) BOOL isYesterday;
/** 获取当前日期当月的总天数*/
@property (nonatomic,assign,readonly) NSInteger monthAllDay;

#pragma mark - 日期\时间\时间戳 转换

/**
 获取当前时间的时间戳
 
 @return 时间戳
 */
+ (NSString *)zh_getCurrentTimeStamp;

/**
 时间戳格式化;13位时间戳也可以转换
 
 @param timeStap 时间戳
 @param format 时间格式
 @return 时间. eg:2018-01-01 12:00:00
 */
+ (NSString *)zh_changeFromTimeStamp:(NSString *)timeStap
                             format:(NSString *)format;

/**
 获取当前日期本月的天数
 
 @param date 日期
 @return 天数
 */
+ (NSInteger)zh_currentMonthOfDay:(NSDate *)date;

/**
 获取当前日期所在月的行数
 
 @param date 日期
 @return 行数
 */
+ (NSInteger)zh_getMonthRows:(NSDate *)date;

/**
 判断某一天与日期是否为同一天
 日期格式: YYYY-MM-DD
 @param dayString  某一天
 @param date 日期
 @return  YES 是同一天; NO 反之
 */
+ (BOOL)zh_checkOneday:(NSString *)dayString
          anotherDate:(NSDate *)date;

/**
 判断两个日期是否为同一天
 
 @param oneDay  一天
 @param anotherDay 另一天
 @return  YES 同一天; NO 反之
 */
+ (BOOL)zh_checkSameDay:(NSDate *)oneDay
           anotherDate:(NSDate *)anotherDay;

/**
 通过日期,获取当前是周几
 
 @param date 日期
 @return 周数(1-7  ->  日-六)
 */
+ (NSInteger)zh_getNumberInWeek:(NSDate *)date;

/**
 获取指定日期所在月的全部天数
 
 @param date  日期
 @return  总天数
 */
+ (NSInteger)zh_getCurrentMonthAllDay:(NSDate *)date;

/**
 判断两个日期是否为同月
 
 @param oneDate  日期
 @param anotherDate 另一个日期
 @return  YES, 同月;NO, 反之
 */
+ (BOOL)zh_checkSameMonth:(NSDate *)oneDate
             anotherMoth:(NSDate *)anotherDate;


/**
 返回 刚刚、几分钟前、几小时前、昨天 、日期

 @param time (时间格式:2017-01-01 21:05:10)
 @return 刚刚、几分钟前、几小时前、昨天 、日期
 */
+ (NSString *)zh_getEasyDateWithDate:(NSString *) time;

@end

NS_ASSUME_NONNULL_END
