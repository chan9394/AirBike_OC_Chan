//
//  UIView+HHVIew.h
//  Mobike
//
//  Created by 郑洪浩 on 16/10/13.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HHVIew)

/**
 坐标x
 */
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
