//
//  ZHHUserDetailInfo.h
//  AirBk
//
//  Created by 郑洪浩 on 2016/12/11.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHHUserDetailInfo : NSObject
@property (nonatomic, copy)NSString *UserId;
@property (nonatomic, copy)NSString *mobile;
@property (nonatomic, copy)NSString *password_hash;
@property (nonatomic, copy)NSString *password_reset_token;
@property (nonatomic, copy)NSString *access_token;
@property (nonatomic, copy)NSString *head_image;
@property (nonatomic, copy)NSString *nick_name;
@property (nonatomic, copy)NSString *real_name;
@property (nonatomic, copy)NSString *has_deposit;
@property (nonatomic, copy)NSString *id_card_number;
@property (nonatomic, copy)NSString *sex;
@property (nonatomic, copy)NSString *birthday;
@property (nonatomic, copy)NSString *height;
@property (nonatomic, copy)NSString *weight;
@property (nonatomic, copy)NSString *user_level;
@property (nonatomic, copy)NSString *cycling_times;
@property (nonatomic, copy)NSString *mileage;
@property (nonatomic, copy)NSString *carbon_emission;
@property (nonatomic, copy)NSString *calorie;
@property (nonatomic, copy)NSString *unread_message_counter;
@property (nonatomic, copy)NSString *invit_code;
@property (nonatomic, copy)NSString *invit_code_lock;
@property (nonatomic, copy)NSString *inviter_user_id;
@property (nonatomic, copy)NSString *created;
@property (nonatomic, copy)NSString *updated;
@property (nonatomic, copy)NSString *access_token_last_time;
@property (nonatomic, copy)NSString *status;

+(instancetype)userDetailInfo:(NSDictionary *)dic;
@end
