//
//  ZHHUserModel.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/12/7.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHUserModel.h"

@implementation ZHHUserModel
+(instancetype)userModelWithDic:(NSDictionary *)dic{
    
    ZHHUserModel *model = [[ZHHUserModel alloc] init];
    model.mobile = [dic objectForKey:@"mobile"];
    model.nick_name = [dic objectForKey:@"nick_name"];
    model.password_hash = [dic objectForKey:@"password_hash"];
    model.iD = [dic objectForKey:@"iD"];
    model.status = [dic objectForKey:@"status"];
    model.real_name = [dic objectForKey:@"real_name"];
    model.calorie = [dic objectForKey:@"calorie"];
    model.carbon_emission = [dic objectForKey:@"carbon_emission"];
    model.access_token = [dic objectForKey:@"access_token"];
    model.unread_message_counter = [dic objectForKey:@"unread_message_counter"];
    model.mileage = [dic objectForKey:@"mileage"];
    model.hasDeposit = [dic objectForKey:@"has_deposit"];

    return model;
    
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.iD forKey:@"iD"];
    [aCoder encodeObject:self.mobile forKey:@"mobile"];
    [aCoder encodeObject:self.nick_name forKey:@"nick_name"];
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.password_hash forKey:@"password_hash"];
    [aCoder encodeObject:self.real_name forKey:@"real_name"];
    [aCoder encodeObject:self.unread_message_counter forKey:@"unread_message_counter"];
    [aCoder encodeObject:self.mileage forKey:@"mileage"];
    [aCoder encodeObject:self.carbon_emission forKey:@"carbon_emission"];
    [aCoder encodeObject:self.calorie forKey:@"calorie"];
    [aCoder encodeObject:self.status forKey:@"status"];
    [aCoder encodeObject:self.hasDeposit forKey:@"hasDeposit"];
    
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        
        self.iD = [aDecoder decodeObjectForKey:@"iD"];
        self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
        self.nick_name = [aDecoder decodeObjectForKey:@"nick_name"];
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.password_hash = [aDecoder decodeObjectForKey:@"password_hash"];
        self.real_name = [aDecoder decodeObjectForKey:@"real_name"];
        self.unread_message_counter = [aDecoder decodeObjectForKey:@"unread_message_counter"];
        self.mileage = [aDecoder decodeObjectForKey:@"mileage"];
        self.carbon_emission = [aDecoder decodeObjectForKey:@"carbon_emission"];
        self.calorie = [aDecoder decodeObjectForKey:@"calorie"];
        self.status = [aDecoder decodeObjectForKey:@"status"];
        self.hasDeposit = [aDecoder decodeObjectForKey:@"hasDeposit"];
        
    }
    return self;
    
}

@end
