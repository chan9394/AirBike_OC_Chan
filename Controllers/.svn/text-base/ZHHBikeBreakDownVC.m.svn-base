//
//  ZHHBikeBreakDownVC.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/11/1.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHBikeBreakDownVC.h"
#import "ZHHPicketPhotoVC.h"
#import "ZHHScanVC.h"
#import "ZHHUploadBikeProModel.h"
#import "UIButton+Color.h"
#import "UIImage+ZHHImageEncodeCat.h"
#import "ReportSuccessVC.h"

@interface ZHHBikeBreakDownVC ()<ZHHPicketPhotoVCDelegate,ZHHScanVCDelegate,UITextViewDelegate,ZHHScanVCDelegate, ReminderViewDelegate>

@property (nonatomic,   copy) NSString                      *bikeId;           //扫描得到的单车id
@property (nonatomic, strong) NSMutableArray           *btnSelAry;      //选中的故障
@property (nonatomic, strong) UIImage                       *bikeImage;     //停车照片
@property (nonatomic,   weak) UILabel                       *labelRemark;  //textview的标注
@property (weak,   nonatomic) IBOutlet UIButton        *commitBtn;     //提交
@property (weak,   nonatomic) IBOutlet UIButton        *picjImageBtn;  //拍摄单车照片
@property (weak,   nonatomic) IBOutlet UILabel         *bikeIdAgainLab;
@property (weak,   nonatomic) IBOutlet UILabel         *bikeIdLab;
@property (weak,   nonatomic) IBOutlet UILabel         *needBikeIdLab;
@property (weak,   nonatomic) IBOutlet UILabel         *wordNum;
@property (weak,   nonatomic) IBOutlet UIScrollView  *scrollView;
@property (weak,   nonatomic) IBOutlet UITextView    *remark;
@property (nonatomic, strong) NSArray <NSString *>   *selectTypeArray;    //可选的类型
@end

@implementation ZHHBikeBreakDownVC

- (NSMutableArray *)btnSelAry {
    if (_btnSelAry == nil) {
        _btnSelAry = [NSMutableArray array];
    }
    return _btnSelAry;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubViews];
    [self registerForKeyboardNotifications];
    [self addBtnTarget];
    [self setupTitleWithText:@"用户指南"];

    // Do any additional setup after loading the view from its nib.
    _commitBtn.type = ButtonTypeDisabled;
    [_commitBtn setupStatusBackgroundColor];
    [_commitBtn setCornerRadius];
    [_picjImageBtn setCornerRadiusWithRadius:10];
    [_remark setCornerRadiusWithRadius:10];
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

- (void)addBtnTarget {
    for (int i =10; i<20; i++) {
        UIButton *btn = [self.scrollView viewWithTag:i];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)clickBtn:(UIButton *)btn {
    btn.selected = !btn.selected;
    if (btn.selected) {
        
        switch (btn.tag) {
            case 10:
                [self.btnSelAry addObject:@"1"];
                break;
            case 11:
                [self.btnSelAry addObject:@"2"];
                break;
            case 12:
                [self.btnSelAry addObject:@"3"];
                break;
            case 13:
                [self.btnSelAry addObject:@"4"];
                break;
            case 14:
                [self.btnSelAry addObject:@"5"];
                break;
            case 15:
                [self.btnSelAry addObject:@"6"];
                break;
            case 16:
                [self.btnSelAry addObject:@"7"];
                break;
            case 17:
                [self.btnSelAry addObject:@"8"];
                break;
            case 18:
                [self.btnSelAry addObject:@"9"];
                break;
            case 19:
                [self.btnSelAry addObject:@"10"];
                break;
            default:
                break;
        }
    }else{
        
        switch (btn.tag) {
            case 10:
                [self.btnSelAry removeObject:@"1"];
                break;
            case 11:
                [self.btnSelAry removeObject:@"2"];
                break;
            case 12:
                [self.btnSelAry removeObject:@"3"];
                break;
            case 13:
                [self.btnSelAry removeObject:@"4"];
                break;
            case 14:
                [self.btnSelAry removeObject:@"5"];
                break;
            case 15:
                [self.btnSelAry removeObject:@"6"];
                break;
            case 16:
                [self.btnSelAry removeObject:@"7"];
                break;
            case 17:
                [self.btnSelAry removeObject:@"8"];
                break;
            case 18:
                [self.btnSelAry removeObject:@"9"];
                break;
            case 19:
                [self.btnSelAry removeObject:@"10"];
                break;
            default:
                break;
        }
    }
    [self changeCommitBtnState];
}

- (void)hhPickerController:(ZHHPicketPhotoVC *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.picjImageBtn setImage:image forState:UIControlStateNormal];
    self.bikeImage =image;
}

