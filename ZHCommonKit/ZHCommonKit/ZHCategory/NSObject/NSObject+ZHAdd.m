//
//  NSObject+ZHAdd.m
//  ZHToolsDemo
//
//  Created by Mac on 2018/11/9.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import "NSObject+ZHAdd.h"

@interface MObserverHelper : NSObject

@property (nonatomic, unsafe_unretained) id target;

@property (nonatomic, unsafe_unretained) id observer;

@property (nonatomic, strong) NSString *keyPath;

@property (nonatomic, weak) MObserverHelper *factor;

@end

@implementation MObserverHelper

- (void)dealloc {
    if ( _factor ) {
        
        [_target removeObserver:_observer forKeyPath:_keyPath];
        
    }
}

@end

//====================================

@implementation NSObject (ZHAdd)

- (void)zh_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath{
    
    [self addObserver:observer forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:nil];
    
    MObserverHelper *helper = [MObserverHelper new];
    
    MObserverHelper *sub = [MObserverHelper new];
    
    sub.target = helper.target = self;
    
    sub.observer = helper.observer = observer;
    
    sub.keyPath = helper.keyPath = keyPath;
    
    helper.factor = sub;
    
    sub.factor = helper;
    
    const char *helpeKey = [NSString stringWithFormat:@"%zd", [observer hash]].UTF8String;
    
    objc_setAssociatedObject(self, helpeKey, helper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(observer, helpeKey, sub, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)zh_addInstanceMethonWithOriginalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector{
    Class class = self.class;
    Method zh_swizzledSelector = class_getInstanceMethod(class, swizzledSelector);
    BOOL isAddMethon = class_addMethod(class, originalSelector, class_getMethodImplementation(class, swizzledSelector), method_getTypeEncoding(zh_swizzledSelector));
    return isAddMethon;
    
}

- (void)zh_exchangeInstanceWithOriginalSelector:(SEL)originalSelector swizzledSelecor:(SEL)swizzledSelector{
    Class class = self.class;
    Method zh_originalSelect = class_getInstanceMethod(class, originalSelector);
    Method zh_swizzledSelect = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL isAddMethod = [self zh_addInstanceMethonWithOriginalSelector:originalSelector swizzledSelector:swizzledSelector];
    if (isAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(zh_originalSelect), method_getTypeEncoding(zh_originalSelect));
    }else{
        method_exchangeImplementations(zh_originalSelect, zh_swizzledSelect);
    }
}

- (NSArray <NSString *> *)zh_getClassMethodList{
    Class class = self.class;
    
    NSMutableArray *selectMethodList = [NSMutableArray array];
    
    const char *className = class_getName(class);
    
    Class metaClass = objc_getMetaClass(className);
    
    unsigned int methodCount = 0;
    
    Method *methodList = class_copyMethodList(metaClass, &methodCount);
    
    for (int i = 0; i < methodCount; i++) {
        
        Method method = methodList[i];
        
        SEL selector = method_getName(method);
        
        const char *charMethodName = sel_getName(selector);
        
        NSString *methodName = [[NSString alloc]initWithUTF8String:charMethodName];
        
        [selectMethodList addObject:methodName];
    }
    free(methodList);
    return selectMethodList;
}

- (NSArray <NSString *> *)zh_getClassPropertyList{
    Class class = self.class;
    NSMutableArray *propertArray = [NSMutableArray array];
    unsigned int propertNumber = 0;
    objc_property_t *propertList = class_copyPropertyList(class, &propertNumber);
    for (int i = 0; i < propertNumber; i++) {
        objc_property_t propert = propertList[i];
        const char *propertChar = property_getName(propert);
        NSString *propertName = [[NSString alloc]initWithCString:propertChar encoding:NSUTF8StringEncoding];
        [propertArray addObject:propertName];
    }
    free(propertList);
    
    return propertArray;
}

- (NSArray <NSString *> *)zh_getClassProtocolList{
    Class class = self.class;
    NSMutableArray *protocolArray = [NSMutableArray array];
    unsigned int protocolCount = 0;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList(class, &protocolCount);
    
    for (int i = 0 ; i < protocolCount; i++) {
        Protocol *protocol = protocolList[i];
        const char *protocolChar = property_getName((__bridge objc_property_t _Nonnull)(protocol));
        NSString *protocolName = [[NSString alloc]initWithCString:protocolChar encoding:NSUTF8StringEncoding];
        [protocolArray addObject:protocolName];
        
    }
    free(protocolList);
    
    return protocolArray;
}

- (NSArray <NSString *> *)zh_getClassIVarList{
    Class class = self.class;
    NSMutableArray *ivarArray = [NSMutableArray array];
    unsigned int ivarCount = 0;
    Ivar *ivarList = class_copyIvarList(class, &ivarCount);
    for (int i = 0; i < ivarCount; i++) {
        Ivar ivar = ivarList[i];
        const char *ivarChar = ivar_getName(ivar);
        NSString *ivarName = [[NSString alloc]initWithCString:ivarChar encoding:NSUTF8StringEncoding];
        [ivarArray addObject:ivarName];
    }
    free(ivarList);
    
    return ivarArray;
}

- (BOOL)zh_hasPropertyWithKey:(NSString *)key{
    objc_property_t property = class_getProperty([self class], [key UTF8String]);
    return (BOOL)property;
}

- (BOOL)zh_hasIvarWithKey:(NSString *)key{
    Ivar ivar = class_getInstanceVariable([self class], [key UTF8String]);
    
    return (BOOL)ivar;
}

- (void)zh_globalAsyncWithComplete:(MComplete)complete{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), complete);
}

- (void)zh_getMainAsyncWithComplete:(MComplete)complete{
    dispatch_async(dispatch_get_main_queue(), complete);
}

- (void)zh_afterSecond:(NSTimeInterval)afterSecond complete:(MComplete)complete{
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, afterSecond * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), complete);
}

@end
