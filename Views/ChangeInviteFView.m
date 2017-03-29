//
//  ChangeInviteFView.m
//  AirBk
//
//  Created by 郑洪浩 on 2017/1/4.
//  Copyright © 2017年 ZHH. All rights reserved.
//

#import "ChangeInviteFView.h"
#import "UIImage+ImageEffects.h"
#import "ZHHGetUserInfoMod.h"
#define kALPHANUM @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

@interface ChangeInviteFView () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *messageLb;    //中间显示的信息

@property (weak, nonatomic) IBOutlet UIButton *leftBtn;         //左侧的按钮

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;   //取消的按钮

@property (weak, nonatomic) IBOutlet UIView *containerView;     //弹框

@property (weak, nonatomic) IBOutlet UIImageView *backIv;       //背景模糊效果

@property (weak, nonatomic) IBOutlet UITextField *textF;// 输入框

@end
@implementation ChangeInviteFView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(instancetype)changeInviteFview{
    ChangeInviteFView *view = [[NSBundle mainBundle] loadNibNamed:@"ChangeInviteFView" owner:nil options:nil][0];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:view action:@selector(clickCancleBtn:)];
    [view addGestureRecognizer:tap];
    return view;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    _containerView.layer.cornerRadius = 10;
    [_containerView.layer masksToBounds];
    UIImage *image = [UIImage getScreenImage];
    image =  [image applyBlurWithRadius:5 tintColor:[UIColor colorWithWhite:0.5 alpha:0.2] saturationDeltaFactor:1.8 maskImage:nil];
    _backIv.image = image;
    self.textF.layer.cornerRadius = self.textF.height*0.5;
    self.textF.layer.masksToBounds = YES;
    self.textF.delegate = self;
    [_textF becomeFirstResponder];
    [self bringSubviewToFront:_containerView];
}

- (IBAction)changeInviteF:(UIButton *)sender {
    
    [NetWorks changeinviteFriNum:self.textF.text andSuccessed:^(id response) {
//        NSString *invit_code = response[@"result"][@"invit_code"] ;
//        ZHHGetUserInfoMod *mod = [ZHHUserInfo shareGetUserInfoMod];
        GLOBAL_MANAGER.userModel.invitCode = response[@"result"][@"invit_code"];
//        [mod setValue:invit_code forKeyPath:@"user.invit_code"];
//        [ZHHUserInfo keyedArchiverGetUserInfoMod:mod];
        if ([self.delegate respondsToSelector:@selector(viewWillAppear:)]) {
            [self.delegate viewWillAppear:YES];
        }
        [self clickCancleBtn:nil];
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    if (textField.text.length > 10) {
        textField.text = [textField.text substringToIndex:10];
    }
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:kALPHANUM] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}


- (IBAction)clickCancleBtn:(UIButton *)sender {
    [self removeFromSuperview];
}
@end
