//
//  UIButton+BackImage.h
//  air_bike
//
//  Created by Damo on 16/12/7.
//  Copyright © 2016年 Damo. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIButton (BackImage)

//根据颜色设置背景图片
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

//根据颜色设置图片
- (void)setImageWithColor:(UIColor *)color  forState:(UIControlState)state;

//切圆角
- (void)setCornerRadius;

- (void)setCornerRadiusWithRadius:(CGFloat)radius;

+ (void)setCornerRadiusWithViews:(NSArray <UIButton *>*)views Radius:(CGFloat)radius;

+ (void)setCornerRadiusWithViews:(NSArray <UIButton *>*)views
                          Radius:(CGFloat)radius
                     BorderColor:(UIColor *)borderColor;


@end
