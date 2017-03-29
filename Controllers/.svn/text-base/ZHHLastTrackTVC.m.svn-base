//
//  ZHHLastTrackTVC.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/11/4.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHLastTrackTVC.h"
#import "ZHHLastTrackView.h"
#import "ZHHReportDisobeyVC.h"
#import "ZHHOtherQuestionVC.h"
@interface ZHHLastTrackTVC ()

@end

@implementation ZHHLastTrackTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    [self setupTitleWithText:@"客户服务"];
    //    NaviBarLBt_RBt(@"imgs_menu_arrow_left", nil, nil, nil)
    //    [lbutton addTarget:self action:@selector(clickBackBtn) forControlEvents:UIControlEventTouchUpInside];
    [self setupNavigationRightItemWithImage:@[@"imgs_menu_arrow_left"]];
    [self.nvLeftBtn addTarget:self action:@selector(clickBackBtn) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickBackBtn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 180)];
    
    ZHHLastTrackView *viewT = [ZHHLastTrackView zhhLastTrackView];
    viewT.helpBtn.hidden = YES;
    viewT.x = 17;
    viewT.y = 10;
    viewT.model = self.trackModel;
    [view addSubview:viewT];
    
    UILabel *labe = [[UILabel alloc] initWithFrame:CGRectMake(10, 155, 300, 25)];
    labe.text =@"what's your question?";
    labe.textColor = [UIColor darkGrayColor];
    labe.font = [UIFont systemFontOfSize:13];
    [view addSubview:labe];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 180;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"121"];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"发现车辆故障";
    } else {
        cell.textLabel.text = @"其他";
    }
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView cellForRowAtIndexPath:indexPath].selected = NO;
    
    if (indexPath.section == 0&& indexPath.row == 0) {
        ZHHReportDisobeyVC *vc = [[ZHHReportDisobeyVC alloc] init];
        vc.view.frame = self.view.frame;
        [self.navigationController pushViewController:vc animated:YES];
        vc.trackModel = self.trackModel;
    }else if (indexPath.section == 0&& indexPath.row == 1) {
        ZHHOtherQuestionVC *vc = [[ZHHOtherQuestionVC alloc] init];
        vc.view.frame = self.view.frame;
        [self.navigationController pushViewController:vc animated:YES];
        vc.trackModel = self.trackModel;}
}

@end
