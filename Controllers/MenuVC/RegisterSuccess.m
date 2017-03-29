//
//  RegisterSuccess.m
//  AirBk
//
//  Created by Damo on 2017/2/7.
//  Copyright © 2017年 ZHH. All rights reserved.
//

#import "RegisterSuccess.h"

@interface RegisterSuccess () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView         *inviteView;
@property (weak, nonatomic) IBOutlet UIButton      *commitBtn;  //确定
@property (weak, nonatomic) IBOutlet UITextField   *numberTf;   // 邀请码

@end

@implementation RegisterSuccess

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _inviteView.layer.cornerRadius = _inviteView.height / 2;
    _inviteView.clipsToBounds = YES;
    _numberTf.delegate = self;
    [_commitBtn setCornerRadius];
    [_commitBtn setupStatusBackgroundColor];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationLeftItemNil];
    [self setupTitleWithText:@"注册完成"];
    [_numberTf becomeFirstResponder];
}

- (IBAction)actionCommitBtn:(id)sender {
    if([_numberTf.text isEqualToString:@""]) {
        [HHProgressHUD showHUDInView:GLOBAL_KEYWINDOW animated:YES withText:@"您还未填写邀请码"];
        return;
    }
    [NetWorks bindInviteCode:_numberTf.text successBlock:^(id respense) {
        [self actionPassBtn:nil];
    }];
}

- (IBAction)actionPassBtn:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
