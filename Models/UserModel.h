//
//  UserModel.h
//  AirBk
//
//  Created by Damo on 2017/1/12.
//  Copyright © 2017年 ZHH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject <YYModel>

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *mobile;                       //手机号
@property (nonatomic, copy) NSString *password;                   //密码
@property (nonatomic, copy) NSString *accessToken;
@property (nonatomic, copy) NSString *headImage;                 //头像
@property (nonatomic, copy) NSString *nickName;                  //昵称
@property (nonatomic, copy) NSString *realName;                   //真实姓名
@property (nonatomic, copy) NSString *card;                          //身份证
@property (nonatomic, copy) NSString *mileage;                     //骑行总里程
@property (nonatomic, copy) NSString *cyclingMinutes;           //骑行总里程
@property (nonatomic, copy) NSString *unreadCounter;           //未读消息
@property (nonatomic, copy) NSString *invitCode;                   //邀请码
@property (nonatomic, copy) NSString *status;                        //状态0:封停  1:正常使用 2:已上传认证 3已通过认证

//json转模型
- (void)modelWIthJSON:(id)json;

@end
