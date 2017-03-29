//
//  PlanInfoView.h
//  Mobike
//
//  Created by 郑洪浩 on 16/10/14.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlanResult.h"
@class ZHHBikeModel,PlanInfoView;
@protocol PlanInfoViewDelegate <NSObject>

/**
 点击预约按钮
 */
-(void)clickOrderBtnHasLog:(UIButton *)sender;

/**
 点击

 @param sender <#sender description#>
 */
- (IBAction)clickMenuVCBtn:(UIButton *)sender;

//- (void)planInfoView:(PlanInfoView  *)planInfoView button:(UIButton *)button;

@end

/*
 展示起点终点交通信息的View
 */
@interface PlanInfoView : UIView

/**
 预约单车
 */
@property (weak, nonatomic) IBOutlet UIButton *orderBtn;

/**
 线路规划模型
 */
@property (strong ,nonatomic) PlanResult *result;

/**
 代理,需实现PlanInfoViewDelegate协议
 */
@property (weak, nonatomic) id <PlanInfoViewDelegate> delegate;

@property (nonatomic, strong)ZHHBikeModel *modelBike;///<标注#>
/**
 创建实例对象

 @return 实例对象
 */
+(instancetype)planInfoView;

@end
