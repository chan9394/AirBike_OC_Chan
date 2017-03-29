//
//  RechageDetailModel.m
//  AirBk
//
//  Created by Damo on 2017/1/16.
//  Copyright © 2017年 ZHH. All rights reserved.
//

#import "RechageDetailModel.h"

@implementation RechageDetailModel

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{  @"rechaId" : @"id",
               @"paymentNo" : @"payment_no",
               @"paymentType" : @"payment_type",
               @"userId" : @"user_id",
               };
}

- (void)modelWithJSON:(id)json {
    BOOL result = [self yy_modelSetWithJSON:json];
    if (result == 0) {
        NSLog(@"%s", __FUNCTION__);
    }
}

@end
