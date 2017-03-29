//
//  ZHHReisterLogOnVC.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/11/3.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHReisterLogOnVC.h"
#import "EnterBtn.h"
#import "UIButton+Color.h"
#import "RegisterSuccess.h"

@interface ZHHReisterLogOnVC () <UITextFieldDelegate>

@property (weak,   nonatomic) IBOutlet UITextField                *phoneNum;    //手机号
@property (weak,   nonatomic) IBOutlet UITextField                *verifyT;         //验证码
@property (weak,   nonatomic) IBOutlet UIButton                   *verifyBtn;       //获取验证码
@property (weak,   nonatomic) IBOutlet EnterBtn                   *goBtn;           //进入airbike
@property (weak,   nonatomic) IBOutlet UIView                      *phoneView;
@property (weak,   nonatomic) IBOutlet UIView                      *verifyView;
@property (weak,   nonatomic) IBOutlet NSLayoutConstraint   *sideLayout;     //左右两侧 的约束
@property (weak,   nonatomic) IBOutlet NSLayoutConstraint   *topLayout;      //据上册的约束
@property (weak,   nonatomic) IBOutlet NSLayoutConstraint   *heightLayout;  //控件高度约束
@property (nonatomic,   weak)              NSTimer                   *timer;             //定时器
@property (nonatomic,   weak)              ZHHReisterLogOnVC *weakSelf;
@property (nonatomic, assign)              NSInteger                  seconds;          //定时器时间
@property (weak, nonatomic)  UIImageView *helpHintPic;//使用提醒
@property (weak, nonatomic)  UIButton *helpHintSkipBtn;//跳过使用提醒
@end

@implementation ZHHReisterLogOnVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupTitleWithText:@"手机验证"];
    [self clipCornerRadiusWith:@[_phoneView,_verifyView,_verifyBtn,_goBtn]];
    [_goBtn setupStatusBackgroundColor];
    [_verifyBtn setupHightLightedAndOutsidebackGroundColor];
    [self fitCurrentScreen];
    _phoneNum.delegate = self;
    _verifyT.delegate = self;
    _verifyBtn.type = ButtonTypeNormal;
    _weakSelf = self;
    [self.timer invalidate];
    self.timer = nil;
    
    
}

-(void)skipHelpHint{
    
    [self.helpHintSkipBtn removeFromSuperview];
    [self.helpHintPic removeFromSuperview];
    
}

- (void)clipCornerRadiusWith:(NSArray <UIView *>*)array {
    [array enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.layer.cornerRadius = _heightLayout.constant / 2;
        [obj.layer masksToBounds];
    }];
}

#pragma mark - 下一步  -
- (IBAction)clickStartBtn:(UIButton *)sender {
    if (self.verifyT.text.length != 4 || self.phoneNum.text.length != 11) {
        [HHProgressHUD showHUDInView:[UIApplication sharedApplication].keyWindow animated:YES withText:@"请检查手机号或验证码是否正确"];
        return;
    }
   __block BOOL first = NO;
    
    [NetWorks registNetWorkWithVerify:self.verifyT.text andFriendInvitNum:@"123456" andPhoNum:self.phoneNum.text andSuccessed:^(id response) {
        //注册成功后进入跳入邀请码界面
        first = YES;
    } logSuccess:^(id response) {
        AccountManager *manager = [AccountManager shareAccountManager];
        [manager modelWIthJSON:response];
        [HHProgressHUD showHUDInView:self.view.superview animated:YES withText:@"登陆成功"];
        if (first == YES) {
            [self.navigationController pushViewController:[[RegisterSuccess alloc] init] animated: YES];
            return ;
        }
        if (self.logOnHandle) {
            self.logOnHandle();
        } else {
                [self.navigationController popViewControllerAnimated:YES];
          
        }
    }];
}

#pragma mark - 获取验证码  -
- (IBAction)actionVerifyBtn:(UIButton *)sender {
    
    [NetWorks getCheckCodeWithMobile:self.phoneNum.text successBlock:^(id respense) {
         NSLog(@"%@",respense);
         sender.type = ButtonTypeNormal;
        
        _weakSelf.seconds = 60;
        //    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeGo) userInfo:nil repeats:YES];
        NSTimer *timer = [NSTimer timerWithTimeInterval:1.0f target:_weakSelf selector:@selector(timeGo) userInfo:nil repeats:YES];
        _weakSelf.timer = timer;
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        _weakSelf.verifyBtn.type = ButtonTypeDisabled;
 }];
}

#pragma mark - 定时器方法  -
- (void)timeGo {

    if (self.seconds <= 0) {
        [_weakSelf.timer invalidate];
        _weakSelf.timer = nil;
        _weakSelf.verifyBtn.type = ButtonTypeNormal;
        [_weakSelf.verifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    } else {
        [_weakSelf.verifyBtn setTitle:[NSString stringWithFormat:@"%lds",(long)self.seconds] forState:UIControlStateNormal];
        self.seconds -= 1;
    }
}

#pragma mark - 用户协议annual  -
- (IBAction)actionUserProtocolBtn:(id)sender {
    [self pushWKWebViewController];
}

#pragma mark -  屏幕适配  -
- (void)fitCurrentScreen {
    if (GLOBAL_SCREENW < 375) {
        _heightLayout.constant = 40;
        _verifyBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        _sideLayout.constant = 12;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark - 控制器跳转  -
- (void)pushWKWebViewController {
    WKWebViewController *vc = [WKWebViewController webVCWithTitlt:@"用户协议" type:WKWebVCTypeUserProtocol];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickBackBtn {
    [self.timer invalidate];
    self.timer = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
}

@end
