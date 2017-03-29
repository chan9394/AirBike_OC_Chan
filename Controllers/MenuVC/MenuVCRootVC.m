//
//  MenuVCRootVC.m
//  Mobike
//
//  Created by 郑洪浩 on 16/10/13.
//  Copyright © 2016年 ZHH. All rights reserved.
//
#import "ZHHUserInfoTVC.h"
#import "MenuHeaderView.h"
#import "MenuVCRootVC.h"
#import "UINavigationBar+Background.h"
#import "ZHHInviteFriVC.h"
#import "ZHHMyJourneysTVC.h"
#import "ZHHMyNewsTVC.h"
#import "ZHHMyWalletViC.h"
#import "ZHHPublicTVC.h"
#import "ZHHReisterLogOnVC.h"
#import "ZHHGetUserInfoMod.h"
#import "MainViewController.h"
#import "ZHHCompleteAddressVC.h"
#import "AirPowerTC.h"

@interface MenuVCRootVC ()<MenuHeaderViewDelegate>

@property (nonatomic ,strong) MenuHeaderView         *headerView;
@property (nonatomic ,strong) NSArray                *aryShow;
@property (nonatomic, assign) BOOL                   showBalance;           //是否显示余额
@property (nonatomic,   weak) UIView                 *extensionView;         //向上扩张的View

@end

@implementation MenuVCRootVC {
    CGFloat _heightHead;
    NSString *_test;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTitleWithText:@"个人中心"];
    self.view.backgroundColor = [UIColor whiteColor];
    self.showBalance = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.rowHeight = 60;
    [self setupUI];

}

- (void)setupUI {
    self.automaticallyAdjustsScrollViewInsets = NO;
    MenuHeaderView *headView = [[MenuHeaderView alloc] init];
    headView.delegate =self;
    headView.frame = self.view.frame;
    [headView setSubViews];
    self.headerView = headView;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, -1, GLOBAL_SCREENW, 1)];
    _extensionView = view;
    view.backgroundColor = [UIColor colorWithRed:243.0 / 255 green:249.0 / 255 blue:249.0 / 255 alpha:1];
    [self.tableView addSubview:view];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if([AccountManager token]) {
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MenuHint" ofType:@"plist"]];
        NSArray *ary = [dic objectForKey:@"userView"];
        self.aryShow = ary;
    }
    //获取用户信息
    [NetWorks getUserInfoDetailSuccessGet:^(id response) {
        self.showBalance = YES;
        AccountManager *manager = [AccountManager shareAccountManager];
        [manager yy_modelSetWithJSON:response];
        NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
        [self.headerView refreshSubView];
    } pushRegisterVC:YES];
    
}

- (void)back {
    MainViewController *mainVC = self.navigationController.childViewControllers[0];
    [mainVC judgeNetwork];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 滚动的代理方法  -
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat margin = scrollView.contentOffset.y;
    if (margin > 0) {
        return;
    }
    _extensionView.height = -margin;
    _extensionView.y = margin;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.aryShow == nil) {
        return 1;
    }
    return self.aryShow.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.aryShow == nil) {
        return 0;
    }
    return ((NSArray *)self.aryShow[section]).count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return self.headerView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return self.headerView.height;
    }
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell ;
    BOOL isWalletRow = NO;
    
    if (indexPath.section == 0&&indexPath.row == 0) {
        isWalletRow = YES;
    }
    if (isWalletRow) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"3"];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"4"];
    }
    
    if (cell == nil) {
        if (isWalletRow) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"3"];
            UILabel *labe = [[UILabel alloc] init];
            labe.frame = CGRectMake(SCREEN_WIDTH-110, 0.5*(tableView.rowHeight - 44), 80, 44);
            labe.textAlignment = NSTextAlignmentRight;
            labe.font = [UIFont systemFontOfSize:12];
            labe.textColor = GLOBAL_CONTENTCOLOR;
            labe.tag = 100;
            [cell.contentView addSubview:labe];
        } else {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"4"];
        }
    
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = GLOBAL_CONTENTCOLOR;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.separatorInset = UIEdgeInsetsZero;
    }
    
    if (isWalletRow) {
        if (self.showBalance) {
            ((UILabel *)[cell.contentView viewWithTag:100]).text = [NSString stringWithFormat:@"%@元",[AccountManager shareAccountManager].balanceModel.balance];
        }
    }
    
    NSString *imgNam = [((NSArray *)self.aryShow[indexPath.section])[indexPath.row] objectForKey:@"imgNam"];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",imgNam]];
