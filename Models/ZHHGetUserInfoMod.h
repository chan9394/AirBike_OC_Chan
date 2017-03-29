//
//  ZHHGetUserInfoMod.h
//  AirBk
//
//  Created by 郑洪浩 on 2016/12/11.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZHHUserDetailInfo,ZHHBalanceModel;
@interface ZHHGetUserInfoMod : NSObject

@property (nonatomic, strong)ZHHUserDetailInfo *user;
@property (nonatomic, strong)ZHHBalanceModel *balance;
+(instancetype)getUserInfoMod:(NSDictionary *)dic;
@end
