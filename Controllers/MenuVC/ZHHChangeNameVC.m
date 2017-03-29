//
//  ZHHChangeNameVC.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/11/10.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHChangeNameVC.h"

@interface ZHHChangeNameVC () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTF;

@end

@implementation ZHHChangeNameVC

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.nameTF.text = [AccountManager shareAccountManager].userModel.nickName;
    self.nameTF.layer.cornerRadius = 0.5*self.nameTF.height;
    self.nameTF.layer.masksToBounds = YES;
    _nameTF.delegate = self;
}

- (IBAction)clickRBtn {
    [NetWorks changeNickNameNetWorkWithNickName:self.nameTF.text andSuccess:^(id response) {
        [HHProgressHUD showHUDInView:[UIApplication sharedApplication].keyWindow animated:YES withText:@"更改姓名成功"];
        [[AccountManager shareAccountManager].userModel modelWIthJSON:response[@"result"]];
        [self clickBackBtn];
    }];
}

- (IBAction)clickBackBtn {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.text.length > 10) {
        textField.text = [textField.text substringToIndex:10];
    }
    return YES;
}

@end
