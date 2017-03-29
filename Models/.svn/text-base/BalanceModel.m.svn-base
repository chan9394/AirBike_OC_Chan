//
//  BalanceModel.m
//  AirBk
//
//  Created by Damo on 2017/1/12.
//  Copyright © 2017年 ZHH. All rights reserved.
//

#import "BalanceModel.h"

@implementation BalanceModel

- (void)modelWIthJSON:(id)json {
    BOOL result = [self yy_modelSetWithJSON:json];
    if (result == 0) {
        NSLog(@"%s", __FUNCTION__);
    }
}

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{  @"userId" : @"user_id",
               @"creditPoint" : @"credit_points",
               };
}

@end