//    cell.imageView.image = [UIImage imageNamed:@"imgs_menu_air_power"];
    cell.textLabel.text = [((NSArray *)self.aryShow[indexPath.section])[indexPath.row] objectForKey:@"name"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cel = [tableView cellForRowAtIndexPath:indexPath];
    cel.selected = NO;
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                [self pushMyWalletVC];
                break;
             case 1:
                [self pushMyJourneysTC];
                break;
            case 2:
                [self pushProductIntroWC];
                break;
            case 3:
                [self pushCompleteAddressVC];
                break;
            case 4:
                [self pushAirPowerVC];
                break;
            case 5:
                [self pushMyNewsTC];
                break;
            case 6:
                [self pushInviteFriVC];
                break;
            case 7:
                [self pushShopWC];
                break;
            case 8:
                [self pushGuideTC];
                break;
            case 9:
                [self pushSettingTC];
                break;
            default:
                break;
        }
    }
}

- (void)refreshMenuHeaderView {
    [self.tableView reloadData];
}

#pragma mark - 控制器跳转  -
//登录
- (void)pushLoginVC {
    ZHHReisterLogOnVC *vc = [[ZHHReisterLogOnVC alloc] init];
    vc.view.frame = self.view.bounds;
//    vc.logOnHandle = ^(){
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    };
    [self.navigationController pushViewController:vc animated:YES];
}

//信用中心
- (void)pushCredcitVC {
    WKWebViewController *vc = [WKWebViewController webVCWithTitlt:@"我的信用记录" type:WKWebVCTypeMyCredit];
    [self.navigationController pushViewController:vc animated:YES];
}

//用户信息
- (void)menuVCPushUserInfoVC {
    ZHHUserInfoTVC *tvc = [[ ZHHUserInfoTVC alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:tvc animated:YES];
}

//我的钱包
- (void)pushMyWalletVC {
    ZHHMyWalletViC *vc = [[ZHHMyWalletViC alloc] init];
    vc.view.frame = self.view.frame;
    [self.navigationController pushViewController:vc animated:YES];
}

//我的行程
- (void)pushMyJourneysTC {
    ZHHMyJourneysTVC *tc =[[ZHHMyJourneysTVC alloc] initWithStyle:UITableViewStyleGrouped];
    tc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:tc animated:YES];
}

//产品介绍
- (void)pushProductIntroWC {
    WKWebViewController *vc= [WKWebViewController webVCWithTitlt:@"产品介绍" type:WKWebVCTypeProductIntro];
    [self.navigationController pushViewController:vc animated:YES];
}

//收货地址
- (void)pushCompleteAddressVC {
    ZHHCompleteAddressVC *vc = [[ZHHCompleteAddressVC alloc] init];
    vc.view.frame = self.view.frame;
    [self.navigationController pushViewController:vc animated:YES];
    vc.success = ^(ZHHCompleteAddressVC *vc){
        [vc.navigationController popViewControllerAnimated:YES];
    };
}

//AirPower
-(void)pushAirPowerVC {
    AirPowerTC *tc = [AirPowerTC airPower];
    [self.navigationController pushViewController:tc animated:YES];
}

//我的消息
- (void)pushMyNewsTC {
    ZHHMyNewsTVC *tvc = [[ZHHMyNewsTVC alloc] init];
    tvc.view.frame = self.view.frame;
    [self.navigationController pushViewController:tvc animated:YES];
}

//邀请好友
- (void)pushInviteFriVC {
    ZHHInviteFriVC *tvc = [[ZHHInviteFriVC alloc] init];
    tvc.view.frame = self.view.frame;
    [self.navigationController pushViewController:tvc animated:YES];
}

//配件商城
- (void)pushShopWC {
    WKWebViewController *vc = [WKWebViewController webVCWithTitlt:@"配件商城" type:0];
    [self.navigationController pushViewController:vc animated:YES];
}

//用户指南
- (void)pushGuideTC {
    ZHHPublicTVC *tvc = [[ZHHPublicTVC alloc] init];
    tvc.type = PublicTypeGuide;
    [self.navigationController pushViewController:tvc animated:YES];
}

//设置
- (void)pushSettingTC {
    ZHHPublicTVC *tbv = [[ZHHPublicTVC alloc] init];
    tbv.type = PublicTypeSetting;
    [self.navigationController pushViewController:tbv animated:YES];
}

- (void)dealloc {
    self.headerView = nil;
}

@end
