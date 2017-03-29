//
//  ZHHBikeModel.h
//  AirBk
//
//  Created by 郑洪浩 on 2016/11/6.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHHBikeModel : NSObject

@property(nonatomic,strong)NSString *device_id;
@property(nonatomic,assign)NSString *longitude;
@property(nonatomic,assign)NSString *latitude;
@property (nonatomic, copy)NSString *bike_id;
@property (nonatomic, copy)NSString *idList;///<标注#>
@property (nonatomic, copy)NSString *serialnum;///<标注#>
@property (nonatomic, copy)NSString *area_block_id;///<标注#>
@property (nonatomic, copy)NSString *is_ordered;///<标注#>
@property (nonatomic, copy)NSString *appointment_expire;///<标注#>
@property (nonatomic, copy)NSString *updated;///<标注#>
@property (nonatomic, copy)NSString *status;///<标注#>
@property (nonatomic, copy)NSString *electricity;///<标注#>
/**
 字典转成模型
 @param dic 存有单车信息的字典,网络请求获取
 @return 单车信息模型
 */
+(instancetype)bikeModelWithDic:(NSDictionary *)dic;
@end
