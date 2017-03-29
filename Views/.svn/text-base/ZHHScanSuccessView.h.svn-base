//
//  ZHHScanSuccessView.h
//  AirBk
//
//  Created by 郑洪浩 on 2016/12/5.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^failed)();

@interface ZHHScanSuccessView : UIView

@property (nonatomic, weak)UIVisualEffectView *effectView;//毛玻璃
@property (nonatomic, strong)failed  failed ;
+(instancetype)scanSuccessViewPushedLabel:(NSString *)text andLabelDetail:(NSString *)detail;
+(ZHHScanSuccessView *)showViewAtAppKeyWindowsWithTitleText:(NSString *)text andDetailText:(NSString *)detatil;
@end
