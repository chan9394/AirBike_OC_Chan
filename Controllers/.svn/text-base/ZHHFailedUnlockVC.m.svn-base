//
//  ZHHFailedUnlockVC.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/11/1.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHFailedUnlockVC.h"
#import "ZHHScanVC.h"
#import "ZHHUploadBikeProModel.h"
#import "UIButton+Color.h"
#import "ReportSuccessVC.h"
#import "UIImage+ZHHImageEncodeCat.h"

@interface ZHHFailedUnlockVC ()<ZHHScanVCDelegate,UITextViewDelegate, ReminderViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *remark;
@property (nonatomic, weak)UILabel *labelRemark;//textview的标注
@property (nonatomic, copy)NSString *bikeId;//扫描得到的单车id
@property (weak, nonatomic) IBOutlet UILabel *needBikeIdLab;
@property (weak, nonatomic) IBOutlet UILabel *bikeIdAgainLab;
@property (weak, nonatomic) IBOutlet UILabel *bikeIdLab;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *wordNum;
@property (weak, nonatomic) IBOutlet UITextView *messageTv;

@end

@implementation ZHHFailedUnlockVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubViews];
    [self registerForKeyboardNotifications];
    _commitBtn.type = ButtonTypeDisabled;
    [_commitBtn setupStatusBackgroundColor];
    [_messageTv setCornerRadiusWithRadius:10];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapInScrollView)];
    tapGR.numberOfTapsRequired = 1;
    tapGR.numberOfTouchesRequired = 1;
    [self.scrollView addGestureRecognizer:tapGR];
}

- (void)tapInScrollView {
    [self.view endEditing:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_remark resignFirstResponder];
}

- (void)registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)keyboardWasShown:(NSNotification *)anotification {
    CGRect keyboardFrame = [[anotification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat btnMaxY = CGRectGetMaxY(self.commitBtn.frame);
    CGFloat dis = keyboardFrame.size.height - (self.view.height - btnMaxY);
    NSLog(@"%f",dis);
    
    if (dis>0) {
        self.scrollView.contentSize = CGSizeMake( self.scrollView.width, self.scrollView.height+dis);
        self.scrollView.contentOffset = CGPointMake(0, dis+10);
    }
}

- (void)keyboardWillBeHidden:(NSNotification *)anotification {
    self.scrollView.contentSize = CGSizeMake( self.scrollView.width, self.scrollView.height);
    self.scrollView.contentOffset = CGPointMake(0, 0);
}

#pragma mark - 键盘确定隐藏键盘  -
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    if (_remark.text.length > 99) {
        _remark.text = [_remark.text substringToIndex:99];
    }
    return YES;
}

- (void) textViewDidChange:(UITextView *)textView{
    self.wordNum.text = [NSString stringWithFormat:@"%lu",(unsigned long)[textView.text length]];
    
    if ([textView.text length] == 0) {
        [self.labelRemark setHidden:NO];
    }else{
        [self.labelRemark setHidden:YES];
    }
    [self changeCommitBtnState];
}

- (IBAction)showScanVC:(UIButton *)sender {
    ZHHScanVC *vc = [[ZHHScanVC alloc] init];
    vc.view.frame = self.view.frame;
    vc.result = getBikeId;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)unlockResult:(NSString *)result{
    if (self.bikeId == nil) {
        [self changeLabeState];
    }
    self.bikeId = result;
    self.bikeIdLab.text = result;
    [self changeCommitBtnState];
}

//已输入单车id更改label状态
- (void)changeLabeState {
    self.needBikeIdLab.hidden = YES;
    self.bikeIdLab.hidden = NO;
    self.bikeIdAgainLab.hidden = NO;
}

//判断是否让提交按钮可按
- (BOOL)commintBtnCanClick {
    if (self.bikeId  && ![self.remark.text isEqualToString:@""]) {
        //          if (![self.remark.text isEqualToString:@""]) {
        NSLog(@"%@",self.remark.text);
        return YES;
    }
    return NO;
}

//设置commit按钮的状态
- (void)changeCommitBtnState {
    
    if ([self commintBtnCanClick]) {
        //        self.commitBtn.enabled = YES;
        _commitBtn.type = ButtonTypeNormal;
    } else {
        _commitBtn.type = ButtonTypeDisabled;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupTitleWithText:@"用户指南"];
}

- (void)setSubViews {
    self.remark.delegate = self;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(3, 3, 200, 20)];
    self.labelRemark = label;
    label.enabled = NO;
    label.text = @"最多可输入100个字符";
    label.font =  [UIFont systemFontOfSize:15];
    label.textColor = [UIColor lightGrayColor];
    [self.remark addSubview:label];
    [_commitBtn setCornerRadius];
}

- (IBAction)popReportDisobeyVC:(UIButton *)sender {
    NSString  *imageStr = [[UIImage imageNamed:@"LOGO"] encodeImageToBase64];
    
    [NetWorks reportQuestionWithType:@"report" andCategory:@"3" andPictures:imageStr andDescription:self.remark.text andSuccessed:^(id response) {
        ReportSuccessVC *vc = [[ReportSuccessVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } failed:^{
        ReminderView *view = [ReminderView reminderViewWithMessage:@"提交失败" btnTitle:@"确定"];
        view.delegate = self;
        [[UIApplication sharedApplication].keyWindow addSubview:view];
    }];
}

- (void)reminderViewDidClickLeftBtn {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
