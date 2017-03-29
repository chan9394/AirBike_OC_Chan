//
//  TrackListModel.m
//  AirBk
//
//  Created by Damo on 2017/1/16.
//  Copyright © 2017年 ZHH. All rights reserved.
//

#import "TrackListModel.h"

@implementation TrackListModel

- (void)modelWithJSON:(id)json {
   BOOL result = [self yy_modelSetWithJSON:json];
    if (result == 0) {
            NSLog(@"%s", __FUNCTION__);
    }
}

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{  @"ID" : @"id",
               @"userId" : @"user_id",
               @"deviceId" : @"device_id",
               @"lockId" : @"lock_id",
               @"isBattery" : @"is_battery",
               @"startTime" : @"start_time",
               @"endTime" : @"end_time",
               @"creditPoints" : @"credit_points",
               @"lockData" : @"lock_gps_data",
               @"appData" : @"app_gps_data",
               };
}

@end
