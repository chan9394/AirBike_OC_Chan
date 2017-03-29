//
//  UserStatusModel.m
//  AirBk
//
//  Created by Damo on 2017/2/8.
//  Copyright © 2017年 ZHH. All rights reserved.
//

#import "RidingStatusModel.h"

@implementation RidingStatusModel

- (void)modelWIthJSON:(id)json {
    BOOL result = [self yy_modelSetWithJSON:json];
    if (result == 0) {
        NSLog(@"%s", __FUNCTION__);
    }
}

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{  @"ridingStatus" : @"riding_status",
               @"serialNo" : @"riding_info.serial_no",
               @"lockId":@[@"riding_info.lock_id",@"booking_info.device_id"],
               @"seconds" : @"booking_info.expire_secs",
               };
}
@end
