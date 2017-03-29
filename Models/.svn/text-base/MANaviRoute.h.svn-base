//
//  MANaviRoute.h
//  OfficialDemo3D
//
//  Created by yi chen on 1/7/15.
//  Copyright (c) 2015 songjian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MANaviAnnotation.h"
#import "MANaviPolyline.h"
#import "LineDashPolyline.h"
/*
 地图中绘制路线的Model
 */

@interface MANaviRoute : NSObject

// 是否显示annotation, 显示路况的情况下无效。
@property (nonatomic, assign) BOOL anntationVisible;

/**
 导航路线
 */
@property (nonatomic, strong) NSArray *routePolylines;

/**
 导航的图标
 */
@property (nonatomic, strong) NSArray *naviAnnotations;
/// 普通路线颜色
@property (nonatomic, strong) UIColor *routeColor;
/// 步行路线颜色
@property (nonatomic, strong) UIColor *walkingColor;
/// 铁路路线颜色
@property (nonatomic, strong) UIColor *railwayColor;
/// 多彩线颜色
@property (nonatomic, strong) NSArray<UIColor *> *multiPolylineColors;

/**
 将对象添加到地图上

 @param mapView 地图的视图
 */
- (void)addToMapView:(MAMapView *)mapView;

/**
 从地图上移除
 */
- (void)removeFromMapView;

/**
 设置导航图标是否可见

 @param visible bool属性
 */
- (void)setNaviAnnotationVisibility:(BOOL)visible;

/**
 根据公交方案对象创建导航路线实例对象

 @param transit 公交方案
 @param start 起点
 @param end 终点
 @return 导航路线实例对象
 */
+ (instancetype)naviRouteForTransit:(AMapTransit *)transit
                         startPoint:(AMapGeoPoint *)start
                           endPoint:(AMapGeoPoint *)end;

/**
 根据amapPath对象创建导航路线实例

 @param path aMapPath对象
 @param type 导航类型
 @param showTraffic 是否显示路况
 @param start 起点
 @param end 终点
 @return 导航对象实例
 */

+ (instancetype)naviRouteForPath:(AMapPath *)path
                    withNaviType:(MANaviAnnotationType)type
                     showTraffic:(BOOL)showTraffic
                      startPoint:(AMapGeoPoint *)start
                        endPoint:(AMapGeoPoint *)end;

/**
 根据polyline和图标创建当行

 @param polylines polyline数组对象
 @param annotations annotation数组对象
 @return 导航实例对象
 */
+ (instancetype)naviRouteForPolylines:(NSArray *)polylines
                       andAnnotations:(NSArray *)annotations;


/**
 初始化导航路线实例

 @param transit 是否显示路况
 @param start 起点
 @param end 终点
 @return 导航实例对象
 */
- (instancetype)initWithTransit:(AMapTransit *)transit
                     startPoint:(AMapGeoPoint *)start
                       endPoint:(AMapGeoPoint *)end;

/**
 init方法初始化导航实例对象 与+(instancetype)naviRouteForPath:withNaviType:showTraffic:startPoint:endPoint:(AMapGeoPoint *)end; 方法类似


 */
- (instancetype)initWithPath:(AMapPath *)path
                withNaviType:(MANaviAnnotationType)type
                 showTraffic:(BOOL)showTraffic
                  startPoint:(AMapGeoPoint *)start
                    endPoint:(AMapGeoPoint *)end;

/**
 init方法初始化导航实例对象 与+ (instancetype)naviRouteForPolylines:andAnnotations:; 方法类似

 */
- (instancetype)initWithPolylines:(NSArray *)polylines
                   andAnnotations:(NSArray *)annotations;

@end
