//
//  NetRequestCashData.h
//  NetRequestLib
//
//  Created by Mac on 2018/6/26.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHNetRequestCashData : NSObject

+(ZHNetRequestCashData *)shareManager;

-(void)saveData:(id)data page:(NSInteger)page urlString:(nullable NSString*)urlString;

-(id)getDataByUrlString:(NSString*)urlString;

@end
