//
//  ZHHMyNewsTVC.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/11/3.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHMyNewsTVC.h"
#import "ZHHMyNewsCell.h"
#import "ZHHNewsInfoModel.h"
@interface ZHHMyNewsTVC ()

@property(nonatomic,strong) NSMutableArray *newsAry;

@end

@implementation ZHHMyNewsTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupTitleWithText:@"我的消息"];
    [self setupNavigationRightItemWithImage:@[@"imgs_menu_arrow_left"]];
    [self.nvLeftBtn addTarget: self action:@selector(clickBackBtn) forControlEvents:UIControlEventTouchUpInside];
    
    //取信息列表 网络请求
    [NetWorks getMyNewsListSuccessed:^(id response) {
        NSArray *aryNew = response[@"result"][@"list"];
        [aryNew enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ZHHNewsInfoModel *model = [ZHHNewsInfoModel newsInfoModelWith:obj];
            [self.newsAry addObject:model];
        }];
    }];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [ZHHMyNewsCell myNewsCellWithTableView:tableView];
    cell.separatorInset = UIEdgeInsetsMake(0, 10, 0, 0);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 132;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (NSMutableArray *)newsAry {
    if (_newsAry == nil) {
        _newsAry = [NSMutableArray array];
    }
    return _newsAry;
}

@end
