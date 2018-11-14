//
//  NSString+ZHAdd.m
//  ZHToolsDemo
//
//  Created by Mac on 2018/11/9.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import "NSString+ZHAdd.h"
#import <CommonCrypto/CommonDigest.h>
#include <sys/param.h>//获取手机内存情况
#include <sys/mount.h>


@implementation NSString (ZHAdd)

-(NSURL *)url{
    return [self zh_exchangeURL];
}

-(BOOL)isNull{
    return [self zh_stringIsNullOrEmpty];
}

-(NSRange)rangeAll{
    return [self zh_rangeOfAll];
}

-(NSMutableAttributedString *)attribute{
    return [self zh_exchangeAttribute];
}

-(id)jsonValueDecode{
    return [self zh_jsonValueDecode];
}

#pragma mark - 字符串处理

- (BOOL)zh_stringIsNullOrEmpty{
    NSString *string = self;
    if (string == nil || string == NULL || [string isKindOfClass:[NSNull class]] || [string length] == 0 || [string isEqualToString: @"(null)"]) {
        
        return YES;
    }
    return NO;
}

- (NSRange)zh_rangeOfAll{
    return NSMakeRange(0, self.length);
}

- (BOOL)zh_stringContainsEmoji{
    __block BOOL returnValue = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        
        const unichar hs = [substring characterAtIndex:0];
        
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    returnValue = YES;
                }
            }
        } else if (substring.length > 1) {
            const unichar ls = [substring characterAtIndex:1];
            if (ls == 0x20e3) {
                returnValue = YES;
            }
        } else {
            if (0x2100 <= hs && hs <= 0x27ff) {
                returnValue = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                returnValue = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                returnValue = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                returnValue = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                returnValue = YES;
            }
        }
    }];
    return returnValue;
}

- (UIColor *)zh_colorWithString{
    NSString *cString = [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6){
        return [UIColor clearColor];
    }
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

- (NSURL *)zh_exchangeURL{
    if (self) {
        return [NSURL URLWithString:self];
    }
    return nil;
}

-(NSMutableAttributedString *)zh_exchangeAttribute{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:self];
    return string;
}

- (NSString *)zh_trimmedString{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)zh_removeStringByCharacter:(NSString *)character{
    return [self stringByReplacingOccurrencesOfString:character withString:@""];
}

- (NSString *)zh_removeAllSpace{
    NSString *content = [self zh_trimmedString]; /// 去首尾空格
    NSString *replace = [content stringByReplacingOccurrencesOfString:@" " withString:@""];/// 去全部空格
    return replace;
}

- (NSString *)zh_removeHTMLMark{
    NSString *html = self;
    NSScanner *theScanner = [NSScanner scannerWithString:html];
    NSString *text = nil;
    
    while ([theScanner isAtEnd] == NO){
        
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        [theScanner scanUpToString:@">" intoString:&text] ;
        html = [html stringByReplacingOccurrencesOfString:[ NSString stringWithFormat:@"%@>", text] withString:@""];
        if ([html containsString:@"</p><p>"]) {
            NSString *replace = [html stringByReplacingOccurrencesOfString:@"</p><p>" withString:@"\n"];
            
            html = replace;
        }
        if ([html containsString:@"&nbsp;"]){
            NSString *replace = [html stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
            html = replace;
        }
        if ([html containsString:@"_ueditor_page_break_tag_"]){
            NSString *replace = [html stringByReplacingOccurrencesOfString:@"_ueditor_page_break_tag_" withString:@" "];
            
            html = replace;
        }
    }
    return html;
}

- (CGSize)zh_sizeWithFont:(UIFont *)font size:(CGSize)size model:(NSLineBreakMode)lineBreakMode{
    if ([self zh_stringIsNullOrEmpty]) {
        return CGSizeZero;
    }
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = [NSMutableDictionary new];
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attr context:nil];
        result = rect.size;
    } else {//消除黄色警告
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    return result;
}

- (CGSize)zh_sizeWithFont:(UIFont *)font{
    
    return [self zh_sizeWithFont:font size:CGSizeMake(0, 0) model:NSLineBreakByWordWrapping];
}

