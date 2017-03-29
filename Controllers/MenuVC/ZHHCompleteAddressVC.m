//
//  ZHHCompleteAddressVC.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/11/28.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHCompleteAddressVC.h"
#import "ZHHPickerView.h"
#import "ZHHPostAddress.h"
#import "ZHHLogModel.h"
#import "ZHHCompleteAddressSucceVC.h"

@interface ZHHCompleteAddressVC ()<ZHHPickerViewDelegate,UITextFieldDelegate>

@property (weak,   nonatomic) IBOutlet UIButton    *chooseAddressBtn;   //选择地区
@property (weak,   nonatomic) IBOutlet UITextField *nameLab;            //收货人
@property (weak,   nonatomic) IBOutlet UITextField *numLab;             //联系方式
@property (weak,   nonatomic) IBOutlet UITextField *detailTf;           //详细地址
@property (weak,   nonatomic) IBOutlet UIButton    *commitBtn;
@property (nonatomic,   copy) NSString             *city;                //市
@property (nonatomic,   copy) NSString             *region;              //区
@property (nonatomic, strong) CLGeocoder           *geocoder;            //地理编码
@property (nonatomic,   weak) UIImageView          *shadowIv;            //高斯模糊效果

@end

@implementation ZHHCompleteAddressVC
- (void)registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}
- (void)keyboardWasShown:(NSNotification *)anotification {
    
    
}

- (void)keyboardWillBeHidden:(NSNotification *)anotification {
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerForKeyboardNotifications];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupTitleWithText:@"添加收货地址"];
    _commitBtn.layer.cornerRadius = 22;
    [_commitBtn.layer masksToBounds];
    
    if (self.changeAddress) {
        self.nameLab.text = self.changeAddress.consigneeName;
        self.numLab.text = self.changeAddress.consigneeNum;
        self.detailTf.text = self.changeAddress.addDetail;
        self.city = self.changeAddress.consigneeAddr.city;
        self.region = self.changeAddress.consigneeAddr.region;
        [self setupChooseAddressBtn];
    }
    _numLab.delegate = self;
    _nameLab.delegate = self;
    _detailTf.delegate = self;
}

- (void)setupChooseAddressBtn {
    NSMutableString *title = [NSMutableString string];
    if (self.city) {
        [title appendString:self.city];
    }
    if (self.region) {
        [title appendString:self.region];
    }
    [self.chooseAddressBtn setTitle:title.copy forState:UIControlStateNormal];
}

#pragma mark - 选择地址  -
- (IBAction)clickChooseAddre:(UIButton *)sender {
    [self.view endEditing:YES];
    //添加高斯模糊
    if (_shadowIv) {
        return;
    }
    UIImageView *iv = [[UIImageView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    iv.image = [UIImage getBlurImge];
    _shadowIv = iv;
    self.view.userInteractionEnabled = NO;
    [[UIApplication sharedApplication].keyWindow addSubview:iv];
    
    ZHHPickerView *view = [ZHHPickerView pickerView];
    sender.enabled = NO;
    view.frame = CGRectMake(0, 0, GLOBAL_SCREENW, GLOBAL_V(300));
    view.delegate = self;
    //    view.y = self.view.height;
    view.y = GLOBAL_SCREENH;
    [[UIApplication sharedApplication].keyWindow  addSubview:view];
    [UIView animateWithDuration:0.3 animations:^{
        //        view.y = self.view.height - view.height;
        view.y = GLOBAL_SCREENH - GLOBAL_V(300);
    }];
}

#pragma mark - 完成选择地址  -
- (void)pickerView:(ZHHPickerView *)pickerView clickOkBtnWithProvince:(NSString *)province andCity:(NSString *)city andRegion:(NSString *)region {
    self.city = city;
    self.region = region;
    [self setupChooseAddressBtn];
    [self pickerViewClickcancleBtn:pickerView];
}

#pragma mark - 取消选择地址  -
- (void)pickerViewClickcancleBtn:(ZHHPickerView *)pickerView {
    self.view.userInteractionEnabled = YES;
    [UIView animateWithDuration:0.3 animations:^{
        pickerView.y =self.view.height;
    } completion:^(BOOL finished) {
        [pickerView removeFromSuperview];
        [_shadowIv removeFromSuperview];
    }];
    self.chooseAddressBtn.enabled = YES;
}

//提交地址. 网络请求
- (IBAction)clickSaveBtn:(UIButton *)sender {
    [NetWorks postAddreBateForUser:self.nameLab.text andAdr:[NSString stringWithFormat:@"%@%@%@",_city,_region,_detailTf.text] andGeoAddr:[NSString stringWithFormat:@"%@%@",_city,_region] andPhoN:self.numLab.text andFailed:^{
    } andSuccess:^(id response) {
        [HHProgressHUD showHUDInView:self.view.superview animated:YES withText:@"充电宝邮寄地址提交成功"];

        if (self.changeAddress) {
            [self.changeAddress changeAddreWithConsigneeName:self.nameLab.text andConsigneeNum:self.numLab.text andProvince:@"" andCity:_city andRegion:self.region andAddDetail:self.detailTf.text];
            
        } else {
//            ZHHPostAddress *addre = [ZHHPostAddress postAddressWithConsigneeName:self.nameLab.text andConsigneeNum:self.numLab.text andProvince:@"" andCity:self.city andRegion:self.region  andAddDetail:self.detailTf.text];
        }
        
        ZHHCompleteAddressVC *vc = [[ZHHCompleteAddressVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
}

#pragma mark - UiTextFiled Delegate  -
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([textField isEqual:_detailTf]) {
        if (_detailTf.text.length > 99) {
            _detailTf.text = [_detailTf.text substringToIndex:99];
        }
        if (_detailTf.text.length ==0) {
            _detailTf.placeholder = @"填写详细地址 限定100个字符";
        }
    }
  
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

- (CLGeocoder *)geocoder {
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}

@end
