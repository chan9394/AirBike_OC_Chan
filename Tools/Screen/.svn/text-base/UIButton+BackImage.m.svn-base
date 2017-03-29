//
//  UIButton+BackImage.m
//  air_bike
//
//  Created by Damo on 16/12/7.
//  Copyright © 2016年 Damo. All rights reserved.
//

#import "UIButton+BackImage.h"

@implementation UIButton (BackImage)

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    [self setBackgroundImage:[UIButton imageFromColor:backgroundColor] forState:state];
}

- (void)setImageWithColor:(UIColor *)color  forState:(UIControlState)state {
    [self setImage:[UIButton imageFromColor:color] forState:state];
}

+ (UIImage *)imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1,1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)setCornerRadius {
    [self setCornerRadiusWithRadius:GLOBAL_V(22)];
}

- (void)setCornerRadiusWithRadius:(CGFloat)radius {
    self.layer.cornerRadius = radius;
    [self.layer masksToBounds];
}

+ (void)setCornerRadiusWithViews:(NSArray<UIButton *> *)views Radius:(CGFloat)radius {
    [views enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setCornerRadiusWithRadius:radius];
    }];
}

+ (void)setCornerRadiusWithViews:(NSArray <UIButton *>*)views
                          Radius:(CGFloat)radius
                     BorderColor:(UIColor *)borderColor{
    [views enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setCornerRadiusWithRadius:radius];
        if (borderColor) {
            obj.layer.borderColor = borderColor.CGColor;
            obj.layer.borderWidth = 1.0f;
        }
    }];
}


@end