#pragma mark - 扫描  -
- (IBAction)getBikeId:(UIButton *)sender {
    ZHHScanVC *vc = [[ZHHScanVC alloc] init];
    vc.view.frame = self.view.frame;
    vc.result = getBikeId;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 拍照  -
- (IBAction)picturePickerVC:(UIButton *)sender {
    ZHHPicketPhotoVC *vc =[[ZHHPicketPhotoVC alloc] init];
    vc.delegate = self;
    [self.view addSubview:vc.view];
    [self addChildViewController:vc];
}

#pragma mark - 提交  -
- (IBAction)actionCommitBtn:(UIButton *)sender {
    NSMutableString *mStr = [NSMutableString string];
    if (self.btnSelAry.count > 0 ) {
        [self.btnSelAry enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == 0) {
                [mStr appendString:@"选择类型:"];
            }
            [mStr appendFormat:@"%lu-%@,",(unsigned long)idx,self.selectTypeArray[[obj intValue]]];
        }];
    }
    [mStr appendString:self.remark.text];
    NSLog(@"%@",mStr);
    NSString  *imageStr = [self.bikeImage encodeImageToBase64];
    imageStr = imageStr ? imageStr : [[UIImage imageNamed:@"LOGO"] encodeImageToBase64];
    [NetWorks reportQuestionWithType:@"report" andCategory:@"2" andPictures:imageStr andDescription:mStr.copy andSuccessed:^(id response) {
        ReportSuccessVC *vc = [[ReportSuccessVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } failed:^{
        ReminderView *view = [ReminderView reminderViewWithMessage:@"提交失败" btnTitle:@"确定"];
        view.delegate = self;
        [[UIApplication sharedApplication].keyWindow addSubview:view];
    }];

}

- (void)unlockResult:(NSString *)result {
    if (self.bikeId == nil) {
        [self changeLabeState];
    }
    self.bikeId = result;
    self.bikeIdLab.text = result;
    [self changeCommitBtnState];
}

- (void)setSubViews {
    self.remark.delegate = self;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(3, 3, 200, 20)];
    self.labelRemark = label;
    label.enabled = NO;
    label.text = @"最多可输入200个字符";
    label.font =  [UIFont systemFontOfSize:13];
    label.textColor = [UIColor lightGrayColor];
    [self.remark addSubview:label];
    
}

#pragma mark - textFiled的delegate  -
- (void) textViewDidChange:(UITextView *)textView{
    self.wordNum.text = [NSString stringWithFormat:@"%lu",(unsigned long)[textView.text length]];
    
    if ([textView.text length] == 0) {
        [self.labelRemark setHidden:NO];
    }else{
        [self.labelRemark setHidden:YES];
    }
    [self changeCommitBtnState];
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

#pragma mark -   - 已输入单车id更改label状态
- (void)changeLabeState {
    self.needBikeIdLab.hidden = YES;
    self.bikeIdLab.hidden = NO;
    self.bikeIdAgainLab.hidden = NO;
}

#pragma mark -   - 判断是否让提交按钮可按
- (BOOL)commintBtnCanClick {
    if (self.bikeId  && ![self.remark.text isEqualToString:@""] && self.btnSelAry.count) {
        NSLog(@"%@",self.remark.text);
        return YES;
    }
    return NO;
}

#pragma mark -   - 设置commit按钮的状态
- (void)changeCommitBtnState {
    if ([self commintBtnCanClick]) {
        self.commitBtn.type = ButtonTypeNormal;
    } else {
        self.commitBtn.type = ButtonTypeDisabled;
    }
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
        [UIView animateWithDuration:0.25 animations:^{
            self.scrollView.contentOffset = CGPointMake(0, dis+10);
        }];
//        [self.scrollView setContentOffset:CGPointMake(0, dis+10) animated:YES];
    }
}

- (void)keyboardWillBeHidden:(NSNotification *)anotification {
    self.scrollView.contentSize = CGSizeMake( self.scrollView.width, self.scrollView.height);
    [UIView animateWithDuration:0.25 animations:^{
        self.scrollView.contentOffset = CGPointMake(0, 0);
    }];
//    [self.scrollView setContentOffset:CGPointZero animated:YES];
}

- (NSString *)dataFile {
    NSArray *ar = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString *fielpath = [ar objectAtIndex:0];
    return [fielpath stringByAppendingPathComponent:@"user.data"];
    //改修后缀名，以免与属性列表创建的文件重复，而加载成旧的的文件。 不用查字典了。。archive表归档
}

- (IBAction)popReportDisobeyVC:(UIButton *)sender {
    BOOL status = 0;
    NSString *message = @"提交失败";
    if (status == 1) {
        message = @"提交成功";
    }
    ReminderView *view = [ReminderView reminderViewWithMessage:message btnTitle:@"确定"];
    view.delegate = self;
    [[UIApplication sharedApplication].keyWindow addSubview:view];
}

- (void)reminderViewDidClickLeftBtn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSArray<NSString *> *)selectTypeArray {
    if (_selectTypeArray == nil) {
        _selectTypeArray = @[@"仪表失灵",@"二维码脱落/损坏",
                             @"尾箱损坏",@"车铃丢了",
                             @"踏板损坏",@"龙头斜歪",
                             @"刹车失灵",@"电源插入无反应",
                             @"电驱动有问题",@"其他"];
    }
    return _selectTypeArray;
}

@end
