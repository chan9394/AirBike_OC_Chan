//
//  ZHHLastTrackView.h
//  AirBk
//
//  Created by 郑洪浩 on 2016/10/31.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TrackListModel;
@protocol ZHHLastTrackViewDelegate <NSObject>

/**
 点击了推出历史骑行记录按钮
 */
-(void)clicktoPushLastTrackTvc;

@end

@interface ZHHLastTrackView : UIView

/**
 代理 需要遵守ZHHLastTrackViewDelegate协议
 */
@property (nonatomic,weak) id<ZHHLastTrackViewDelegate> delegate;

/**
 帮助按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *helpBtn;

@property (nonatomic, strong)TrackListModel *model;///<标注#>

/**
 实例化对象

 @return 实例对象
 */
+(instancetype)zhhLastTrackView;

@end
