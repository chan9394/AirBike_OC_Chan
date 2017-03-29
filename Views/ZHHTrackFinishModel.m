//
//  ZHHTrackFinishModel.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/12/12.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHTrackFinishModel.h"

@implementation ZHHTrackFinishModel

+(instancetype)trackFinishModel:(NSDictionary *)dic{
    
    ZHHTrackFinishModel *model = [ZHHTrackFinishModel new];
    [model setValuesForKeysWithDictionary:dic];
    return model;
    
}

@end
