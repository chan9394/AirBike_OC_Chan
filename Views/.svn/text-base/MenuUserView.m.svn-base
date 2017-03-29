//
//  MenuUserView.m
//  Mobike
//
//  Created by 郑洪浩 on 16/10/13.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "MenuUserView.h"

@interface MenuUserView ()

@property (weak, nonatomic) IBOutlet UIButton *userIcon;
@property (weak, nonatomic) IBOutlet UIButton *userBtn;

@end

@implementation MenuUserView

+ (instancetype)userView{
    MenuUserView *user =[[NSBundle mainBundle] loadNibNamed:@"MenuUserView" owner:nil options:nil].firstObject;
    return user;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _userBtn.backgroundColor = GLOBAL_ASSISTCOLOR;
    [self.userBtn setCornerRadiusWithRadius:_userBtn.height / 2];
}

- (IBAction)clickRegisterBtn:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(pushRegisterVC)]) {
        [self.delegate pushRegisterVC];
    }
}

@end
