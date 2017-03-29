//
//  CommonUtility.h
//  SearchV3Demo
//
//  Created by songjian on 13-8-22.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 地图View上点坐标与地理坐标相互转换,获取折线model的类方法,获取app的配置和名字,获取地图上两个点之间的地理距离,
 */

@interface CommonUtility : NSObject

/**
 将字符串的coordinate转化成数组

 @param string coordinate数组的字符串
 @param coordinateCount 数组变量的个数
 @param token 隔断符
 @return coordinate数组的地址
 */
+ (CLLocationCoordinate2D *)coordinatesForString:(NSString *)string
                                 coordinateCount:(NSUInteger *)coordinateCount
                                      parseToken:(NSString *)token;

/**
 将字符串coordinate转成polyLine对象

 @param coordinateString coordinate数组的字符串
 @return polyLine对象
 */
+ (MAPolyline *)polylineForCoordinateString:(NSString *)coordinateString;

/**
 根据公交线路对象创建polyLine对象

 @param busLine 公交路线对象
 @return polyline对象
 */
+ (MAPolyline *)polylineForBusLine:(AMapBusLine *)busLine;

/**
 计算两个区域的区域组合区域

 @param mapRect1 区域一
 @param mapRect2 区域二
 @return 组合区域
 */
+ (MAMapRect)unionMapRect1:(MAMapRect)mapRect1 mapRect2:(MAMapRect)mapRect2;

/**
 计算一个区域数组的组合区域

 @param mapRects 区域数组的地址
 @param count 数组个数
 @return 组合区域
 */
+ (MAMapRect)mapRectUnion:(MAMapRect *)mapRects count:(NSUInteger)count;

/**
 区域数组外接矩形的组合区域

 @param overlays 覆盖物区域数组的地址
 @return 组合区域
 */
+ (MAMapRect)mapRectForOverlays:(NSArray *)overlays;

/**
 一组地图上的点坐标围成的最大矩形

 @param mapPoints 点坐标数组的地址
 @param count 数组个数
 @return 最大矩形
 */
+ (MAMapRect)minMapRectForMapPoints:(MAMapPoint *)mapPoints count:(NSUInteger)count;

/**
 一组标注数组围城的最大矩形

 @param annotations 标注数组的地址
 @return 最大矩形
 */
+ (MAMapRect)minMapRectForAnnotations:(NSArray *)annotations;

/**
 获取应用配置

 @return 应用配置
 */
+ (NSString *)getApplicationScheme;

/**
 获取应用名

 @return 应用名
 */
+ (NSString *)getApplicationName;

/**
 线段到一点的距离

 @param p 点
 @param l1 线段起点
 @param l2 线段终点
 @return 距离
 */
+ (double)distanceToPoint:(MAMapPoint)p fromLineSegmentBetween:(MAMapPoint)l1 and:(MAMapPoint)l2;

@end
