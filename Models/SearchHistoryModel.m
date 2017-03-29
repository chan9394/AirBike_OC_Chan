//
//  SearchHistoryModel.m
//  AirBk
//
//  Created by Damo on 2017/2/17.
//  Copyright © 2017年 ZHH. All rights reserved.
//

#import "SearchHistoryModel.h"

@implementation SearchHistoryModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{ @"listArray" : [SearchHistoryModel class],
              };
}

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{@"listArray" : @"result",
             @"ID"              : @"id",
             @"searchKey"  : @"search_key",
             @"searchAddr": @"search_addr",
             @"updateTime" : @"update_time",
             };
}

- (void)modelWIthJSON:(id)json {
    BOOL result = [self yy_modelSetWithJSON:json];
    if (result == 0) {
        NSLog(@"%s", __FUNCTION__);
    }
}

@end
