//
//  ZHHRealNameVC.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/12/8.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHRealNameVC.h"

@interface ZHHRealNameVC () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameLab;  //真实姓名

@property (weak, nonatomic) IBOutlet UITextField *idLab;       //身份证

@property (weak, nonatomic) IBOutlet UIView *nameView;      //姓名View

@property (weak, nonatomic) IBOutlet UIView *idView;            //身份证View

@property (weak, nonatomic) IBOutlet UIButton *vertifyBtn;     //认证

@end

@implementation ZHHRealNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
     [self setupTitleWithText:GLOBAL_STR(@"RealNameTitle")];
    [self setupUI];
    _nameLab.delegate = self;
    _idLab.delegate = self;
}

- (void)setupUI {
    [self clipCornerRadiusWith:@[_idView,_nameView,_vertifyBtn]];
}



#pragma mark - 实名认证  -
- (IBAction)clickCommitBtn:(UIButton *)sender {
    [NetWorks authenticationForUser:@"123" andNum:self.idLab.text andName:self.nameLab.text andSuccessed:^(id response){
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    
}

- (IBAction)clickNoIdBtn:(UIButton *)sender {
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
@end
