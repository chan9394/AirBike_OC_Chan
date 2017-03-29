//
//  ThroughTrackInfoView.h
//  AirBk
//
//  Created by 郑洪浩 on 2016/10/19.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ThroughTrackInfoView;
@class ZHHgetCyclingStatusModel;
@protocol ThroughTrackInfoViewDelegate <NSObject>

-(void)pushLoclkFailedVC;
-(void)showHowToLockView;

@end

@interface ThroughTrackInfoView : UIView

/**
 骑行距离文本框
 */
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

/**
 代理,需实现ThroughTrackInfoViewDelegate协议
 */
@property (weak, nonatomic) id<ThroughTrackInfoViewDelegate> delegate;
@property (nonatomic, copy)NSString *deviceId;  //
@property (nonatomic, strong)ZHHgetCyclingStatusModel *model; ///<标注#>
/**
 创建实例对象

 @return 实例对象
 */
+(instancetype)throughTrackInfoView;

@end
