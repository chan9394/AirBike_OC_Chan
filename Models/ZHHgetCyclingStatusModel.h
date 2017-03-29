//
//  ZHHgetCyclingStatusModel.h
//  AirBk
//
//  Created by 郑洪浩 on 2016/12/13.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHHgetCyclingStatusModel : NSObject

//"app_gps_data" = "<null>";
//"bike_id" = 1;
//calorie = 330;
//"carbon_emission" = 3;
//cost = 1;
//"device_id" = 056625301289;
//distance = 0;
//"lock_gps_data" =     (
//                       {
//                           lat = "31.16062";
//                           lng = "121.432698";
//                           time = "2016-12-13 11:05:48";
//                       },
//                       {
//                           lat = "31.16062";
//                           lng = "121.432698";
//                           time = "2016-12-13 11:06:08";
//                       },
//                       {
//                           lat = "31.16062";
//                           lng = "121.432698";
//                           time = "2016-12-13 11:06:28";
//                       },
//                       {
//                           lat = "31.16062";
//                           lng = "121.432698";
//                           time = "2016-12-13 11:06:48";
//                       }
//                       );
//"lock_id" = 1;
//mileage = "0.00";
//"riding_minute" = "1.4333333333333";

@property (nonatomic, copy)NSString *app_gps_data;///<标注#>
@property (nonatomic, copy)NSString *bike_id;///<标注#>
@property (nonatomic, copy)NSString *calorie;///<标注#>
@property (nonatomic, copy)NSString *carbon_emission;///<标注#>
@property (nonatomic, copy)NSString *cost;///<标注#>
@property (nonatomic, copy)NSString *device_id;///<标注#>
@property (nonatomic, copy)NSString *cycling_id;///<标注#>
@property (nonatomic, copy)NSString *distance;///<标注#>
@property (nonatomic, strong)NSArray *lock_gps_data;///<标注#>
@property (nonatomic, copy)NSString *lock_id;///<标注#>
@property (nonatomic, copy)NSString *mileage;///<标注#>
@property (nonatomic, copy)NSString *riding_minute;///<标注#>

+(ZHHgetCyclingStatusModel *)getCuclingStatusModel:(NSDictionary *)dic;

@end
