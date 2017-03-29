//
//  POIAnnotation.h
//  Map
//
//  Created by 郑洪浩 on 16/10/9.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZHHBikeModel;
/*
 地图上显示annotationView的模型
 */

@interface POIAnnotation : NSObject<MAAnnotation,NSCoding>

/**
 @brief 图标的地理位置
 */
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
/*!
 @brief 获取annotation标题
 */
@property (nonatomic,       copy) NSString *title;

/*!
 @brief 获取annotation副标题
 */
@property (nonatomic,       copy) NSString *subtitle;

//是否在搜索记录中收藏了
@property (nonatomic, assign) BOOL hasCollected;

//是否在搜索记录中选中
@property (nonatomic, assign) BOOL selectedToRemove;

@property (nonatomic,     strong) ZHHBikeModel *modelBike ;

-(instancetype)initWithPOI:(AMapPOI *)obj;
-(instancetype)initWithLongitude:(CGFloat)longitude andLatitude:(CGFloat)latitude;
-(instancetype)initWithCoordinate:(CLLocationCoordinate2D)newCoordinate;
-(instancetype)initWithCoordinate:(CLLocationCoordinate2D)newCoordinate andTitle:(NSString *)title;
-(instancetype)initWithCoordinate:(CLLocationCoordinate2D)newCoordinate andTitle:(NSString *)title subTitle:(NSString *)subTitle;
+(instancetype)annotationWithBikeModel:(ZHHBikeModel *)model;
@end

@interface RedWaterAnnotation :POIAnnotation

@end


