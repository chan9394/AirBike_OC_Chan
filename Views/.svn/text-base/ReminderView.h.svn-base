//
//  ReminderView.h
//  AirBk
//
//  Created by Damo on 16/12/28.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ReminderView;

@protocol ReminderViewDelegate <NSObject>

@optional
//点击弹框左边按钮
- (void)reminderViewDidClickLeftBtn;

- (void)reminderViewDidClickRightBtn;
@end

@interface ReminderView : UIView

@property (nonatomic, weak) id <ReminderViewDelegate> delegate;

//弹框的标题,按钮的左右标题
+ (instancetype)reminderViewWithMessage:(NSString *)message
                           leftBtnTitle:(NSString *)leftTitle
                          rightBtnTitle:(NSString *)rightTitle;
//弹框的上下标题,按钮的左右标题
+ (instancetype)reminderViewWithMessage:(NSString *)message
                                  title:(NSString *)title
                                 detail:(NSString *)detail
                           leftBtnTitle:(NSString *)leftTitle
                 leftBtnBackgroundColor:(UIColor *)leftColor
                          rightBtnTitle:(NSString *)rightTitle;

//弹框的上下标题,按钮的左右标题及点击事件
+ (instancetype)reminderViewWithtitle:(NSString *)title
                                 detail:(NSString *)detail
                           leftBtnTitle:(NSString *)leftTitle
                 leftBtnBackgroundColor:(UIColor *)leftColor
                            leftBlock:(void(^)())leftBlock
                          rightBtnTitle:(NSString *)rightTitle
                           rightBlock:(void(^)())rightBlock;
//单个按钮
+ (instancetype)reminderViewWithMessage:(NSString *)message btnTitle:(NSString *)title;

//带图片弹框
+(instancetype)reminderViewWithtitle:(NSString *)title
                          titleColor:(UIColor *)titleColor
                              detail:(NSString *)detail
                           imageName:(NSString *)imageName
                        leftBtnTitle:(NSString *)leftBtnTitle
                        leftBtnColor:(UIColor *)leftColor
                           leftBlock:(void(^)())leftBlock
                       rightBtnTitle:(NSString *)rightBtnTitle
                       rightBtnColor:(UIColor *)rightColor
                          rightBlock:(void(^)())rightBlock;

@end
