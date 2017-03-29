//
//  ZHHReportDisobeyVC.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/10/28.
//  Copyright © 2016年 ZHH. All rights reserved.
//
#import "ZHHReportDisobeyVC.h"
#import "ZHHPicketPhotoVC.h"
#import <Photos/Photos.h>
#import "ZHHScanVC.h"
#import "ZHHUploadBikeProModel.h"
#import "UIImage+ZHHImageEncodeCat.h"
#import "ReportSuccessVC.h"
#import "UIButton+Color.h"

@interface ZHHReportDisobeyVC ()<UITextViewDelegate,ZHHPicketPhotoVCDelegate,ZHHScanVCDelegate,ReminderViewDelegate>

@property (nonatomic,   copy) NSString                          *bikeId;            //扫描得到的单车id
@property (nonatomic, strong) UIImage                           *bikeImage;      //停车照片
@property (weak,   nonatomic) IBOutlet UIButton             *commitBtn;
@property (weak,   nonatomic) IBOutlet UIButton             *picjImageBtn;
@property (weak,   nonatomic) IBOutlet UILabel               *bikeIdAgainLab;
@property (weak,   nonatomic) IBOutlet UILabel               *bikeIdLab;
@property (weak,   nonatomic) IBOutlet UILabel               *needBikeIdLab;
@property (weak,   nonatomic) IBOutlet UIScrollView        *scrollView;
@property (weak,   nonatomic) IBOutlet UITextView          *remark;
@property (weak,   nonatomic) UILabel                            *labelRemark;

@end


@implementation ZHHReportDisobeyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubViews];
    [self setNavigationItem];
    [self registerForKeyboardNotifications];
    _commitBtn.type = ButtonTypeDisabled;
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapInScrollView)];
    tapGR.numberOfTapsRequired = 1;
    tapGR.numberOfTouchesRequired = 1;
    [self.scrollView addGestureRecognizer:tapGR];
}

- (void)tapInScrollView {
    [self.view endEditing:YES];
}

- (void)setNavigationItem{
    [self setupTitleWithText:@"违规举报"];
}

- (void)setTrackModel:(TrackListModel *)trackModel{
    _trackModel = trackModel;
    self.bikeId = @"后台未返回";
    self.bikeIdLab.text = self.bikeId;
    [self changeLabeState];
}

- (void)registerForKeyboardNotifications
{
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
    
    if (dis>0) {
        self.scrollView.contentSize = CGSizeMake( self.scrollView.width, self.scrollView.height+dis);
        self.scrollView.contentOffset = CGPointMake(0, dis+10);
    }
}

- (void)keyboardWillBeHidden:(NSNotification *)anotification {
    self.scrollView.contentSize = CGSizeMake( self.scrollView.width, self.scrollView.height);
    self.scrollView.contentOffset = CGPointMake(0, 0);

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)setSubViews {
    self.remark.delegate = self;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(3, 3, 200, 20)];
    self.labelRemark = label;
    label.enabled = NO;
    label.text = @"最多可输入200个字符";
    label.font =  [UIFont systemFontOfSize:15];
    label.textColor = [UIColor lightGrayColor];
    [self.remark addSubview:label];
    [_remark setCornerRadiusWithRadius:10];
    [_picjImageBtn setCornerRadiusWithRadius:10];
    [_commitBtn setCornerRadius];
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

- (IBAction)picturePickerVC:(UIButton *)sender {
    ZHHPicketPhotoVC *vc =[[ZHHPicketPhotoVC alloc] init];
    vc.delegate = self;
    [self.view addSubview:vc.view];
    [self addChildViewController:vc];
}

- (void)hhPickerController:(ZHHPicketPhotoVC *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.bikeImage = image;
    [self.picjImageBtn setImage:image forState:UIControlStateNormal];
    [self changeCommitBtnState];
}

- (IBAction)showScanVC:(UIButton *)sender {
    ZHHScanVC *vc = [[ZHHScanVC alloc] init];
    vc.view.frame = self.view.frame;
    vc.result = getBikeId;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)unlockResult:(NSString *)result {
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
- (BOOL)commintBtnCanClick{
    if (self.bikeId && ![self.remark.text isEqualToString:@""]) {
        NSLog(@"%@",self.remark.text);
        return YES;
    }
    return NO;
}

//设置commit按钮的状态
-(void)changeCommitBtnState{
    
    if ([self commintBtnCanClick]) {
        self.commitBtn.type = ButtonTypeNormal;
    } else {
        self.commitBtn.type = ButtonTypeDisabled;
    }
    
}
-(NSString *)dataFile{
    NSArray *ar = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString *fielpath = [ar objectAtIndex:0];
    return [fielpath stringByAppendingPathComponent:@"user.data"];
    //改修后缀名，以免与属性列表创建的文件重复，而加载成旧的的文件。 不用查字典了。。archive表归档
}


- (IBAction)popReportDisobeyVC:(UIButton *)sender {
    NSString  *imageStr = [self.bikeImage encodeImageToBase64];
    imageStr = imageStr ? imageStr : [[UIImage imageNamed:@"LOGO"] encodeImageToBase64];
    [NetWorks reportQuestionWithType:@"service" andCategory:@"1" andPictures:imageStr andDescription:self.remark.text andSuccessed:^(id response) {
        ReportSuccessVC *vc = [[ReportSuccessVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } failed:^{
        ReminderView *view = [ReminderView reminderViewWithMessage:@"提交失败" btnTitle:@"确定"];
        view.delegate = self;
        [[UIApplication sharedApplication].keyWindow addSubview:view];
    }];
}


@end
