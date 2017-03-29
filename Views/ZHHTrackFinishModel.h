//
//  ZHHTrackFinishModel.h
//  AirBk
//
//  Created by 郑洪浩 on 2016/12/12.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHHTrackFinishModel : NSObject
@property (nonatomic, copy) NSString *app_gps_data;
@property (nonatomic, copy) NSString *bike_id;      
@property (nonatomic, copy) NSString *calorie;
@property (nonatomic, copy) NSString *carbon_emission;
@property (nonatomic, copy) NSString *cost;
@property (nonatomic, copy) NSString *cycling_id;       //当前行程的iD,骑行结束的参数
@property (nonatomic, copy) NSString *device_id;
@property (nonatomic, copy) NSString *distance;
@property (nonatomic, copy) NSString *lock_gps_data;
@property (nonatomic, copy) NSString *lock_id;
@property (nonatomic, copy) NSString *mileage;
@property (nonatomic, copy) NSString *riding_minute;

+(instancetype)trackFinishModel:(NSDictionary *)dic;
@end
