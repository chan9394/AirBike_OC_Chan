//
//  UIView+Frame.m
//  air_bike
//
//  Created by Damo on 16/12/7.
//  Copyright © 2016年 Damo. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x {
    CGPoint origin = self.frame.origin;
    CGRect rect = CGRectMake(x, origin.y, self.frame.size.width, self.frame.size.height);
    self.frame = rect;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y {
    CGPoint origin = self.frame.origin;
    CGRect rect = CGRectMake(origin.x, y, self.frame.size.width, self.frame.size.height);
    self.frame = rect;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (CGFloat)width {
    return self.bounds.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGSize size = CGSizeMake(width, self.frame.size.height);
    self.frame = CGRectMake(self.x, self.y, size.width, size.height);
}

- (CGFloat)height {
    return self.bounds.size.width;
}

- (void)setHeight:(CGFloat)height {
    CGSize size = CGSizeMake(self.width, height);
    self.frame = CGRectMake(self.x, self.y, size.width, size.height);
}

- (void)setSize:(CGSize)size
{
    
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}
@end
