//
//  ReportSuccess.m
//  AirBk
//
//  Created by Damo on 2017/1/5.
//  Copyright © 2017年 ZHH. All rights reserved.
//

#import "ReportSuccessVC.h"

@interface ReportSuccessVC ()
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

@end

@implementation ReportSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [_commitBtn setCornerRadius];
}

- (IBAction)actionCommitBtn:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}
@end
