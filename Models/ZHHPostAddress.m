//
//  ZHHPostAddress.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/12/1.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHPostAddress.h"

@implementation ZHHConsigneeAddr

+(instancetype)consigneeAddrWith:(NSString *)aprovince andCity:(NSString *)city andRegion:(NSString *)region{
    
    ZHHConsigneeAddr *add = [[ZHHConsigneeAddr alloc] init];
    add.province = aprovince;
    add.city = city;
    add.region = region;
    return add;
    
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.province forKey:@"province"];
    [aCoder encodeObject:self.city forKey:@"city"];
    [aCoder encodeObject:self.region forKey:@"region"];
    
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    NSString *province = [aDecoder decodeObjectForKey:@"province"];
    NSString *region = [aDecoder decodeObjectForKey:@"region"];
    NSString *city = [aDecoder decodeObjectForKey:@"city"];
    ZHHConsigneeAddr *addr = [ZHHConsigneeAddr consigneeAddrWith:province andCity:city andRegion:region];
    return addr;
    
}
@end


@implementation ZHHPostAddress

+(instancetype)postAddressWithConsigneeName:(NSString *)aname andConsigneeNum:(NSString *)aconsigneeNum  andProvince:(NSString *)aProvince andCity:(NSString *)acity andRegion:(NSString *)aregion andAddDetail:(NSString *)adetail{
    
    ZHHPostAddress *addre = [[ZHHPostAddress alloc] init];
    
    ZHHConsigneeAddr *add = [ZHHConsigneeAddr consigneeAddrWith:aProvince andCity:acity andRegion:aregion];
    
    addre.consigneeName = aname;
    addre.consigneeNum = aconsigneeNum;
    addre.consigneeAddr = add;
    addre.addDetail = adetail;
    
    return addre;
    
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.consigneeName forKey:@"consigneeName"];
    [aCoder encodeObject:self.consigneeNum forKey:@"consigneeNum"];
    [aCoder encodeObject:self.consigneeAddr forKey:@"consigneeAddr"];
    [aCoder encodeObject:self.addDetail forKey:@"addDetail"];
    
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    NSString *consigneeName = [aDecoder decodeObjectForKey:@"consigneeName"];
    NSString *consigneeNum = [aDecoder decodeObjectForKey:@"consigneeNum"];
    ZHHConsigneeAddr *consigneeAddr = [aDecoder decodeObjectForKey:@"consigneeAddr"];
    NSString *addDetail = [aDecoder decodeObjectForKey:@"addDetail"];
    ZHHPostAddress *addr = [ZHHPostAddress postAddressWithConsigneeName:consigneeName andConsigneeNum:consigneeNum andProvince:consigneeAddr.province andCity:consigneeAddr.city andRegion:consigneeAddr.region andAddDetail:addDetail];
    return addr;
    
}
-(void)changeAddreWithConsigneeName:(NSString *)aname andConsigneeNum:(NSString *)aconsigneeNum andProvince:(NSString *)aProvince andCity:(NSString *)acity andRegion:(NSString *)aregion andAddDetail:(NSString *)adetail{
   
    self.consigneeName = aname;
    self.consigneeNum = aconsigneeNum;
    self.consigneeAddr.province = aProvince;
    self.consigneeAddr.city = acity;
    self.consigneeAddr.region= aregion;
    self.addDetail = adetail;
    
}
@end
