//
//  UILabel+Extension.m
//  air_bike
//
//  Created by Damo on 16/12/13.
//  Copyright © 2016年 Damo. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

+ (instancetype)labelWithText:(NSString *)string font:(CGFloat)font color:(UIColor *)color rect:(CGRect)rect {
    UILabel *label = [[UILabel alloc ] initWithFrame:rect];
    label.text = string;
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:font];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

@end
