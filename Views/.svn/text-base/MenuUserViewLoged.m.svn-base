//
//  MenuUserViewLoged.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/12/30.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "MenuUserViewLoged.h"

@interface MenuUserViewLoged ()

@property (weak, nonatomic) IBOutlet UILabel *nickNameLab;
@property (weak, nonatomic) IBOutlet UILabel *totalMileLab;
@property (weak, nonatomic) IBOutlet UILabel *aveSpeedLab;
@property (weak, nonatomic) IBOutlet UIImageView *headIv;

@end

@implementation MenuUserViewLoged

+ (instancetype)menuUserViewLoged {
    MenuUserViewLoged *view = [[[NSBundle mainBundle] loadNibNamed:@"MenuUserViewLoged" owner:nil options:nil] firstObject];
    [view setSubViews];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:view action:@selector(clickHeadIv)];
    view.headIv.userInteractionEnabled = YES;
    [view.headIv addGestureRecognizer:tap];
    return view;
}

- (void)setSubViews {
    AccountManager *manager = [AccountManager shareAccountManager];
    if (manager.urlStr) {
        [_headIv loadImageUrlStr:manager.urlStr placeHolderImageName:nil radius:CGFLOAT_MIN];
    }
    self.nickNameLab.text = manager.userModel.nickName;
    self.totalMileLab.text = manager.userModel.mileage;
    NSString *mileage = GLOBAL_MANAGER.userModel.mileage;
    NSString *minutes = GLOBAL_MANAGER.userModel.cyclingMinutes;
    if (mileage && minutes) {
        float avg = [mileage floatValue] * 60 / [minutes floatValue];
        if(avg > 0) {
            self.aveSpeedLab.text = [NSString stringWithFormat:@"%.2f",avg];
        }
    }
}

- (void)clickHeadIv {
    if ([self.delegate respondsToSelector:@selector(menuVCPushUserInfoVC)]) {
        [self.delegate menuVCPushUserInfoVC];
    }
}

- (IBAction)clickCreditBtn:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(pushCredcitVC)]) {
        [self.delegate pushCredcitVC];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
}
@end
