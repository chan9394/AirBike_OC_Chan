//
//  ZHHChangePhoneNumVC.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/11/14.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHChangePhoneNumVC.h"

#import "UIButton+Color.h"
@interface ZHHChangePhoneNumVC ()

@property (weak,   nonatomic) IBOutlet UITextField          *idLab;
@property (weak,   nonatomic) IBOutlet UITextField          *nNumLab;
@property (weak,   nonatomic) IBOutlet UITextField          *verifyLab;
@property (weak,   nonatomic) IBOutlet UIView               *view1;
@property (weak,   nonatomic) IBOutlet UIView               *view2;
@property (weak,   nonatomic) IBOutlet UIView               *view3;
@property (weak,   nonatomic) IBOutlet UIButton             *veryBtn;
@property (weak,   nonatomic) IBOutlet UIButton             *commitBtn;
@property (nonatomic,   weak) NSTimer                          *timer;             //定时器
@property (nonatomic,   weak) ZHHChangePhoneNumVC *weakSelf;
@property (nonatomic, assign) NSInteger                         seconds;  //定时器秒
@end

@implementation ZHHChangePhoneNumVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _weakSelf = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupTitleWithText:@"手机号更换"];
    self.navigationController.navigationBar.translucent = NO;
    self.view1.layer.cornerRadius = 0.5*self.view1.height;
    self.view1.layer.masksToBounds = YES;
    self.view2.layer.cornerRadius = 0.5*self.view2.height;
    self.view2.layer.masksToBounds = YES;
    self.view3.layer.cornerRadius = 0.5*self.view3.height;
    self.view3.layer.masksToBounds = YES;
    self.veryBtn.layer.cornerRadius = 0.5*self.veryBtn.height;
    self.veryBtn.layer.masksToBounds = YES;
    self.commitBtn.layer.cornerRadius = 0.5*self.commitBtn.height;
    self.commitBtn.layer.masksToBounds = YES;
    [self.timer invalidate];
    self.timer = nil;
}

- (IBAction)clickChangePhoNumBtn:(UIButton *)sender {
    [NetWorks changePhoneNumNetWorkWithPhoneN:self.nNumLab.text andVariNum:self.verifyLab.text andSuccess:^(id response) {
        [HHProgressHUD showHUDInView:self.view.superview animated:YES withText:@"更改手机号成功"];
        [[AccountManager shareAccountManager].userModel modelWIthJSON:response[@"result"]];
        [self clickBackBtn];
    }];
    
}
- (IBAction)clickGetVerifuMode:(UIButton *)sender {
    if ([_idLab.text isEqualToString:@""]) {
        [HHProgressHUD showHUDInView:GLOBAL_KEYWINDOW animated:YES withText:@"无身份证号"];
        return ;
    }
    if ([_nNumLab.text isEqualToString:@""]) {
        [HHProgressHUD showHUDInView:GLOBAL_KEYWINDOW animated:YES withText:@"无手机号"];
        return ;
    }
    [self.timer invalidate];
    self.timer = nil;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeGo) userInfo:nil repeats:YES];
    self.veryBtn.type = ButtonTypeDisabled;
    self.seconds = 60;
    [NetWorks getCheckCodeWithMobile:GLOBAL_MANAGER.userModel.mobile successBlock:^(id respense) {
        NSLog(@"%@",respense);
        sender.type = ButtonTypeNormal;
    }];
    
}
#pragma mark - 定时器方法  -
- (void)timeGo {
    if (_seconds <= 0) {
        [_weakSelf.timer invalidate];
        _weakSelf.timer = nil;
        _weakSelf.veryBtn.type = ButtonTypeNormal;
        [_weakSelf.veryBtn setTitle:@"获取验证码" forState:UIControlStateNormal];

    } else {
        [_weakSelf.veryBtn setTitle:[NSString stringWithFormat:@"%lds",(long)_seconds] forState:UIControlStateNormal];
        _seconds -= 1;
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)clickBackBtn {
    [self.timer invalidate];
    self.timer = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
    
}
@end
