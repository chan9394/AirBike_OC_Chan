//
//  PlanResult.h
//  Mobike
//
//  Created by 郑洪浩 on 16/10/14.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlanResult : NSObject

/*
 展示起点与中点间交通信息View的model
 */

/**
 骑行距离
 */
@property (assign ,nonatomic) NSInteger distance;

/**
 骑行时间
 */
@property (assign ,nonatomic) NSInteger duration;

/**
 骑行终点
 */
@property (copy ,nonatomic) NSString *destination;

/**
 骑行结束的模型

 @param dis 距离
 @param dur 时间
 @param des 终点
 @return 实例对象
 */
-(instancetype)initWithDistance:(NSInteger)dis andDuration:(NSInteger)dur andDestination:(NSString *)des;

@end
