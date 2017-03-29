//
//  ZHHNewsInfoModel.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/12/11.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHNewsInfoModel.h"

@implementation ZHHNewsInfoModel

+(instancetype)newsInfoModelWith:(NSDictionary *)dicNew{
    ZHHNewsInfoModel *model = [ZHHNewsInfoModel new];
    [model setValuesForKeysWithDictionary:dicNew];
    return model;
}

@end
