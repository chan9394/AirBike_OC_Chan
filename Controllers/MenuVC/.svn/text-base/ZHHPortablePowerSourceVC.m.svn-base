//
//  ZHHPortablePowerSourceVC.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/11/28.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHPortablePowerSourceVC.h"
#import "ZHHCompleteAddressVC.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "ZHHCompleteAddressSucceVC.h"
@interface ZHHPortablePowerSourceVC ()

@property (weak,   nonatomic) IBOutlet UILabel                  *rechargeLb;      //充值成功
@property (weak,   nonatomic) IBOutlet UILabel                  *changeColorLb;   //正文中的label
@property (weak,   nonatomic) IBOutlet UIButton                 *addressBtn;      //填写地址
@property (weak,   nonatomic) IBOutlet UILabel                  *introLbTop;
@property (weak,   nonatomic) IBOutlet UILabel                  *introLbBottom;
@property (weak,   nonatomic) IBOutlet UIButton                 *giveUpBtn;
@property (strong, nonatomic) AVPlayerViewController            *playerVC;

@end

@implementation ZHHPortablePowerSourceVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    [self setupTitleWithText:@"充值成功"];
    _changeColorLb.textColor = GLOBAL_CONTENTCOLOR;
    _introLbTop.textColor = GLOBAL_CONTENTCOLOR;
    _introLbBottom.textColor = GLOBAL_CONTENTCOLOR;
    _rechargeLb.textColor = GLOBAL_ASSISTCOLOR;
    _addressBtn.backgroundColor = GLOBAL_ASSISTCOLOR;
    _addressBtn.layer.cornerRadius = GLOBAL_V(44) / 2;
    [_addressBtn.layer masksToBounds];
}


- (IBAction)clickCompleteAddressBtn:(UIButton *)sender {
    
    ZHHCompleteAddressVC *vc = [[ZHHCompleteAddressVC alloc] init];
    vc.view.frame = self.view.frame;
    [self.navigationController pushViewController:vc animated:YES];
    
    vc.success = ^(ZHHCompleteAddressVC *vc){
        ZHHCompleteAddressSucceVC *vcsucc = [[ZHHCompleteAddressSucceVC alloc] init];
        vcsucc.view.frame = self.view.frame;
        [self.navigationController pushViewController:vcsucc animated:YES];
        
    };
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigatonLeftItemWithTitle:@"回到首页"];
    [self.nvLeftBtn addTarget:self action:@selector(backToHome) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - 回到首页  -

-  (void)backToHome {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)actionGiveUpBtn:(id)sender {
    [self backToHome];
}

@end
