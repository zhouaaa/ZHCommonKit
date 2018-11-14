//
//  NSData+ZHAdd.m
//  ZHToolsDemo
//
//  Created by Mac on 2018/11/9.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import "NSData+ZHAdd.h"

@implementation NSData (ZHAdd)

-(NSString *)utf8String{
    if (self.length > 0) {
        return [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
    }
    return @"";
}

- (id)zh_jsonValueDecoded{
    NSError *error = nil;
    id value = [NSJSONSerialization JSONObjectWithData:self options:kNilOptions error:&error];
    if (error) {
        NSLog(@"jsonValueDecoded error:%@", error);
    }
    return value;
}

+ (NSData *)zh_changeDataFromImage:(UIImage *)image compressionRatio:(CGFloat)ratio{
    NSData * data = UIImageJPEGRepresentation(image, ratio);
    
    CGFloat dataKBytes =  data.length / 1000.0;
    CGFloat maxQuality = 0.9f;
    CGFloat lastData   =  dataKBytes;
    
    while (dataKBytes > ratio &&  maxQuality > 0.01f) {
        
        maxQuality =  maxQuality - 0.01f;
        
        data = UIImageJPEGRepresentation(image,  maxQuality);
        
        dataKBytes =  data.length / 1000.0;
        
        if ( lastData ==  dataKBytes) {
            
            break;
            
        } else {
            
            lastData =  dataKBytes;
        }
    }
    
    return  data;
}


@end
