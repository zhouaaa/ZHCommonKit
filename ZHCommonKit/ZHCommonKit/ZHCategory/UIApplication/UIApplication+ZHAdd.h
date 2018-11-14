//
//  UIApplication+ZHAdd.h
//  ZHToolsDemo
//
//  Created by Mac on 2018/11/9.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (ZHAdd)

/** 沙盒 documents URL*/
@property (nonatomic, readonly,nullable) NSURL *documentsURL;
/** 沙盒 documents Path*/
@property (nonatomic, readonly,nullable) NSString *documentsPath;
/** 沙盒 Caches URL*/
@property (nonatomic, readonly,nullable) NSURL *cachesURL;
/** 沙盒 Caches Path*/
@property (nonatomic, readonly,nullable) NSString *cachesPath;

/** 沙盒 Library URL*/
@property (nonatomic, readonly,nullable) NSURL *libraryURL;
/** 沙盒 Library Path*/
@property (nonatomic, readonly,nullable) NSString *libraryPath;

/** 编译app 名*/
@property (nullable, nonatomic, readonly) NSString *appBundleName;
/** 应用名*/
@property (nullable, nonatomic, readonly) NSString *appDisplayName;

/** 工程BundleID e.g com.****.****/
@property (nullable, nonatomic, readonly) NSString *appBundleID;

/** APP版本号 e.g "1.2.0"*/
@property (nullable, nonatomic, readonly) NSString *appVersion;

/** APP 编译版本号 e.g 1234*/
@property (nullable, nonatomic, readonly) NSString *appBuildVersion;

/**获取UIApplication的定位是否授权*/
@property (nonatomic, assign,readonly) BOOL isGetLocationPermit;

/**获取UIApplication的相机是否授权*/
@property (nonatomic, assign,readonly) BOOL isGetCameraPermit;

/**获取UIApplication的相册是否授权*/
@property (nonatomic, assign,readonly) BOOL isGetPhotosLibraryPermit;

/**获取UIApplication的推送功能是否授权*/
@property (nonatomic, assign,readonly) BOOL isGetReminderPermit;

/**获取UIApplication的通信录是否授权*/
@property (nonatomic, assign,readonly) BOOL isGetAddressBookPermit;



@end

NS_ASSUME_NONNULL_END
