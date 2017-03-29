//
//  ZHHCustomServeVC.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/10/31.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHCustomServeVC.h"
#import "ZHHLastTrackView.h"
#import "ZHHBikeBreakDownVC.h"
#import "ZHHFailedUnlockVC.h"
#import "ZHHTracksVC.h"
#import "ZHHPublicTVC.h"
#import "ZHHLastTrackTVC.h"
#import "ZHHClientScheduleVC.h"

@interface ZHHCustomServeVC ()<UITableViewDelegate,UITableViewDataSource,ZHHLastTrackViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) ZHHLastTrackView *lastTrackView;
@property (strong,nonatomic) NSArray *rowAry;

@end

@implementation ZHHCustomServeVC

- (NSArray *)rowAry {
    if (_rowAry == nil) {
        _rowAry = @[@[@"历史行程",@"发现车辆故障",@"开不了锁",@"注册登录",@"押金车费",@"我的AirBike信用问题",@"还车相关"],@[@"客户服务进度查询"]];
    }
    return _rowAry;
}

- (ZHHLastTrackView *)lastTrackView {
    if (_lastTrackView == nil) {
        ZHHLastTrackView *view = [ZHHLastTrackView zhhLastTrackView];
        _lastTrackView = view;
        _lastTrackView.x = 10;
        _lastTrackView.width = self.view.width - 20;
        _lastTrackView.y = 10;
        _lastTrackView.height = 120;
        _lastTrackView.delegate = self;
    }
    return _lastTrackView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupTitleWithText:@"客户服务"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ((NSArray *)self.rowAry[section]).count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.rowAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"list"];
    if (cell ==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"list"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    cell.textLabel.text = ((NSArray *)self.rowAry[indexPath.section])[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return self.lastTrackView.height+20;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return self.lastTrackView;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cel = [tableView cellForRowAtIndexPath:indexPath];
    cel.selected = NO;
    
    if (indexPath.section == 0&& indexPath.row == 0) {
        ZHHTracksVC *vc = [[ZHHTracksVC alloc] init];
        vc.view.frame = self.view.frame;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if(indexPath.section == 0&& indexPath.row == 1){
        ZHHBikeBreakDownVC *vc = [[ZHHBikeBreakDownVC alloc] init];
        vc.view.frame = self.view.frame;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if(indexPath.section == 0 && indexPath.row == 2){
        ZHHFailedUnlockVC *vc = [[ZHHFailedUnlockVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.section == 0&& indexPath.row == 3){
        
        //        ZHHPublicTVC *tbv = [[ZHHPublicTVC alloc] init];
        //        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MenuHint" ofType:@"plist"]];
        //        tbv.dic = [dic objectForKey:@"registerAry"];
        //        [self.navigationController pushViewController:tbv animated:YES];
        
    }else if (indexPath.section == 0&& indexPath.row == 4){
        
        //        ZHHPublicTVC *tbv = [[ZHHPublicTVC alloc] init];
        //        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MenuHint" ofType:@"plist"]];
        //        tbv.dic = [dic objectForKey:@"depositAry"];
        //        [self.navigationController pushViewController:tbv animated:YES];
        
    }else if (indexPath.section == 0&& indexPath.row == 5){
        
        //        ZHHPublicTVC *tbv = [[ZHHPublicTVC alloc] init];
        //        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MenuHint" ofType:@"plist"]];
        //        tbv.dic = [dic objectForKey:@"myCreditAry"];
        //        [self.navigationController pushViewController:tbv animated:YES];
        
    }else if (indexPath.section == 0&& indexPath.row == 6){
        
        //        ZHHPublicTVC *tbv = [[ZHHPublicTVC alloc] init];
        //        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MenuHint" ofType:@"plist"]];
        //        tbv.dic = [dic objectForKey:@"aboutReturnBike"];
        //        [self.navigationController pushViewController:tbv animated:YES];
        
    }else if(indexPath.section == 1&& indexPath.row == 0){
        
        //        ZHHClientScheduleVC *vc = [[ZHHClientScheduleVC alloc] init];
        //        vc.view.frame = self.view.frame;
        //        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
    
}

- (void)clicktoPushLastTrackTvc{
    ZHHLastTrackTVC *vc = [[ZHHLastTrackTVC alloc] init];
    vc.view.frame = self.view.frame;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
