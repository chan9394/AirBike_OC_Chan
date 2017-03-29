//
//  UIView+Frame.h
//  air_bike
//
//  Created by Damo on 16/12/7.
//  Copyright © 2016年 Damo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property (nonatomic, assign) CGFloat x;

/**
 坐标y
 */
@property (nonatomic, assign) CGFloat y;

/**
 中心点x
 */
@property (nonatomic, assign) CGFloat centerX;

/**
 中心点y
 */
@property (nonatomic, assign) CGFloat centerY;

/**
 宽度
 */
@property (nonatomic, assign) CGFloat width;

/**
 高度
 */
@property (nonatomic, assign) CGFloat height;

/**
 尺寸
 */
@property (nonatomic, assign) CGSize size;

@end
