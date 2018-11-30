//
//  ZHEmptyView.h
//  ZHCommonKit
//
//  Created by Mac on 2018/11/29.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZHEmptyView;

typedef void (^ButtonPressBlock)(ZHEmptyView *emptyView);
@protocol ZHEmptyViewDelegate <NSObject>

@optional
-(void)ZHEmptyViewClickEmptyAction:(UIButton *)sender;

@end

@interface ZHEmptyView : UIView

@property(nonatomic,strong)UIImageView* imageView;;
@property(nonatomic,strong)UILabel* titleLabel;
@property(nonatomic,strong)UILabel* detailLabel;
@property(nonatomic,strong)UIButton* button;
@property(nonatomic,copy)ButtonPressBlock buttonPressBolck;
@property(nonatomic,weak) id <ZHEmptyViewDelegate> delegate;

/**
 自定义空视图

 带按钮响应
 @param imageNameStr imageNameStr description
 @param titleStr titleStr description
 @param detailStr detailStr description
 @param buttonTitleStr buttonTitleStr description
 @param buttonPressBlock buttonPressBlock description
 @return return value description
 */
+(instancetype)emptyViewWithImageNameStr:(nullable NSString *) imageNameStr
                                titleStr:(nullable NSString *)titleStr
                               detailStr:(nullable NSString *)detailStr
                          buttonTitleStr:(nullable NSString *)buttonTitleStr
                        buttonPressBlock:(nullable ButtonPressBlock)buttonPressBlock;


/**
 自定义空视图

 @param imageNameStr imageNameStr description
 @param titleStr titleStr description
 @param detailStr detailStr description
 @return return value description
 */
+(instancetype)emptyViewWithImageNameStr:(nullable NSString*)imageNameStr
                                titleStr:(nullable NSString*)titleStr
                               detailStr:(nullable NSString*)detailStr;


/**
 没有数据

 @param buttonPressBlock buttonPressBlock description
 @return return value description
 */
+(instancetype)emptyNoDataButtonPressBlock:(ButtonPressBlock)buttonPressBlock;


/**
 没有网络

 @param buttonPressBlock buttonPressBlock description
 @return return value description
 */
+(instancetype)emptyNoNetworkButtonPressBlock:(ButtonPressBlock)buttonPressBlock;


/**
 加载失败

 @param buttonPressBlock buttonPressBlock description
 @return return value description
 */
+(instancetype)emptyLoadFailButtonPressBlock:(ButtonPressBlock)buttonPressBlock;


@end

NS_ASSUME_NONNULL_END
