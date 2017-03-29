//
//  ZHHOrderBikeView.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/11/4.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHOrderBikeView.h"
#import "ZHHBikeModel.h"
@interface ZHHOrderBikeView () <ReminderViewDelegate>

@property (weak,   nonatomic) IBOutlet UILabel   *destinationLab;
@property (weak,   nonatomic) IBOutlet UILabel   *bikeIdLab;
@property (weak,   nonatomic) IBOutlet UILabel   *timeLab;
@property (weak,   nonatomic) IBOutlet UIButton *quitOrderBtn;
@property (weak,   nonatomic) NSTimer              *timer;


@end

@implementation ZHHOrderBikeView


- (void)setDestinationAnnotation:(POIAnnotation *)destinationAnnotation{
    _destinationAnnotation = destinationAnnotation;
    self.destinationLab.text = destinationAnnotation.title;
    self.bikeIdLab.text = destinationAnnotation.modelBike.device_id;
}

- (void)setLocation:(NSString *)location {
    _location = location;
    self.destinationLab.text = location;
}

- (void)setDeviceId:(NSString *)deviceId {
    _deviceId = deviceId;
    self.bikeIdLab.text = deviceId;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.quitOrderBtn.layer.cornerRadius = 0.5*self.quitOrderBtn.height;
    self.quitOrderBtn.layer.masksToBounds = YES;
}

+ (instancetype)orderBikeView {
    ZHHOrderBikeView *view =[[NSBundle mainBundle] loadNibNamed:@"OrderBikeView" owner:nil options:nil].firstObject;
//    view.seconds = 900;
    view.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:view selector:@selector(timerGo:) userInfo:view repeats:YES];
    return view;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_quitOrderBtn setCornerRadiusWithRadius:_quitOrderBtn.height / 2];
}

- (void)timerGo:(NSTimer *)timer {
    ZHHOrderBikeView *view = ((ZHHOrderBikeView *)timer.userInfo);
    view.seconds -=1;
    NSInteger min = view.seconds/60;
    NSInteger sec = view.seconds%60;
    view.timeLab.text = [NSString stringWithFormat:@"%02ld:%02ld",(long)min,(long)sec];
    
    if (view.seconds == 0) {
        [timer invalidate];
        [view.delegate clickCancleOrderBtn];
        [HHProgressHUD showHUDInView:(UIView *)view.delegate animated:YES withText:@"计时结束"];
    }
}
- (void)removeFromSuperview {
    [self.timer invalidate];
    self.timer=nil;
    [super removeFromSuperview];
}

- (IBAction)clickQuitOrdBtn:(UIButton *)sender {
    ReminderView *view = [ReminderView reminderViewWithMessage:@"您确定要取消预约?" leftBtnTitle:@"确定" rightBtnTitle:@"取消"];
    view.delegate = self;
    [[UIApplication sharedApplication].keyWindow addSubview:view];
}

- (void)reminderViewDidClickLeftBtn {
    NSString *device = self.deviceId ? self.deviceId : self.destinationAnnotation.modelBike.device_id;
    [NetWorks cancleOrderBikeNetWorkWithDeviceId:device andSuccessed:^(id response) {
        [self.timer invalidate];
        self.timer = nil;
        if ([self.delegate respondsToSelector:@selector(clickCancleOrderBtn)]) {
            [self.delegate clickCancleOrderBtn];
        }
    }];
}

@end
