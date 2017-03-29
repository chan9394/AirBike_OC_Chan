//
//  ZHHUploadBikeProModel.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/11/12.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHUploadBikeProModel.h"

@implementation ZHHUploadBikeProModel

+(instancetype)problemModelWithBikeId:(NSNumber *)bikeId andUserId:(NSNumber *)userId andBikeImage:(UIImage *)image andDescribtion:(NSString *)describtion{
    
    ZHHUploadBikeProModel *model = [[ZHHUploadBikeProModel alloc] init];
    model.UserId = userId;
    model.bikeImage = image;
    model.pDescribtion = describtion;
    model.BikeId = bikeId;
    return model;
    
}

@end
