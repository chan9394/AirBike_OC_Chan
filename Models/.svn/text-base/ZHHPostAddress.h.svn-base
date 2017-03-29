//
//  ZHHPostAddress.h
//  AirBk
//
//  Created by 郑洪浩 on 2016/12/1.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHHConsigneeAddr : NSObject<NSCoding>

@property (nonatomic, copy)NSString *province;//省
@property (nonatomic, copy)NSString *city;//市
@property (nonatomic, copy)NSString *region;//区

/**
 初始化对象

 @param aprovince 省
 @param city 市
 @param region 区
 @return 对象
 */
+(instancetype)consigneeAddrWith:(NSString *)aprovince andCity:(NSString *)city andRegion:(NSString *)region;
@end

@interface ZHHPostAddress : NSObject<NSCoding>
@property (nonatomic, copy)NSString *consigneeName;//收货人姓名
@property (nonatomic, copy)NSString *consigneeNum;//收货人电话
@property (nonatomic, strong)ZHHConsigneeAddr *consigneeAddr;//收货人所在地区
@property (nonatomic, copy)NSString *addDetail;//详细地址

/**
 初始化对象

 @return 对象
 */

+(instancetype)postAddressWithConsigneeName:(NSString *)aname andConsigneeNum:(NSString *)aconsigneeNum andProvince:(NSString *)aProvince andCity:(NSString *)acity andRegion:(NSString *)aregion andAddDetail:(NSString *)adetail;

-(void)changeAddreWithConsigneeName:(NSString *)aname andConsigneeNum:(NSString *)aconsigneeNum andProvince:(NSString *)aProvince andCity:(NSString *)acity andRegion:(NSString *)aregion andAddDetail:(NSString *)adetail;
@end
