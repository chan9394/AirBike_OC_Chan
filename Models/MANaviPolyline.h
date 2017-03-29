//
//  MANaviPolyline.h
//  officialDemo2D
//
//  Created by xiaoming han on 15/5/25.
//  Copyright (c) 2015年 AutoNavi. All rights reserved.
//


#import "MANaviAnnotation.h"//;
/*
 所显示的轨迹中polyView的model
 */

@interface MANaviPolyline : NSObject<MAOverlay>

/**
 轨迹中导航图标的类型
 */
@property (nonatomic, assign) MANaviAnnotationType type;

/**
 绘制路线的模型polyline
 */
@property (nonatomic, strong) MAPolyline *polyline;

/**
 初始化NavPolyLine对象

 @param polyline 模型
 @return 实例对象
 */
- (id)initWithPolyline:(MAPolyline *)polyline;

@end
