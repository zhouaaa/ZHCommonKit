//
//  UITextField+ZHHistory.h
//  ZHCommonKit
//
//  Created by Mac on 2018/11/16.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, JKShakedDirection) {
    JKShakedDirectionHorizontal,
    JKShakedDirectionVertical
};


@interface UITextField (ZHHistory)

/**
 *  identity of this textfield
 */
@property (retain, nonatomic) NSString *jk_identify;

/**
 *  load textfiled input history
 *
 *  @param identify identity of this textfield
 *
 *  @return the history of it's input
 */
- (NSArray*)jk_loadHistroy;

/**
 *  save current input text
 */
- (void)jk_synchronize;

- (void)jk_showHistory;
- (void)jk_hideHistroy;

- (void)jk_clearHistory;


//===============================

/**-----------------------------------------------------------------------------
 * @name UITextField+Shake
 * -----------------------------------------------------------------------------
 */

/** Shake the UITextField
 *
 * Shake the text field with default values
 */
- (void)jk_shake;

/** Shake the UITextField
 *
 * Shake the text field a given number of times
 *
 * @param times The number of shakes
 * @param delta The width of the shake
 */
- (void)jk_shake:(int)times withDelta:(CGFloat)delta;

/** Shake the UITextField
 *
 * Shake the text field a given number of times
 *
 * @param times The number of shakes
 * @param delta The width of the shake
 * @param handler A block object to be executed when the shake sequence ends
 */
- (void)jk_shake:(int)times withDelta:(CGFloat)delta completion:(nullable void((^)()))handler;

/** Shake the UITextField at a custom speed
 *
 * Shake the text field a given number of times with a given speed
 *
 * @param times The number of shakes
 * @param delta The width of the shake
 * @param interval The duration of one shake
 */
- (void)jk_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval;

/** Shake the UITextField at a custom speed
 *
 * Shake the text field a given number of times with a given speed
 *
 * @param times The number of shakes
 * @param delta The width of the shake
 * @param interval The duration of one shake
 * @param handler A block object to be executed when the shake sequence ends
 */
- (void)jk_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval completion:(nullable void((^)()))handler;

/** Shake the UITextField at a custom speed
 *
 * Shake the text field a given number of times with a given speed
 *
 * @param times The number of shakes
 * @param delta The width of the shake
 * @param interval The duration of one shake
 * @param direction of the shake
 */
- (void)jk_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(JKShakedDirection)shakeDirection;

/** Shake the UITextField at a custom speed
 *
 * Shake the text field a given number of times with a given speed
 *
 * @param times The number of shakes
 * @param delta The width of the shake
 * @param interval The duration of one shake
 * @param direction of the shake
 * @param handler A block object to be executed when the shake sequence ends
 */
- (void)jk_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(JKShakedDirection)shakeDirection completion:(nullable void((^)()))handler;

@end

NS_ASSUME_NONNULL_END
