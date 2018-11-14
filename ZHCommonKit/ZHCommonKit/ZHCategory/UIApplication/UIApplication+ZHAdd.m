//
//  UIApplication+ZHAdd.m
//  ZHToolsDemo
//
//  Created by Mac on 2018/11/9.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import "UIApplication+ZHAdd.h"
#import "NSBundle+ZHAdd.h"

#import <CoreLocation/CoreLocation.h>
#import <EventKit/EventKit.h>
#import <Photos/Photos.h>
#import <Contacts/Contacts.h>
#import <AddressBook/AddressBook.h>


@implementation UIApplication (ZHAdd)

- (NSURL *)documentsURL {
    
    return [[[NSFileManager defaultManager]
             URLsForDirectory:NSLibraryDirectory
             inDomains:NSUserDomainMask] lastObject];
}

- (NSString *)documentsPath {
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
}

- (NSURL *)cachesURL {
    return [[[NSFileManager defaultManager]
             URLsForDirectory:NSCachesDirectory
             inDomains:NSUserDomainMask] lastObject];
}

- (NSString *)cachesPath {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
}

- (NSURL *)libraryURL {
    return [[[NSFileManager defaultManager]
             URLsForDirectory:NSLibraryDirectory
             inDomains:NSUserDomainMask] lastObject];
}

- (NSString *)libraryPath {
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
}

- (NSString *)appBundleName {
    return [NSBundle zh_getAppBundleName];
}

- (NSString *)appDisplayName{
    return [NSBundle zh_getBundleDisplayName];
}

- (NSString *)appBundleID {
    return [NSBundle zh_getBundleIdentifier];
}

- (NSString *)appVersion {
    return [NSBundle zh_getBundleShortVersionString];
}

- (NSString *)appBuildVersion {
    return [NSBundle zh_getBundleVersion];
}

- (BOOL)isGetLocationPermit{
    BOOL authorizedAlways = [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways;
    BOOL authorizedWhenInUse = [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse;
    
    if (authorizedAlways || authorizedWhenInUse) {
        return YES;
    }
    return NO;
}

- (BOOL)isGetCameraPermit{
    BOOL camerPermit = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent] == EKAuthorizationStatusAuthorized;
    return camerPermit;
}

- (BOOL)isGetPhotosLibraryPermit{
    BOOL phontosPetmit = [PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusAuthorized;
    return phontosPetmit;
}

- (BOOL)isGetReminderPermit{
    BOOL ReminderPermit = [EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder] == EKAuthorizationStatusAuthorized;
    return ReminderPermit;
}

- (BOOL)isGetAddressBookPermit{
    if (@available(iOS 9.0, *)) {
        
        BOOL addressBookPermit = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusAuthorized;
        return addressBookPermit;
        
    } else {
        
        BOOL addressBookPermit = ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized;
        return addressBookPermit;
    }
}


@end
