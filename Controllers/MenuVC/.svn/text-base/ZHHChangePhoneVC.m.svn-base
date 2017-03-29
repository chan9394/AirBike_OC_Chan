//
//  ZHHChangePhoneVC.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/11/11.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHChangePhoneVC.h"
#import "ZHHChangePhoneNumVC.h"

@interface ZHHChangePhoneVC ()

@property (weak, nonatomic) IBOutlet UIButton *changBtn;
@property (weak, nonatomic) IBOutlet UILabel *phoLab;

@end


@implementation ZHHChangePhoneVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupTitleWithText:@"手机号"];
    self.navigationController.navigationBar.translucent = NO;
    self.phoLab.text = GLOBAL_MANAGER.userModel.mobile;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.changBtn.layer.cornerRadius = 0.5*self.changBtn.height;
    self.changBtn.layer.masksToBounds = YES;
}

- (IBAction)clickChangeBtn:(UIButton *)sender {
    ZHHChangePhoneNumVC *vc = [[ZHHChangePhoneNumVC alloc] init];
    vc.view.frame = self.view.frame;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