- (CGFloat)zh_widthWithFont:(UIFont *)font{
    CGSize size = [self zh_sizeWithFont:font size:CGSizeMake(HUGE, HUGE) model:NSLineBreakByWordWrapping];
    return size.width;
}


- (CGFloat)zh_heightWithFont:(UIFont *)font width:(CGFloat)width{
    CGSize size = [self zh_sizeWithFont:font size:CGSizeMake(width, HUGE) model:NSLineBreakByWordWrapping];
    return size.height;
}


#pragma mark - 字符串加密以及 json 转化

- (NSString *)zh_encodingBase64{
    NSData *stingDate = [self zh_dataUTF_8Value];
    NSString *encodString = [stingDate base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return encodString;
}

- (NSString *)zh_decodeBase64{
    NSData *stringDate = [[NSData alloc]initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString *decodeString = [[NSString alloc]initWithData:stringDate encoding:NSUTF8StringEncoding];
    return decodeString;
}

- (NSString *)zh_encodingMD5{
    if ([self zh_stringIsNullOrEmpty]) {
        return nil;
    }
    const char *value = [self UTF8String];
    unsigned char outPutBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outPutBuffer);
    NSMutableString *outPutString = [[NSMutableString alloc]initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count ++) {
        [outPutString appendFormat:@"%02x",outPutBuffer[count]];
    }
    return outPutString;
}

- (NSData *)zh_dataUTF_8Value{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

- (id)zh_jsonValueDecode{
    NSData *stringData = [self zh_dataUTF_8Value];
    NSError *error = nil;
    id value = [NSJSONSerialization JSONObjectWithData:stringData options:kNilOptions error:&error];
    if (error) {
        NSLog(@"json 字符串转化失败:%@",error);
    }
    return value;
    
}

#pragma mark - 实用工具

+ (double)zh_freeDiskSpace{
    struct statfs buf;
    double freeSpace = -1;
    if (statfs("/var", &buf) >= 0) {
        freeSpace = (double)(buf.f_bsize * buf.f_bavail);
    }
    return (freeSpace/1024/1024/1024.0);
}

- (NSString *)zh_mobileFormatWithsSeparator:(NSString *)separator{
    if ([self zh_checkPhoneNumber]) {
        //是电话号码
        NSString *tempSeparator = @" ";
        if (separator) {
            //如果有输入格式,则根据格式分割
            tempSeparator = separator;
        }
        NSMutableString *value = [[NSMutableString alloc] initWithString:self];
        
        [value insertString:separator
                    atIndex:3];
        [value insertString:separator
                    atIndex:8];
        return value;
        
    }else{
        return self;
    }
}

- (NSString *)zh_hideMiddleStringWithPhoneNumber{
    if ([self zh_checkPhoneNumber]) {
        NSMutableString *phoneNumberString = [NSMutableString stringWithString:self];
        
        NSRange phoneNumberRange = NSMakeRange(3, 4);
        [phoneNumberString replaceCharactersInRange:phoneNumberRange withString:@"****"];
        
        return phoneNumberString;
    }
    return self;
}

- (NSString *)zh_hideMiddleStringWithBankNumber{
    if (self.length > 8) {
        NSMutableString *cardString = [[NSMutableString alloc]initWithString:self];
        NSRange range = NSMakeRange(4, 8);
        [cardString replaceCharactersInRange:range withString:@" **** **** "];
        return cardString;
    }
    return self;
}

- (BOOL)zh_checkChinaMobelPhoneNumber{
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *rules = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    
    return [self zh_regularWithRule:rules];
}

- (BOOL)zh_checkChinaUnicomPhoneNumber {
    
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *rules = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    
    return [self zh_regularWithRule:rules];
}

- (BOOL)zh_checkChinaTelecomPhoneNumber {
    
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *rules = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    
    return [self zh_regularWithRule:rules];
}

- (BOOL)zh_checkPhoneNumber{
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|70)\\d{8}$";
    
    return [self zh_regularWithRule:MOBILE] ||
    [self zh_checkChinaMobelPhoneNumber] ||
    [self zh_checkChinaUnicomPhoneNumber] ||
    [self zh_checkChinaTelecomPhoneNumber];
}

#pragma mark - 密码相关

- (BOOL)zh_isChineseCharacter{
    NSString *rules = @"^[\u4e00-\u9fa5]{0,}$";
    return [self zh_regularWithRule:rules];
}

- (BOOL)zh_isEnglishOrNumbers{
    NSString *rules = @"^[A-Za-z0-9]+$";
    return [self zh_regularWithRule:rules];
}

- (BOOL)zh_stringRangLength:(NSRange)rang{
    NSUInteger start = rang.location;
    NSUInteger end = rang.length;
    NSString *rules = [NSString stringWithFormat:@"^.{%ld,%ld}$", (long)start, (long)end];
    return [self zh_regularWithRule:rules];
}

- (BOOL)zh_isEnglishletter{
    NSString *rules = @"^[A-Za-z]+$";
    return [self zh_regularWithRule:rules];
}

- (BOOL)zh_isLowercase{
    NSString *rules = @"^[a-z]+$";
    return [self zh_regularWithRule:rules];
}

- (BOOL)zh_isCapitals{
    NSString *rules = @"^[A-Z]+$";
    return [self zh_regularWithRule:rules];
}

- (BOOL)zh_isNumbersOrLettersOrLineString{
    NSString *rules = @"^[A-Za-z0-9_]+$";
    return [self zh_regularWithRule:rules];
}

- (BOOL)zh_checkStringIsStrong{
    NSString *rules = @"^\\w*(?=\\w*\\d)(?=\\w*[a-zA-Z])\\w*$";
    
    return [self zh_regularWithRule:rules];
}

- (BOOL)zh_checkPassword{
    NSString *rules = @"^[a-zA-Z]\\w{5,17}$";
    
    return [self zh_regularWithRule:rules];
}

- (BOOL)zh_checkStrongPassword:(NSRange)range{
    NSUInteger shortPassword = range.location;
    NSUInteger longPassword = range.length;
    NSString *rules = [NSString stringWithFormat:@"^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{%ld,%ld}$", (long)shortPassword, (long)longPassword];
    return [self zh_regularWithRule:rules];
}

- (BOOL)zh_checkEmailAddress{
    NSString *rules = @"^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$";
    return [self zh_regularWithRule:rules];
}

- (BOOL)zh_checkURL{
    NSString *rules = @"[a-zA-z]+://[^\\s]*";
    return [self zh_regularWithRule:rules];
}

-(BOOL)zh_checkQQNumber{
    NSString *rules = @"[1-9][0-9]{4}";
    return [self zh_regularWithRule:rules];
}

#pragma mark - 时间戳转时间

-(NSString *)timeStampChangeDateFormat:(NSString *)format{
    if (self.length >= 10) {
        NSTimeInterval interval = [[self substringToIndex:10] doubleValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
        NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
        NSString *tempFormat = @"yyyy-MM-dd HH:mm:ss";
        if (format) {
            tempFormat = format;
        }
        [objDateformat setDateFormat:tempFormat];
        return [objDateformat stringFromDate: date];
    }
    return self;
}

#pragma mark - 通过正则判断结果

- (BOOL)zh_regularWithRule:(NSString *)rule {
    
    if ([self zh_stringIsNullOrEmpty]) {
        return NO;
    }
    
    NSPredicate *stringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", rule];
    
    return [stringPredicate evaluateWithObject:self];
}

-(NSString *)regularExpression:(NSString *)regExpress replaceMent:(NSString *)ment{
    NSString *resultString = self;
    // 创建 NSRegularExpression 对象,匹配 正则表达式
    NSRegularExpression *regExp = [[NSRegularExpression alloc]initWithPattern:regExpress options:NSRegularExpressionCaseInsensitive error:nil];
    resultString = [regExp stringByReplacingMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length) withTemplate:ment];
    return resultString;
}


@end
