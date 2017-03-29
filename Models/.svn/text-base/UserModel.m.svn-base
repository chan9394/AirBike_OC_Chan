//
//  UserModel.m
//  AirBk
//
//  Created by Damo on 2017/1/12.
//  Copyright © 2017年 ZHH. All rights reserved.
//

#import "UserModel.h"
#import <SAMKeychain.h>
#import <objc/runtime.h>

@implementation UserModel

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{  @"ID" : @"id",
               @"password" : @"password_hash",
               @"accessToken" : @"access_token",
               @"headImage" : @"head_image",
               @"nickName" : @"nick_name",
               @"realName" : @"real_name",
               @"card" : @"id_card_number",
               @"unreadCounter": @"unread_message_counter",
               @"invitCode" : @"invit_code",
               @"cyclingMinutes" : @"cycling_minutes"
               };
}

- (void)setAccessToken:(NSString *)accessToken {
    _accessToken = accessToken;
    [SAMKeychain setPassword:_accessToken forService:@"airbike" account:@"token"];
}

- (NSString *)nick_name {
    if (!_nickName) {
        return self.mobile;
    }
    return _nickName;
}

- (void)modelWIthJSON:(id)json {
    BOOL result = [self yy_modelSetWithJSON:json];
    if (result == 0) {
        NSLog(@"%s", __FUNCTION__);
    }
}

@end
