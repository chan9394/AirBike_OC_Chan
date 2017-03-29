//
//  ZHHClientSportInfo.h
//  AirBk
//
//  Created by 郑洪浩 on 2016/11/3.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHHLogModel;

@interface ZHHClientSportInfoView : UIView

/**
 登录用户的模型
 */
@property(nonatomic,strong) ZHHLogModel *user;

/**
 实例化对象

 @return 实例对象
 */
+(instancetype)clientSportInfo;

@end
