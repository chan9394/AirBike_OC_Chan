//
//  UIView+Extension.m
//  AirBk
//
//  Created by Damo on 16/12/30.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)setCornerRadiusWithRadius:(CGFloat)radius {
    self.layer.cornerRadius = radius;
    [self.layer masksToBounds];
}

+ (void)setCornerRadiusWithViews:(NSArray<UIView *> *)views Radius:(CGFloat)radius {
    [views enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setCornerRadiusWithRadius:radius];
    }];
}

+ (void)setCornerRadiusWithViews:(NSArray <UIView *>*)views
                          Radius:(CGFloat)radius
                     BorderColor:(UIColor *)borderColor{
    [views enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setCornerRadiusWithRadius:radius];
        if (borderColor) {
            obj.layer.borderColor = borderColor.CGColor;
            obj.layer.borderWidth = 1.0f;
        }
    }];
}
@end
