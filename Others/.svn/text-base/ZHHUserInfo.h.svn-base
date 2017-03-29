//
//  ZHHUserInfo.h
//  AirBk
//
//  Created by 郑洪浩 on 2016/11/28.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZHHLogModel,ZHHGetUserInfoMod;

@interface ZHHUserInfo : NSObject

/**
 类方法获取已登录用户的信息

 @return 用户信息
 */
+(ZHHLogModel *)sharedUserInfo;
+(ZHHGetUserInfoMod *)shareGetUserInfoMod;
/**
 判断是否已经登录

 @return bool值
 */
+(BOOL)hasLogOn;

/**
 将用户信息归档
 */
+(void)keyedArchiverUserInfo:(ZHHLogModel *)model;

+(void)keyedArchiverGetUserInfoMod:(ZHHGetUserInfoMod *)model;


/**
 登出
 */
+(void)logOut;
@end
