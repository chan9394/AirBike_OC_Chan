//
//  ZHHOrderBikeView.h
//  AirBk
//
//  Created by 郑洪浩 on 2016/11/4.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "POIAnnotation.h"


@protocol ZHHOrderBikeViewDelegate <NSObject>

/**
 点击取消预约的按钮
 */
-(void)clickCancleOrderBtn;

@end

@interface ZHHOrderBikeView : UIView

/**
 自行车的位置
 */
@property (strong,nonatomic) POIAnnotation *destinationAnnotation;

@property (assign, nonatomic) NSInteger       seconds;       //预约的时长

@property (nonatomic, strong) NSString         *location;  //当前位置

@property (nonatomic, strong) NSString         *deviceId;  // 单车编号
/**
 代理,需遵守ZHHOrderBikeViewDelegate协议
 */
@property(nonatomic,weak) id<ZHHOrderBikeViewDelegate>delegate;

/**
 创建实例对象

 @return 实例对象
 */
+(instancetype)orderBikeView;

@end
