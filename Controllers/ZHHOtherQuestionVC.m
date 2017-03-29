//
//  ZHHOtherQuestionVC.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/11/11.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHOtherQuestionVC.h"
#import "ZHHPicketPhotoVC.h"
#import <Photos/Photos.h>
#import "ZHHScanVC.h"

@interface ZHHOtherQuestionVC ()<UITextViewDelegate,ZHHScanVCDelegate,ZHHPicketPhotoVCDelegate>

@property (nonatomic, copy)NSString *bikeId;//扫描得到的单车id
@property (nonatomic, strong)UIImage *bikeImage;//停车照片
@property (nonatomic, weak)UILabel *labelRemark;//textview的标注
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@property (weak, nonatomic) IBOutlet UIButton *picjImageBtn;
@property (weak, nonatomic) IBOutlet UILabel *bikeIdAgainLab;
@property (weak, nonatomic) IBOutlet UILabel *bikeIdLab;
@property (weak, nonatomic) IBOutlet UILabel *needBikeIdLab;
@property (weak, nonatomic) IBOutlet UILabel *wordNum;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextView *remark;

@end

@implementation ZHHOtherQuestionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubViews];
    [self registerForKeyboardNotifications];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapInScrollView)];
    tapGR.numberOfTapsRequired = 1;
    tapGR.numberOfTouchesRequired = 1;
    [self.scrollView addGestureRecognizer:tapGR];
}
-(void)tapInScrollView{
    [self.view endEditing:YES];
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
-(void)setTrackModel:(TrackListModel *)trackModel{
    
    _trackModel = trackModel;
    self.bikeId = @"服务器未返回";
    self.bikeIdLab.text = @"服务器未返回";
    [self changeLabeState];
    
}
-(void)keyboardWasShown:(NSNotification *)anotification{
    
    
    CGRect keyboardFrame = [[anotification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat btnMaxY = CGRectGetMaxY(self.commitBtn.frame);
    
    
    
    CGFloat dis = keyboardFrame.size.height - (self.view.height - btnMaxY);
    NSLog(@"%f",dis);
    if (dis>0) {
        
        self.scrollView.contentSize = CGSizeMake( self.scrollView.width, self.scrollView.height+dis);
        
        self.scrollView.contentOffset = CGPointMake(0, dis+10);
    }
    
    
}
-(void)keyboardWillBeHidden:(NSNotification *)anotification{
    
    
    
    self.scrollView.contentSize = CGSizeMake( self.scrollView.width, self.scrollView.height);
    
    self.scrollView.contentOffset = CGPointMake(0, 0);
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupTitleWithText:@"客户服务"];
}
-(void)setSubViews{
    
    self.remark.delegate = self;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(3, 3, 200, 20)];
    self.labelRemark = label;
    label.enabled = NO;
    label.text = @"备注";
    label.font =  [UIFont systemFontOfSize:15];
    label.textColor = [UIColor lightGrayColor];
    [self.remark addSubview:label];
    
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
- (IBAction)picturePickerVC:(UIButton *)sender {
    
    ZHHPicketPhotoVC *vc =[[ZHHPicketPhotoVC alloc] init];
    vc.delegate = self;
    [self.view addSubview:vc.view];
    [self addChildViewController:vc];
    
}

-(void)hhPickerController:(ZHHPicketPhotoVC *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
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
-(void)unlockResult:(NSString *)result{
    
    if (self.bikeId == nil) {
        [self changeLabeState];
        
    }
    
    self.bikeId = result;
    self.bikeIdLab.text = result;
    [self changeCommitBtnState];
    
}
//已输入单车id更改label状态
-(void)changeLabeState{
    
    self.needBikeIdLab.hidden = YES;
    self.bikeIdLab.hidden = NO;
    self.bikeIdAgainLab.hidden = NO;
    
}
//判断是否让提交按钮可按
-(BOOL)commintBtnCanClick{
    
    if (self.bikeId && self.bikeImage && ![self.remark.text isEqualToString:@""]) {
        NSLog(@"%@",self.remark.text);
        return YES;
    }
    return NO;
}
//设置commit按钮的状态
-(void)changeCommitBtnState{
    
    if ([self commintBtnCanClick]) {
        self.commitBtn.enabled = YES;
    }
    
}

@end
