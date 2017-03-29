//
//  ZHHUserDetailInfo.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/12/11.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHUserDetailInfo.h"

@implementation ZHHUserDetailInfo
+(instancetype)userDetailInfo:(NSDictionary *)dic{
    
    ZHHUserDetailInfo *info = [ZHHUserDetailInfo new];
    
    info.UserId = [dic objectForKey:@"id"];
    info.mobile = [dic objectForKey:@"mobile"];
    info.password_hash = [dic objectForKey:@"password_hash"];
    info.password_reset_token = [dic objectForKey:@"password_reset_token"];
    info.access_token = [dic objectForKey:@"access_token"];
//    info.head_image = [dic objectForKey:@"head_image"];
    info.head_image = [NSString stringWithFormat:@"http://airbike.wrteach.com%@",dic[@"head_image"]];
    info.nick_name = [dic objectForKey:@"nick_name"];
    info.real_name = [dic objectForKey:@"real_name"];
    info.has_deposit = [dic objectForKey:@"has_deposit"];
    info.id_card_number = [dic objectForKey:@"id_card_number"];
    info.sex = [dic objectForKey:@"sex"];
    info.birthday = [dic objectForKey:@"birthday"];
    info.height = [dic objectForKey:@"height"];
    info.weight = [dic objectForKey:@"weight"];
    info.user_level = [dic objectForKey:@"user_level"];
    info.cycling_times = [dic objectForKey:@"cycling_times"];
    info.mileage = [dic objectForKey:@"mileage"];
    info.carbon_emission = [dic objectForKey:@"carbon_emission"];
    info.calorie = [dic objectForKey:@"calorie"];
    info.unread_message_counter = [dic objectForKey:@"unread_message_counter"];
    info.invit_code = [dic objectForKey:@"invit_code"];
    info.invit_code_lock = [dic objectForKey:@"invit_code_lock"];
    info.inviter_user_id = [dic objectForKey:@"inviter_user_id"];
    info.created = [dic objectForKey:@"created"];
    info.updated = [dic objectForKey:@"updated"];
    info.access_token_last_time = [dic objectForKey:@"access_token_last_time"];
    info.status = [dic objectForKey:@"status"];
    
    return info;
    
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.UserId forKey:@"UserId"];
    [aCoder encodeObject:self.mobile forKey:@"mobile"];
    [aCoder encodeObject:self.password_hash forKey:@"password_hash"];
    [aCoder encodeObject:self.password_reset_token forKey:@"password_reset_token"];
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.head_image forKey:@"head_image"];
    [aCoder encodeObject:self.nick_name forKey:@"nick_name"];
    [aCoder encodeObject:self.real_name forKey:@"real_name"];
    [aCoder encodeObject:self.has_deposit forKey:@"has_deposit"];
    [aCoder encodeObject:self.id_card_number forKey:@"id_card_number"];
    [aCoder encodeObject:self.sex forKey:@"sex"];
    [aCoder encodeObject:self.birthday forKey:@"birthday"];
    [aCoder encodeObject:self.height forKey:@"height"];
    [aCoder encodeObject:self.weight forKey:@"weight"];
    [aCoder encodeObject:self.user_level forKey:@"user_level"];
    [aCoder encodeObject:self.cycling_times forKey:@"cycling_times"];
    [aCoder encodeObject:self.mileage forKey:@"mileage"];
    [aCoder encodeObject:self.carbon_emission forKey:@"carbon_emission"];
    [aCoder encodeObject:self.calorie forKey:@"calorie"];
    [aCoder encodeObject:self.unread_message_counter forKey:@"unread_message_counter"];
    [aCoder encodeObject:self.invit_code forKey:@"invit_code"];
    [aCoder encodeObject:self.invit_code_lock forKey:@"invit_code_lock"];
    [aCoder encodeObject:self.inviter_user_id forKey:@"inviter_user_id"];
    [aCoder encodeObject:self.created forKey:@"created"];
    [aCoder encodeObject:self.updated forKey:@"updated"];
    [aCoder encodeObject:self.access_token_last_time forKey:@"access_token_last_time"];
    [aCoder encodeObject:self.status forKey:@"status"];
    
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        
        self.UserId = [aDecoder decodeObjectForKey:@"UserId"];
        self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
        self.password_hash = [aDecoder decodeObjectForKey:@"password_hash"];
        self.password_reset_token = [aDecoder decodeObjectForKey:@"password_reset_token"];
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.head_image = [aDecoder decodeObjectForKey:@"head_image"];
        self.nick_name = [aDecoder decodeObjectForKey:@"nick_name"];
        self.real_name = [aDecoder decodeObjectForKey:@"real_name"];
        self.has_deposit = [aDecoder decodeObjectForKey:@"has_deposit"];
        self.id_card_number = [aDecoder decodeObjectForKey:@"id_card_number"];
        self.sex = [aDecoder decodeObjectForKey:@"sex"];
        self.birthday = [aDecoder decodeObjectForKey:@"birthday"];
        self.height = [aDecoder decodeObjectForKey:@"height"];
        self.weight = [aDecoder decodeObjectForKey:@"weight"];
        self.user_level = [aDecoder decodeObjectForKey:@"user_level"];
        self.cycling_times = [aDecoder decodeObjectForKey:@"cycling_times"];
        self.mileage = [aDecoder decodeObjectForKey:@"mileage"];
        self.carbon_emission = [aDecoder decodeObjectForKey:@"carbon_emission"];
        self.calorie = [aDecoder decodeObjectForKey:@"calorie"];
        self.unread_message_counter = [aDecoder decodeObjectForKey:@"unread_message_counter"];
        self.invit_code = [aDecoder decodeObjectForKey:@"invit_code"];
        self.invit_code_lock = [aDecoder decodeObjectForKey:@"invit_code_lock"];
        self.inviter_user_id = [aDecoder decodeObjectForKey:@"inviter_user_id"];
        self.created = [aDecoder decodeObjectForKey:@"created"];
        self.updated = [aDecoder decodeObjectForKey:@"updated"];
        self.access_token_last_time = [aDecoder decodeObjectForKey:@"access_token_last_time"];
        self.status = [aDecoder decodeObjectForKey:@"status"];
        
    }
    return self;
    
}

@end
