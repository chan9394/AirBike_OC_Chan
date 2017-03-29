//
//  ZHHInputBikeNumUnlockVC.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/10/27.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHInputBikeNumUnlockVC.h"
#import <AVFoundation/AVFoundation.h>

@interface ZHHInputBikeNumUnlockVC ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textField;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UIButton *flashLightBtn;
@property (nonatomic, strong) AVCaptureDevice *device;
@property (weak, nonatomic) IBOutlet UILabel *labelView;

@end

@implementation ZHHInputBikeNumUnlockVC

-(AVCaptureDevice *)device{
    
    if (_device==nil) {
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    return _device;
    
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

-(void)keyboardWasShown:(NSNotification *)anotification{
    
    
    CGRect keyRect = [[anotification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat y =self.labelView.y +self.labelView.height - keyRect.origin.y;
    if (y >0) {
        self.confirmBtn.transform = CGAffineTransformMakeTranslation(0, -y);
        
    }
    
}
-(void)keyboardWillBeHidden:(NSNotification *)anotification{
    
    self.confirmBtn.transform = CGAffineTransformIdentity;
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self registerForKeyboardNotifications];
    self.confirmBtn.layer.cornerRadius = 0.5*self.confirmBtn.height;
    self.confirmBtn.layer.masksToBounds = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.flashLightBtn.selected) {
        [self.device lockForConfiguration:nil];
        
        [_device setTorchMode:AVCaptureTorchModeOff];
        
        [_device unlockForConfiguration];
        
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTextView];
    [self setNaviItemBtn];
}


- (void)setNaviItemBtn {
    [self setupTitleWithText:@"手动开锁"];
}

- (void)setTextView {
    [self.textField becomeFirstResponder];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (range.location<=11) {
        
        if (range.length == 0) {
            //输入
            [self editLab:range.location withText:text];
        }else{
            //删除
            [self deleteLab:range.location];
        }
        return YES;
    }
    return NO;
}

- (void)editLab:(NSInteger)index withText:(NSString *)text{
    
    UILabel *lab = [self.view viewWithTag:index+50];
    lab.text = text;
}

- (void)deleteLab:(NSInteger)index{
    UILabel *lab = [self.view viewWithTag:index+50];
    lab.text = @"";
}


+(instancetype)inputBikeNumUnlockVC{
    
    ZHHInputBikeNumUnlockVC *vc = [[NSBundle mainBundle] loadNibNamed:@"InputBikeNumUnlockVC" owner:nil options:nil].firstObject;
    return vc;
    
}

#pragma mark - 🔦  -
- (IBAction)clickFlashLitgtBtn:(UIButton *)sender {
    if (![self.device hasTorch]) {
        NSLog(@"手电筒坏了");
        return;
    }
    sender.selected = !sender.selected;
    if (sender.selected) {
        
        [self.device lockForConfiguration:nil];
        
        [_device setTorchMode:AVCaptureTorchModeOn];
        
        [_device unlockForConfiguration];
        
    }else{
        //关闭手电筒
        [self.device lockForConfiguration:nil];
        [_device setTorchMode:AVCaptureTorchModeOff];
        [_device unlockForConfiguration];
    }
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
- (IBAction)clickConfirmBtn:(UIButton *)sender {
    
    NSString *str = self.textField.text;
    if ([self.delegate respondsToSelector:@selector(sendInPutBikeId:)]) {
//        [self.navigationController popViewControllerAnimated:YES];
        [self.delegate sendInPutBikeId:str];
    }
}

- (void)dealloc {
    
}
@end
