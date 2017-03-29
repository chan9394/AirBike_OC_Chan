//
//  AirPowerLossVC.m
//  AirBk
//
//  Created by Damo on 2017/3/9.
//  Copyright © 2017年 ZHH. All rights reserved.
//

#import "AirPowerLossVC.h"
#import "ZHHPickerView.h"

@interface AirPowerLossVC () <ZHHPickerViewDelegate,UITextFieldDelegate>

@property (weak,   nonatomic) IBOutlet UIButton    *chooseAddressBtn;   //选择地区
@property (weak,   nonatomic) IBOutlet UITextField *nameLab;            //收货人
@property (weak,   nonatomic) IBOutlet UITextField *numLab;             //联系方式
@property (weak,   nonatomic) IBOutlet UITextField *detailTf;           //详细地址
@property (weak,   nonatomic) IBOutlet UIButton    *commitBtn;          //去充值
@property (weak,   nonatomic) IBOutlet UIImageView *weixinIv;           //微信图标
@property (weak,   nonatomic) IBOutlet UIImageView *alipayIv;           //阿里图标
@property (weak,   nonatomic) IBOutlet UIButton    *weixinBtn;
@property (weak,   nonatomic) IBOutlet UIButton    *aliBtn;
@property (nonatomic,   weak) UIButton             *selectBtn;          //选中的支付方式
@property (nonatomic,   copy) NSString             *city;               //市
@property (nonatomic,   copy) NSString             *region;             //区
@property (nonatomic, strong) CLGeocoder           *geocoder;           //地理编码
@property (nonatomic,   weak) UIImageView          *shadowIv;           //高斯模糊效果

@end

@implementation AirPowerLossVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _weixinIv.size = CGSizeMake(GLOBAL_H(40), GLOBAL_H(40));
    _alipayIv.size = CGSizeMake(GLOBAL_H(40), GLOBAL_H(40));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTitleWithText:@"挂失充值"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alipaySuccess) name:@"alipaySuccess" object:nil];
    [_commitBtn setCornerRadius];
    
    _commitBtn.layer.borderWidth = 1.0f;
    _commitBtn.layer.borderColor = GLOBAL_THEMECOLOR.CGColor;
    
    _numLab.delegate = self;
    _nameLab.delegate = self;
    _detailTf.delegate = self;
}

#pragma mark - 去充值  -
- (IBAction)actionCommitBtn:(id)sender {
    
}



#pragma mark - 支付成功  -
- (void)alipaySuccess {
    
    
}

- (IBAction)actionPayBtn:(id)sender {
    self.selectBtn = sender;
}


- (void)setSelectBtn:(UIButton *)selectBtn {
    if ([selectBtn isEqual:_selectBtn]) {
        return;
    }
    _selectBtn.selected = NO;
    selectBtn.selected = YES;
    _selectBtn = selectBtn;
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
- (IBAction)actionChooseAddre:(UIButton *)sender {
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
