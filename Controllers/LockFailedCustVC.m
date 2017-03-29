//
//  LockFailedCustVC.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/12/28.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "LockFailedCustVC.h"
#import "UIButton+Color.h"
#import "ZHHPicketPhotoVC.h"

@interface LockFailedCustVC ()<ZHHPicketPhotoVCDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *commintBtn;
@property (weak, nonatomic) IBOutlet UIButton *cameraBtn;
@property (nonatomic, strong)UIImage *bikeImage;//停车照片
@property (weak, nonatomic) IBOutlet UITextView *remark;
@property (weak, nonatomic) UILabel *labelRemark;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHConstraint;
@end

@implementation LockFailedCustVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.remark.delegate = self;
    [self setupTitleWithText:@"用户指南"];
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(3, 3, 200, 20)];
    label1.enabled = NO;
    label1.text = @"最多可输入200个字符";
    label1.font =  [UIFont systemFontOfSize:15];
    label1.textColor = [UIColor lightGrayColor];
    self.labelRemark = label1;
    [self.remark addSubview:label1];

//    self.commintBtn.layer.cornerRadius = 0.5*self.commintBtn.height;
//    self.commintBtn.layer.masksToBounds = YES;
    [_commintBtn setupStatusBackgroundColor];
    [_remark setCornerRadiusWithRadius:10];
    [_cameraBtn setCornerRadiusWithRadius:10];
    [self registerForKeyboardNotifications];
    _commintBtn.type = ButtonTypeDisabled;
    // Do any additional setup after loading the view from its nib.
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapInScrollView)];
    tapGR.numberOfTapsRequired = 1;
    tapGR.numberOfTouchesRequired = 1;
    [self.scrollView addGestureRecognizer:tapGR];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_commintBtn setCornerRadiusWithRadius:_commintBtn.height / 2];
}

-(void)tapInScrollView{
    [self.view endEditing:YES];
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    if (textView.text.length > 199) {
        textView.text = [textView.text substringToIndex:199];
    }
    
    return YES;
}

- (void) textViewDidChange:(UITextView *)textView{
    
    if ([textView.text length] == 0) {
        [self.labelRemark setHidden:NO];
    }else{
        [self.labelRemark setHidden:YES];
    }
    [self changeCommitBtnState];
    
}
- (void)registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)keyboardWasShown:(NSNotification *)anotification{
    CGRect keyboardFrame = [[anotification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat btnMaxY = CGRectGetMaxY(self.commintBtn.frame);

    CGFloat dis = keyboardFrame.size.height - (self.view.height - btnMaxY);
    NSLog(@"%f",dis);
    if (dis>0) {
        self.contentViewHConstraint.constant = self.scrollView.height+dis;
        
        self.scrollView.contentOffset = CGPointMake(0, dis+10);
    }
}
- (void)keyboardWillBeHidden:(NSNotification *)anotification{
    self.scrollView.contentSize = CGSizeMake( self.scrollView.width, self.scrollView.height);
    self.scrollView.contentOffset = CGPointMake(0, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)hhPickerController:(ZHHPicketPhotoVC *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.bikeImage = image;
    [self.cameraBtn setImage:image forState:UIControlStateNormal];
    [self changeCommitBtnState];
}

- (IBAction)clickTakeAphoto:(UIButton *)sender {
    ZHHPicketPhotoVC *vc =[[ZHHPicketPhotoVC alloc] init];
    vc.delegate = self;
    [self.view addSubview:vc.view];
    [self addChildViewController:vc];
}

#pragma mark - 提交  -
- (IBAction)actionCommitBtn:(id)sender {
    
}


//设置commit按钮的状态
-(void)changeCommitBtnState{
    if ([self commintBtnCanClick]) {
        self.commintBtn.type = ButtonTypeNormal;
    } else {
        self.commintBtn.type = ButtonTypeDisabled;
    }
}

//判断是否让提交按钮可按
-(BOOL)commintBtnCanClick{
    
    if (self.bikeImage && ![self.remark.text isEqualToString:@""]) {
        NSLog(@"%@",self.remark.text);
        return YES;
    }
    return NO;
}


@end
