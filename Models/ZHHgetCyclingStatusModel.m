//
//  ZHHgetCyclingStatusModel.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/12/13.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHgetCyclingStatusModel.h"

@implementation ZHHgetCyclingStatusModel
+(ZHHgetCyclingStatusModel *)getCuclingStatusModel:(NSDictionary *)dic{
    
    ZHHgetCyclingStatusModel *model = [ZHHgetCyclingStatusModel new];
    [model setValuesForKeysWithDictionary:dic];
    return model;
    
}
@end
