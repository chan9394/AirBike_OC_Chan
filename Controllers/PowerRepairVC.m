//
//  PowerRepairVC.m
//  AirBk
//
//  Created by Damo on 17/1/4.
//  Copyright © 2017年 ZHH. All rights reserved.
//

#import "PowerRepairVC.h"
#import "RequestSuccessVC.h"

@interface PowerRepairVC () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTf;               //姓名
@property (weak, nonatomic) IBOutlet UITextField *connectTf;            //联系方式
@property (weak, nonatomic) IBOutlet UITextField *companyTf;           //快递公司
@property (weak, nonatomic) IBOutlet UITextField *numberTf;             //快递单号
@property (weak, nonatomic) IBOutlet UITextField *messageTf;           //留言
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;               //确定
@property (weak, nonatomic) IBOutlet UIView *currentView;
@property (nonatomic, weak) UITextField *currentTf;
@end

@implementation PowerRepairVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTitleWithText:@"电源维修"];
    _nameTf.delegate  = self;
    _connectTf.delegate = self;
    _companyTf.delegate = self;
    _numberTf.delegate = self;
    _messageTf.delegate = self;
    [_commitBtn setCornerRadius];
    self.currentView = (UIScrollView * )self.view;
    //    //监听键盘事件
    [self removeShadow];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHidden) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self recoverShadow];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    static NSArray *array  = nil;
    array = @[_nameTf,_connectTf,_companyTf,_numberTf,_messageTf];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [(UITextField *)obj resignFirstResponder];
        _currentTf = nil;
    }];
}

#pragma mark - 确定  -
- (IBAction)actionCommitBtn:(id)sender {
    static NSArray *array  = nil;
    array = @[_nameTf,_connectTf,_companyTf,_numberTf];
    [array enumerateObjectsUsingBlock:^(UITextField *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.text isEqualToString:@""]) {
            [HHProgressHUD showHUDInView:self.view animated:YES withText:@"请检查是否有未填项目"];
            return;
        }
    }];
    RequestSuccessVC *vc = [[RequestSuccessVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([textField isEqual:_messageTf]) {
        if (_messageTf.text.length > 99) {
            _messageTf.text = [_messageTf.text substringToIndex:99];
        }
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    _currentTf = textField;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
}

#pragma mark - 键盘弹出事件  - UIKeyboardFrameEndUserInfoKey
- (void)keyBoardShow:(NSNotification *)not {
    
    CGRect rect = [not.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat maxY = CGRectGetMaxY(_currentTf.frame);
    CGFloat dis = maxY + 84 - rect.origin.y;
    if (dis > 0) {
        [UIView animateWithDuration:0.25 animations:^{
            self.currentView.y = -dis;
        }];
    }
}

- (void)keyBoardHidden {
    [UIView animateWithDuration:0.25 animations:^{
        self.currentView.y = self.navigationController.navigationBar.translucent == NO ? 64 : 0;
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
