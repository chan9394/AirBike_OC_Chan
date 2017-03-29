//
//  UIButton+Color.h
//  AirBk
//
//  Created by Damo on 2017/1/6.
//  Copyright © 2017年 ZHH. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ButtonType) {
    ButtonTypeNormal = 1,
    ButtonTypeHighLighted,
    ButtonTypeDisabled,
};

@interface UIButton (Color)

@property ButtonType type;

@property NSNumber *status;  //1代表普通,0代表禁用,2代表高亮

@property UIColor *normalColor; //普通状态的颜色

@property UIColor *highLightedColor;    //高亮颜色

@property UIColor *disabledColor;       //禁用颜色

//设置button不同状态下 的颜色
- (void)setupNormalColor:(UIColor *)normal highLightedColor:(UIColor *)highLighted disabledColor:(UIColor *)disabled;

//高亮.抬起,外面抬起的不同颜色
- (void)setupStatusBackgroundColor;

//高亮时和外面抬起的颜色
- (void)setupHightLightedAndOutsidebackGroundColor;
@end
