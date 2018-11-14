//
//  NSDate+ZHAdd.m
//  ZHToolsDemo
//
//  Created by Mac on 2018/11/9.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import "NSDate+ZHAdd.h"

@implementation NSDate (ZHAdd)

- (NSInteger)year {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self] year];
}

- (NSInteger)month {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self] month];
}

- (NSInteger)day {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self] day];
}

- (NSInteger)hour {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:self] hour];
}

- (NSInteger)minute {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDate:self] minute];
}

- (NSInteger)second {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self] second];
}

- (NSInteger)nanosecond {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self] nanosecond];
}

- (NSInteger)weekday {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self] weekday];
}

- (NSInteger)weekdayOrdinal {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekdayOrdinal fromDate:self] weekdayOrdinal];
}

- (NSInteger)weekOfMonth {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfMonth fromDate:self] weekOfMonth];
}

- (NSInteger)weekOfYear {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfYear fromDate:self] weekOfYear];
}

- (NSInteger)yearForWeekOfYear {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYearForWeekOfYear fromDate:self] yearForWeekOfYear];
}

- (NSInteger)quarter {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitQuarter fromDate:self] quarter];
}

- (BOOL)isLeapMonth {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitQuarter fromDate:self] isLeapMonth];
}

- (BOOL)isLeapYear {
    NSUInteger year = self.year;
    return ((year % 400 == 0) || ((year % 100 != 0) && (year % 4 == 0)));
}

- (BOOL)isToday {
    if (fabs(self.timeIntervalSinceNow) >= 60 * 60 * 24) return NO;
    return [NSDate new].day == self.day;
}

- (BOOL)isYesterday {
    
    NSDate *added = [self dateByAddingDays:1];
    
    return [added isToday];
}

- (NSInteger)monthAllDay{
    NSRange totaldaysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    return totaldaysInMonth.length;
}

- (NSDate *)dateByAddingDays:(NSInteger)days {
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + 86400 * days;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}



#pragma mark - 日期\时间\时间戳 转换

/**
 获取当前时间的时间戳
 
 @return 时间戳
 */
+ (NSString *)zh_getCurrentTimeStamp
{
    NSDate *currentDate = [NSDate date];
    long time = (long)[currentDate timeIntervalSince1970];
    return [NSString stringWithFormat:@"%ld",time];
}

/**
 时间戳格式化;13位时间戳也可以转换
 
 @param timeStap 时间戳
 @param format 时间格式
 @return 时间. eg:2018-01-01 12:00:00
 */
+ (NSString *)zh_changeFromTimeStamp:(NSString *)timeStap
                              format:(NSString *)format
{
    if (timeStap.length == 13) {
        timeStap = [timeStap substringFromIndex:10];
    }
    NSTimeInterval secs = [timeStap doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:secs];
    NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
    NSString *tempFormat = @"yyyy-MM-dd HH:mm:ss";
    if (format) {
        tempFormat = format;
    }
    [dateformat setDateFormat:tempFormat];
    return [dateformat stringFromDate: date];
}



/**
 获取当前日期本月的天数
 
 @param date 日期
 @return 天数
 */
+ (NSInteger)zh_currentMonthOfDay:(NSDate *)date
{
    NSRange totaldaysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return totaldaysInMonth.length;
}



/**
 获取当前日期所在月的行数
 
 @param date 日期
 @return 行数
 */
+ (NSInteger)zh_getMonthRows:(NSDate *)date
{
    NSDate *firstday;
    [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitMonth startDate:&firstday interval:NULL forDate:date];
    NSUInteger cycle =[[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfMonth forDate:firstday];
    NSRange daysOfMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    //该月的行数
    NSInteger shengyu = daysOfMonth.length - (8 - cycle);
    NSInteger row;
    row = shengyu % 7 > 0 ? shengyu/7 + 2 : shengyu/7 + 1;
    return row;
}

/**
 判断某一天与日期是否为同一天
 日期格式: YYYY-MM-DD
 @param dayString  某一天
 @param date 日期
 @return  YES 是同一天; NO 反之
 */
+ (BOOL)zh_checkOneday:(NSString *)dayString
           anotherDate:(NSDate *)date
{
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"YYYY-MM-DD"];
    NSString *string = [formater stringFromDate:date];
    return [dayString isEqualToString:string];
}



/**
 判断两个日期是否为同一天
 
 @param oneDay  一天
 @param anotherDay 另一天
 @return  YES 同一天; NO 反之
 */
+ (BOOL)zh_checkSameDay:(NSDate *)oneDay
            anotherDate:(NSDate *)anotherDay
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit calendarUnit = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents* comp1 = [calendar components:calendarUnit fromDate:oneDay];
    NSDateComponents* comp2 = [calendar components:calendarUnit fromDate:anotherDay];
    BOOL isSame = [comp1 day]   == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
    return isSame;
}



/**
 通过日期,获取当前是周几
 
 @param date 日期
 @return 周数(1-7  ->  日-六)
 */
+ (NSInteger)zh_getNumberInWeek:(NSDate *)date
{
    NSUInteger number =[[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfMonth forDate:date];
    return number;
}




/**
 获取指定日期所在月的全部天数
 
 @param date  日期
 @return  总天数
 */
+ (NSInteger)zh_getCurrentMonthAllDay:(NSDate *)date
{
    NSRange totaldaysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return totaldaysInMonth.length;
}

/**
 判断两个日期是否为同月
 
 @param oneDate  日期
 @param anotherDate 另一个日期
 @return  YES, 同月;NO, 反之
 */
+ (BOOL)zh_checkSameMonth:(NSDate *)oneDate
              anotherMoth:(NSDate *)anotherDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents * oneMonth = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:oneDate];
    NSDateComponents* onotherMonth = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:anotherDate];
    if ((oneMonth.year == onotherMonth.year)
        && (oneMonth.month == onotherMonth.month)){
        return  YES;
    }
    return NO;
}


#pragma mark   将时间 解析成  刚刚、几分钟前、几小时前、昨天 、日期 (时间格式:2017-01-01 21:05:10)
+ (NSString *)zh_getEasyDateWithDate:(NSString *) time{
    
    //  把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *timeDate = [dateFormatter dateFromString:time];
    //  得到与当前时间差
    NSTimeInterval timeInterval = -[timeDate timeIntervalSinceNow];
    if (timeInterval <60) {  //  60s以内的显示   刚刚
        return @"刚刚";
    } else if (timeInterval/60 < 60){   //  1小时以内的显示xx分钟前
        return [NSString stringWithFormat:@"%.0f 分钟前",timeInterval/60];
    } else if (timeInterval/3600 >= 1 && timeInterval/3600 <24){    //  一天以内显示xx小时前
        return [NSString stringWithFormat:@"%.0f 小时前",timeInterval/3600];
    } else if (timeInterval/3600 >= 24 && timeInterval/3600 < 48){  //  超过24小时
        return  [NSString stringWithFormat:@"昨天"];
    } else if (timeInterval/3600/24 >= 1 && timeInterval/3600/24 < 365){  //  超过一天
        return  [NSString stringWithFormat:@"%.0f天前", timeInterval/3600/24];
    }
    NSInteger length = time.length > 10 ? 10 : time.length;
    return [time substringWithRange:NSMakeRange(0, length)];
}

@end
