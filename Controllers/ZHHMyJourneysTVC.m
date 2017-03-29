//
//  ZHHMyJourneysTVC.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/11/3.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHMyJourneysTVC.h"
#import "ZHHMyJourneysCellView.h"
#import "ZHHTracksVC.h"
#import "ZHHTrackInfoModel.h"
#import "ZHHPublicTVC.h"
#import "ShareView.h"

@interface ZHHMyJourneysTVC ()

//模型数组
@property (nonatomic, strong)NSArray<TrackListModel *> *trackAry;

@property (nonatomic, weak) WKWebViewController *webVC;

@end


@implementation ZHHMyJourneysTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [NetWorks getTrackListSuccessed:^(id response) {
        NSArray *ary = response[@"result"][@"list"];
        if (ary.count == 0) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, GLOBAL_V(80), GLOBAL_SCREENW, 30)];
            label.text = @"暂无骑行记录";
            label.font = [UIFont systemFontOfSize:15.0];
            label.textColor = GLOBAL_CONTENTCOLOR;
            label.textAlignment = NSTextAlignmentCenter;
            UIImage *img = [UIImage imageNamed:@"imgs_menu_no_track"];
            UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 45, 35)];
            iv.image = img;
            iv.center = self.view.center;
            iv.y = GLOBAL_V(110);
            [self.view addSubview:label];
            [self.view addSubview:iv];
            return ;
        }
        [GLOBAL_MANAGER.trackInfoModel modelWithJSON:response[@"result"]];
        self.trackAry = GLOBAL_MANAGER.trackInfoModel.listModel;
        [self.tableView reloadData];
    }];
 
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupTitleWithText:@"我的行程"];
    [self setupNavigationRightItemWithTitle:@"需要帮助?"];
    [self.nvRightBtn addTarget:self action:@selector(clickRBtn) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.trackAry.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 84;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZHHMyJourneysCellView *cell = [tableView dequeueReusableCellWithIdentifier:@"journeyCell"];
    
    if (cell == nil) {
        cell = [ZHHMyJourneysCellView myJourneysCellView];
    }
    
    cell.trackM = self.trackAry[indexPath.row];
    cell.separatorInset = UIEdgeInsetsMake(0, 8, 0, 0);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TrackListModel *model = self.trackAry[indexPath.row];
//    WKWebViewController *vc = [WKWebViewController webVCWithTitlt:@"行程详情" type:WKWebVCTypeMoveDetail];
    WKWebViewController *vc = [[WKWebViewController alloc] initWithTitle:@"行程详情" type:WKWebVCTypeMoveDetail cycleID:model.ID];
    _webVC = vc;
        vc.nvRightTitle = @"分享";
     __weak typeof(vc) weakvc = vc;
    vc.rightBlock = ^(){
        [weakvc addEffectView];
//        ShareView *shareView = [ShareView shareView];
//        shareView.width = weakvc.view.width;
//        shareView.y = weakvc.view.height ;
//        [GLOBAL_KEYWINDOW addSubview:shareView];
//        [UIView animateWithDuration:0.2 animations:^{
//            shareView.y = weakvc.navigationController.view.height - shareView.height;
//        }];
//
//        weakvc.tapRecHandel = ^(UITapGestureRecognizer *tapRec){
//            
//            [UIView animateWithDuration:0.2 animations:^{
//                shareView.y = weakvc.navigationController.view.height;
//            } completion:^(BOOL finished) {
//                [shareView removeFromSuperview];
//                [tapRec.view removeFromSuperview];
//            }];
        };
//    };

    [self.navigationController pushViewController:vc animated:YES];
}


- (NSArray *)trackAry {
    if (_trackAry == nil) {
        _trackAry = [NSArray array];
    }
    return _trackAry;
}

#pragma mark - 控制器跳转  -
//需要帮助
- (void)clickRBtn {
    ZHHPublicTVC *tvc = [[ZHHPublicTVC alloc] init];
    tvc.type = PublicTypeGuide;
    [self.navigationController pushViewController:tvc animated:YES];
}

@end
