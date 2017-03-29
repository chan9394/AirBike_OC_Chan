//
//  ZHHUploadBikeProModel.h
//  AirBk
//
//  Created by 郑洪浩 on 2016/11/12.
//  Copyright © 2016年 ZHH. All rights reserved.
//


#import <Foundation/Foundation.h>

/**
 上传单车故障的模型
 */
@interface ZHHUploadBikeProModel : NSObject

/**
 用户ID
 */
@property(nonatomic,strong) NSNumber *UserId;

/**
 单车ID
 */
@property(nonatomic,strong) NSNumber *BikeId;

/**
 单车照片
 */
@property (nonatomic, strong)UIImage *bikeImage;

/**
 描述信息
 */
@property (nonatomic, copy)NSString *pDescribtion;

/**
 打包上传故障单车信息

 @param bikeId 单车ID
 @param userId 用户ID
 @param image 单车照片
 @param describtion 故障描述
 @return 模型对象
 */
+(instancetype)problemModelWithBikeId:(NSNumber *)bikeId andUserId:(NSNumber *)userId andBikeImage:(UIImage *)image andDescribtion:(NSString *)describtion;

@end
