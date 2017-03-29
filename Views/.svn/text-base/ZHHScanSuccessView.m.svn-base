//
//  ZHHScanSuccessView.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/12/5.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHScanSuccessView.h"

@interface ZHHScanSuccessView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UIView *viewBig;


@end
@implementation ZHHScanSuccessView

+(instancetype)scanSuccessViewPushedLabel:(NSString *)text andLabelDetail:(NSString *)detail{
    
    ZHHScanSuccessView *view = [[NSBundle mainBundle] loadNibNamed:@"ScanSuccessView" owner:nil options:nil].firstObject;
    view.titleLab.text = text;
    view.detailLab.text = detail;
    view.viewBig.layer.cornerRadius = 10;
    view.viewBig.layer.masksToBounds = YES;
    return view;
}

- (void)tap:(UITapGestureRecognizer *)tap {
    [self removeFromSuperview];
    [self.effectView removeFromSuperview];
}

- (IBAction)clickOKBtn:(UIButton *)sender {
    [UIView animateWithDuration:0.5 animations:^{
//        self.y = -self.height;
    } completion:^(BOOL finished) {
        if (self.failed) {
            self.failed();
        }
        [self removeFromSuperview];
        [self.effectView removeFromSuperview];
    }];
}

+(ZHHScanSuccessView *)showViewAtAppKeyWindowsWithTitleText:(NSString *)text andDetailText:(NSString *)detatil {
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = CGRectMake(0,0 , [UIApplication sharedApplication].keyWindow.frame.size.width, [UIApplication sharedApplication].keyWindow.frame.size.height);
    effectView.alpha = 0.4;
    [[UIApplication sharedApplication].keyWindow addSubview:effectView];
    ZHHScanSuccessView *view = [self scanSuccessViewPushedLabel:text andLabelDetail:detatil];
    view.effectView = effectView;
    view.frame = [UIScreen mainScreen].bounds;
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:view action:@selector(tap:)];
    [view addGestureRecognizer:tap];
    return view;
}


@end
