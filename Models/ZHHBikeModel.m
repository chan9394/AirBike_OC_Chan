//
//  ZHHBikeModel.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/11/6.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHBikeModel.h"
#import <CoreLocation/CoreLocation.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
@implementation ZHHBikeModel

+(instancetype)bikeModelWithDic:(NSDictionary *)dic {
    
    ZHHBikeModel *model = [[ZHHBikeModel alloc] init];
    
    model.device_id = dic[@"device_id"];
    model.longitude = dic[@"longitude"];
    model.latitude = dic[@"latitude"];
    model.bike_id = dic[@"bike_id"];
    model.idList = dic[@"id"];
    model.serialnum = dic[@"serialnum"];
    model.area_block_id = dic[@"area_block_id"];
    model.is_ordered = dic[@"is_ordered"];
    model.appointment_expire = dic[@"appointment_expire"];
    model.updated = dic[@"updated"];
    model.status = dic[@"status"];
    model.electricity = dic[@"electricity"];
    
    
    
    //GPS坐标转换成高德地图坐标
    CLLocationCoordinate2D amapcoord = AMapCoordinateConvert(CLLocationCoordinate2DMake([[dic objectForKey:@"latitude"] floatValue],[[dic objectForKey:@"longitude"] floatValue]),AMapCoordinateTypeGPS);
    
    model.longitude = [NSString stringWithFormat:@"%f", amapcoord.longitude];
    model.latitude = [NSString stringWithFormat:@"%f", amapcoord.latitude];

//    Gps坐标
//    model.GpsLng = [[dic objectForKey:@"GpsLng"] floatValue];
//    model.GpsLat = [[dic objectForKey:@"GpsLat"] floatValue];
    return model;
    
}

@end
