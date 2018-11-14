
//
//  ZHDefineLayout.h
//  ZHToolsDemo
//
//  Created by Mac on 2018/11/12.
//  Copyright © 2018年 周辉. All rights reserved.
//

//====================================== 1  系统 =================================
/**
 判断机型

 @param  手机机型判断
 @return return value description
 */

//判断是否为iPhone
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

//判断是否为iPad
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//判断是否为ipod
#define IS_IPOD ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])

//获取当前语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//====================================== 2 UI元素 =================================
/**
 屏幕的宽度

 @param bounds].size.width bounds].size.width description
 @return return value description
 */
#define kScreenWidth            ([[UIScreen mainScreen] bounds].size.width)


/**
 屏幕的高度

 @param bounds].size.height bounds].size.height description
 @return return value description
 */
#define kScreenHeight            ([[UIScreen mainScreen] bounds].size.height)


/**适配 iPhone X TabBar和导航区别
 
 * Top区别:iPhone X 为例    :导航(44 points)+状态栏(44 points)= 88 points
 
 * Iphone 6s为例           :导航(44 points)+状态栏(20 points)= 64 points
 
 * Bottom区别:iPhone X 为例 : 83 points高度(TabBar) = Danger Area(34 points) + 原来的49 points
 
 * Iphone 6s为例           :49 points高度(TabBar) = 49 points
 
 */

//iPhoneX / iPhoneXS
#define  isIphoneX_XS    (kScreenWidth ==375.f&& kScreenHeight ==812.f? YES : NO)

//iPhoneXR / iPhoneXSMax
#define  isIphoneXR_XSMax    (kScreenWidth ==414.f&& kScreenHeight ==896.f? YES : NO)

//是否是异性全面屏
#define  isFullScreen    (isIphoneX_XS || isIphoneXR_XSMax)

//状态栏高度
#define  StatusBarHeight    (isFullScreen ?44.f:20.f)
//导航栏高度
#define  NavigationBarHeight  44.f
//底部 TabBar的高度
#define  TabbarHeight        (isFullScreen ? (49.f+34.f) :49.f)
//底部安全区高度
#define  TabbarSafeBottomHeight        (isFullScreen ?34.f:0.f)
//顶部状态栏加导航栏高度
#define  StatusBarAndNavigationBarHeight  (isFullScreen ?88.f:64.f)


//====================================== 3 颜色类 =================================

//带有RGBA的颜色设置
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

//设置随机颜色(调试时候很有用)
#define RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

//16进制颜色
#define RGB16Color(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//====================================== 4 通知 =================================

//获取通知中心
#define NotificationCenter [NSNotificationCenter defaultCenter]

//快速发通知
#define Post_Notify(_notificationName, _obj, _userInfoDictionary) [[NSNotificationCenter defaultCenter] postNotificationName: _notificationName object: _obj userInfo: _userInfoDictionary];

//添加观察者
#define Add_Observer(_notificationName, _observer, _observerSelector, _obj) [[NSNotificationCenter defaultCenter] addObserver:_observer selector:@selector(_observerSelector) name:_notificationName object: _obj];

//移除观察者
#define Remove_Observer(_observer) [[NSNotificationCenter defaultCenter] removeObserver: _observer];


//================================= 5 数据存储【沙盒】 =============================
//NSUserDefaults 实例化
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

//获取temp
#define kPathTemp NSTemporaryDirectory()

//获取沙盒Document
#define kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) firstObject]

//获取沙盒Cache
#define kPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) firstObject]



//================================= 6 单例模式 =================================

#define SingleH(name) +(instancetype)share##name;

#if __has_feature(objc_arc)
//条件满足 ARC
#define SingleM(name) static id _instance;\
+(instancetype)allocWithZone:(struct _NSZone *)zone\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
\
return _instance;\
}\
\
+(instancetype)share##name\
{\
return [[self alloc]init];\
}\
\
-(id)copyWithZone:(NSZone *)zone\
{\
return _instance;\
}\
\
-(id)mutableCopyWithZone:(NSZone *)zone\
{\
return _instance;\
}

#else
//MRC
#define SingleM(name) static id _instance;\
+(instancetype)allocWithZone:(struct _NSZone *)zone\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
\
return _instance;\
}\
\
+(instancetype)share##name\
{\
return [[self alloc]init];\
}\
\
-(id)copyWithZone:(NSZone *)zone\
{\
return _instance;\
}\
\
-(id)mutableCopyWithZone:(NSZone *)zone\
{\
return _instance;\
}\
-(oneway void)release\
{\
}\
\
-(instancetype)retain\
{\
return _instance;\
}\
\
-(NSUInteger)retainCount\
{\
return MAXFLOAT;\
}
#endif

//================================= 7 Block 引用 =================================

//弱引用
#define WeakWithNameAndObject(obj,name) __weak typeof(obj) weak##name = obj
//强引用
#define StrongWithNameAndObject(obj,name) __strong typeof(obj) strong##name = obj


//================================= 8 空 判断 =================================

/**是否为空或是[NSNull null]  */
#define NotNilAndNull(_ref)  (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]))
#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]])

//字符串是否为空
/**是否为空或是[NSNull null] */
#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))

/** 数组是否为空 */
#define IsArrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref) count] == 0))

/** 字典是否为空 **/
#define IsSDictEmpty(_ref)      (_ref == nil || [_ref isKindOfClass:[NSNull class]] || _ref.allKeys == 0)

/** 便捷创建NSString */
#undef  STR_FROM_INT
#define STR_FROM_INT( __x )     [NSString stringWithFormat:@"%d", (__x)]

/** 去掉首尾空格和换行符 */
#define FirstAndLastSpace(str) [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]

/**去掉所有空格*/
#define RemoveAllSpaces(str) [str stringByReplacingOccurrencesOfString:@" " withString:@""]

/**  图片名字 **/
#define IMAGENAME(a) [UIImage imageNamed:a]

/**  字体大小 **/
#define FONT(a) [UIFont systemFontOfSize:a]

