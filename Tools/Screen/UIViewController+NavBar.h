//
//  UIViewController+NavBar.h
//  air_bike
//
//  Created by Damo on 16/12/6.
//  Copyright © 2016年 Damo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (NavBar)

@property UIButton *nvLeftBtn;    //导航栏左侧按钮
@property UIButton *nvRightBtn;  //导航栏右侧按钮
@property void (^leftBlock)();       //左侧点击事件
@property void (^rightBlock)();     //右侧点击事件

//设置左右普通和高亮状态的图片
- (void)setupNavigationItemWithLeftImages:(NSArray *)leftImgs rightimages:(NSArray *)rightImgs;

//设置左右图片和左右点击事件
- (void)setupNavigationItemWithLeftImages:(NSArray *)leftImgs
                                        leftBlock:(void(^)())leftBlock
                                      rightimages:(NSArray *)rightImgs
                                       rightBlock:(void(^)())rightBlock;

//设置左右文字及点击事件
- (void)setupNavigationLeftItemWithTitle:(NSString *)leftTitle
                               leftBlock:(void (^)())block
                              rightTitle:(NSString *)rightTitle
                              rightBlock:(void(^)())rightBlock;

//设置左侧文字
- (void)setupNavigatonLeftItemWithTitle:(NSString *)title;

//设置左侧文字及点击事件
- (void)setupNavigatonLeftItemWithTitle:(NSString *)title block:(void(^)())block;

//设置左侧为空
- (void)setupNavigationLeftItemNil;

//设置右侧文字
- (void)setupNavigationRightItemWithTitle:(NSString *)title;

//设置右侧文字及点击事件
- (void)setupNavigationRightItemWithTitle:(NSString *)title block:(void(^)())block;

//设置右侧文字及字号
- (void)setupNavigationRightItemWithTitle:(NSString *)title font:(CGFloat)font;

//设置右侧图片
- (void)setupNavigationRightItemWithImage:(NSArray <NSString *>*)imgNameArr;

//设置右侧图片及点击事件
- (void)setupNavigationRightItemWithImage:(NSArray <NSString *>*)imgNameArr block:(void(^)())block;

//设置标题
- (void)setupTitleViewWithImage:(NSString *)image frame:(CGRect)rect;

- (void)setupTitleViewWithImage:(NSString *)image;

- (void)setupTitleWithText:(NSString *)text;

//消除阴影
- (void)removeShadow;

//恢复阴影
- (void)recoverShadow;
@end
