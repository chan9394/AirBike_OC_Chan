//
//  UIButton+Color.m
//  AirBk
//
//  Created by Damo on 2017/1/6.
//  Copyright © 2017年 ZHH. All rights reserved.
//

#import "UIButton+Color.h"
#import <objc/runtime.h>
@implementation UIButton (Color)

- (void)setType:(ButtonType)type {
    NSNumber *num = @1;
    if (type == ButtonTypeHighLighted) {
        num = @2;
    } else if (type == ButtonTypeDisabled) {
        num = @0;
    }
    [self setStatus:num];
}

- (ButtonType)type {
    ButtonType type = ButtonTypeNormal;
    if ([self.status isEqual:@2]) {
        type = ButtonTypeHighLighted;
    } else if ([self.status isEqual:@0]) {
        type = ButtonTypeDisabled;
    }
    return type;
}

- (void)setStatus:(NSNumber *)status {
    if (status.intValue == 1) {
        if (self.normalColor) {
            self.backgroundColor = self.normalColor;
        } else {
            self.backgroundColor = GLOBAL_ASSISTCOLOR;
        }
        self.enabled = YES;
    } else if (status.intValue == 0) {
        if (self.disabledColor) {
            self.backgroundColor = self.disabledColor;
        } else {
            self.backgroundColor = [UIColor lightGrayColor];
        }
        self.enabled = NO;
    } else if (status.intValue == 2) {
        if (self.highLightedColor) {
            self.backgroundColor = self.highLightedColor;
        } else {
            self.backgroundColor = [UIColor colorWithRed:224.0 / 255 green:113.0 /255 blue:113.0 / 255 alpha:1];
        }
        self.enabled = YES;
    }
    objc_setAssociatedObject(self, @"status", status, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)status {
    return objc_getAssociatedObject(self, @"status");
}

- (void)setupNormalColor:(UIColor *)normal highLightedColor:(UIColor *)highLighted disabledColor:(UIColor *)disabled {
    self.normalColor = normal;
    self.highLightedColor = highLighted;
    self.disabledColor = disabled;
    [self setupStatusBackgroundColor];
    
    if (self.status) {
        self.status = self.status;
    }
}

- (void)setupStatusBackgroundColor {
    [self addTarget:self action:@selector(hightLighted) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(normal) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(normal) forControlEvents:UIControlEventTouchUpOutside];
}

- (void)setupHightLightedAndOutsidebackGroundColor {
    [self addTarget:self action:@selector(hightLighted) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(normal) forControlEvents:UIControlEventTouchUpOutside];
}

- (void)hightLighted {
    self.status = @2;
}

- (void)normal {
    self.status = @1;
}

- (void)setNormalColor:(UIColor *)normalColor {
    objc_setAssociatedObject(self, @"normalColor", normalColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)normalColor {
    return objc_getAssociatedObject(self, @"normalColor");
}

- (void)setHighLightedColor:(UIColor *)highLightedColor {
     objc_setAssociatedObject(self, @"highLightedColor", highLightedColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)highLightedColor {
        return objc_getAssociatedObject(self, @"highLightedColor");
}

- (void)setDisabledColor:(UIColor *)disabledColor {
    objc_setAssociatedObject(self, @"disabledColor", disabledColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)disabledColor {
    return objc_getAssociatedObject(self, @"disabledColor");
}
@end
