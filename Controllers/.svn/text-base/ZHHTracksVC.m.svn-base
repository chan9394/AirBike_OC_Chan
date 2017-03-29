//
//  ZHHTracksVC.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/11/1.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHTracksVC.h"
#import "ZHHLastTrackTVC.h"
#import "ZHHTrackInfoModel.h"
#import "ZHHTracksTVCCell.h"

@interface ZHHTracksVC ()
@property (nonatomic, strong)NSMutableArray *trackAry;///<标注#>
@end


@implementation ZHHTracksVC
-(NSMutableArray *)trackAry{
    if (_trackAry == nil) {
        _trackAry = [NSMutableArray array];
    }
    return _trackAry;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    [self.tableView registerNib:[UINib nibWithNibName:@"serves" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"trackInfo"];
    
    if ([AccountManager token]) {
        [NetWorks getCyclingListResultSuccessGetList:^(id response) {
            [self.tableView reloadData];
        }];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupTitleWithText:@"客户服务"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.trackAry.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZHHTracksTVCCell *cell = [tableView dequeueReusableCellWithIdentifier:@"trackInfo" forIndexPath:indexPath];
    cell.model = self.trackAry[indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(10, 10, 200, 20);
    label.text = @"您对哪段行程有问题?";
    label.font = [UIFont systemFontOfSize:13];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    [view addSubview:label];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZHHTracksTVCCell *cel = [tableView cellForRowAtIndexPath:indexPath];
    cel.selected = NO;
    ZHHLastTrackTVC *vc = [[ZHHLastTrackTVC alloc] init];
    vc.trackModel = cel.model;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
