//
//  UnlockingView.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/10/19.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "UnlockingView.h"

@interface UnlockingView ()

@property (weak, nonatomic) IBOutlet UIImageView *progressImg;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *progressBGImg;
@property (nonatomic, copy)NSString *deviceId;
@property (assign, nonatomic) CGFloat timePro;
@property (weak, nonatomic) NSTimer *timer;


@end

@implementation UnlockingView

+(instancetype)unlockingView{
    
    UnlockingView *view = [[NSBundle mainBundle] loadNibNamed:@"UnlockingView" owner:nil options:nil].firstObject;
    [view viewDidMoveToSuperview];
    return view;
    
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    self.timePro = 0;
    self.progressImg.width = 0;
}



- (void)viewDidMoveToSuperview {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerAnimated:) userInfo:nil repeats:YES];;
}

-(void)timerAnimated:(NSTimer *)timer{
    self.timePro += 0.5;
    
    CGFloat progress = (self.progressImg.width/self.progressBGImg.width)*100;

    if (progress >= 98) {
        [timer invalidate];
        timer = nil;
        [self performSelector:@selector(faildLock) withObject:nil];
        
    }else{
        
//        [UIView animateWithDuration:0.1 animations:^{
            self.progressImg.width  = self.timePro ;
//        }];
        NSString *proLStr = [NSString stringWithFormat:@"%.f%%",progress];
        self.progressLabel.text = proLStr;
        
    }

}
-(void)outingBikeAnimate{

    [self performSelector:@selector(scanViewSuccessOut) withObject:nil afterDelay:1.5];
    
}

-(void)scanViewSuccessOut{

    if ([self.delegate respondsToSelector:@selector(scanSuccessScanView:)]) {
        [self.delegate scanSuccessScanView:self.deviceId];
    }
    
}

//接受到成功开锁的信息
- (void)successOpenLock:(NSString *)deviceId{
    self.deviceId = deviceId;
    
    [self.timer invalidate];
    self.timer = nil;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.progressImg.width  = self.progressBGImg.width;
        self.progressLabel.text = @"100%";
    } completion:^(BOOL finished) {
        [self outingBikeAnimate];
    }];

    
}
-(void)faildLock{
    
    [self.timer invalidate];
    self.timer = nil;
    
    if([self.delegate respondsToSelector:@selector(faildLockFinishTimer)]){
        [self.delegate faildLockFinishTimer];
    }
    
    [self removeFromSuperview];
   
}


@end
