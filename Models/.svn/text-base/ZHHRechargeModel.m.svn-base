//
//  ZHHRechargeModel.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/12/12.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHRechargeModel.h"

@implementation ZHHRechargeModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{ @"rechageDetailArr" : [RechageDetailModel class]
             };
}

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{
             @"rechageDetailArr" : @"list",
             };
}

- (void)modelWithJSON:(id)json {
    BOOL result = [self yy_modelSetWithJSON:json];
     if (result == 0) {
         NSLog(@"%s", __FUNCTION__);
     }
}

@end
