//
//  AirPowerTC.m
//
//
//  Created by Damo on 2017/3/6.
//
//

#import "AirPowerTC.h"
#import "AirPowerCell.h"
#import "AirPowerModel.h"
#import "AirPowerView.h"
#import "AirPowerLossVC.h"
#define kReusedIdTop    @"AirPowerTC1"
#define kReusedIdMiddle @"AirPowerTC2"
#define kReusedIdBottom @"AirPowerTC3"
NSString *reusedID = nil;

@interface AirPowerTC () <AirPowerViewDelegate>

@property (nonatomic, strong)    AirPowerModel                   *model;
@property (nonatomic, strong)    NSArray                         *titleArray;
@property (nonatomic, strong)    AirPowerView                    *airPowerView; //遮罩

@end

@implementation AirPowerTC


+ (instancetype)airPower {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"AirPowerTC" bundle:nil];
    AirPowerTC *tc = [sb instantiateViewControllerWithIdentifier:@"AirPowerTC"];
    return tc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.showsVerticalScrollIndicator = NO;
    //    self.tableView.allowsSelection = NO;
    self.tableView.estimatedRowHeight = 80.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    [self setupNavigationBar];
}

- (void)setupNavigationBar {
    [self setupTitleWithText:@"AirPower"];
    typeof(self)weakSelf = self;
    [self setupNavigationRightItemWithImage:@[@"imgs_menu_power_menu"] block:^{
        [GLOBAL_KEYWINDOW addSubview:weakSelf.airPowerView];
    }];
}

#pragma mark - 右侧按钮的点击方法  -
- (void)actionMenuButton:(UIButton *)button index:(NSInteger)index {
    if (index == 2 || index == 3) {
        if (!self.airPowerView) {
            return;
        }
        NSString *title         = index == 2 ? @"锁定AirPower" : @"是否挂失AirPower?";
        NSString *detail        = index == 2 ? @"锁定后将解除配对不可使用" : @"系统将自动取消配对,请谨慎操作";
        NSString *leftBtnTitle  = index == 2 ? @"锁定" : @"挂失";
        [self.airPowerView removeFromSuperview];
        __weak typeof(self)weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            ReminderView *reminder = [ReminderView reminderViewWithtitle:title
                                                                  detail:detail
                                                            leftBtnTitle:leftBtnTitle
                                                  leftBtnBackgroundColor:GLOBAL_ASSISTCOLOR
                                                               leftBlock:^{
                                                                   if (index == 2) {
                                                                       _model.status = AirPowerStatusLock;
                                                                       [weakSelf.tableView reloadData];
                                                                   } else  {
                                                                       [weakSelf pushAirPowerLossVC];
                                                                   }
                                                               }
                                                           rightBtnTitle:@"取消"
                                                              rightBlock:^{
                                                                  
                                                              }];
            [GLOBAL_KEYWINDOW addSubview:reminder];
        });
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AirPowerCell *cell;
    
    if (indexPath.row == 0) {
        reusedID = kReusedIdTop;
    } else if (indexPath.row == 5) {
        reusedID = kReusedIdBottom;
    } else if (indexPath.row == 6) {
        reusedID = _model.status < AirPowerStatusWaitRefundCheck ? kReusedIdBottom : kReusedIdMiddle;
    } else {
        reusedID = kReusedIdMiddle;
    }
    //    NSLog(@"%ld = %@",(long)indexPath.row,reusedID);
    cell = [tableView dequeueReusableCellWithIdentifier:reusedID forIndexPath:indexPath];
    if (indexPath.row == 0) {
        typeof(self)weakSelf = self;
        cell.introBlock = ^ {
            [weakSelf pushProducIntoWebViewController];
        };
    }
    cell.backgroundColor = self.tableView.backgroundColor;
    [self setupCell:cell Row:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"🔌" message:@"请选择电源状态" preferredStyle:UIAlertControllerStyleActionSheet];
        __weak typeof(self)weakSelf = self;
        for(int i = 0 ; i < 10; i ++) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:[self statusWithIndex:i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf.model setStatus:i];
                [weakSelf.tableView reloadData];
            }];
            [vc addAction:action];
        }
        [weakSelf.navigationController presentViewController:vc animated:YES completion:nil];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *reusedID = nil;
//    if (indexPath.row == 0) {
//        reusedID = kReusedIdTop;
//    } else if (indexPath.row == 5 || indexPath.row == 6) {
//        reusedID = kReusedIdBottom;
//    } else {
//        reusedID = kReusedIdMiddle;
//    }
//    AirPowerCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
//   CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
//    return height + 1;
//}
#pragma mark - 挂失充值  -
- (void)pushAirPowerLossVC {
    AirPowerLossVC *vc= [[AirPowerLossVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setupCell:(AirPowerCell *)cell Row:(NSInteger)row {
    cell.status = self.model.status;
    switch (row) {
        case 0:
            cell.topStatus      = self.model.topStatus;
            cell.bottomStatus   = _model.bottomStatus;
            cell.time           = _model.time;
            cell.serialNum      = _model.serialNum;
            cell.imageStr       = _model.imageStr;
            break;
        case 1:
            cell.title          = self.titleArray[0];
            cell.message        = _model.orderNum;
            break;
        case 2:
            cell.title          = self.titleArray[1];
            cell.message        = _model.courierNum;
            break;
        case 3:
            cell.title          = self.titleArray[2];
            cell.message        = _model.expressCompany;
            break;
        case 4:
            cell.title          = self.titleArray[3];
            cell.message        = _model.depreciation;
            break;
        case 5:
            if (_model.status < AirPowerStatusWaitRefundCheck) {
                cell.title          = self.titleArray[4];
                cell.person         = _model.sender;
                cell.city           = _model.senderCity;
                cell.area           = _model.senderArea;
                cell.address        = _model.senderAddr;
                cell.phone          = _model.senderPhone;
            } else {
                cell.title          = self.titleArray[4];
                cell.person         = _model.receiver;
                cell.city           = _model.receiverCity;
                cell.area           = _model.receiverArea;
                cell.address        = _model.receiverAddr;
                cell.phone          = _model.receiverPhone;
            }
            break;
        case 6:
            if (_model.status < AirPowerStatusWaitRefundCheck) {
                
                cell.title          = self.titleArray[5];
                cell.person         = _model.receiver;
                cell.city           = _model.receiverCity;
                cell.area           = _model.receiverArea;
                cell.address        = _model.receiverAddr;
                cell.phone          = _model.receiverPhone;
            } else {
                cell.title          = self.titleArray[5];
                cell.message        = _model.note;
            }
            break;
            
        default:
            break;
    }
}

#pragma mark - 控制器跳转  -
//产品使用说明
- (void)pushProducIntoWebViewController {
    WKWebViewController *webvc = [WKWebViewController webVCWithTitlt:@"使用说明" type:WKWebVCTypePlayIntro];
    [self.navigationController pushViewController:webvc animated:YES];
}

- (AirPowerModel *)model {
    if (!_model) {
        _model = [[AirPowerModel alloc] init];
        _model.topStatus        = @"已发货";
        _model.bottomStatus     = @"已激活";
        _model.imageStr         = @"imgs_main_power";
        _model.time             = @"2017年3月6日";
        _model.serialNum        = @"1234567890";
        _model.orderNum         = @"X1234567899";
        _model.courierNum       = @"123456789";
        _model.expressCompany   = @"顺丰快递";
        _model.depreciation     = @"180.00";
        _model.sender           = @"胡八一";
        _model.senderAddr       = @"钦州路100号1号楼901";
        _model.senderCity       = @"上海市";
        _model.senderArea       = @"徐汇区";
        _model.senderPhone      = @"13555555555";
        _model.receiver         = @"小田";
        _model.receiverAddr     = @"钦州路100号1号楼901钦州路100号1号楼901钦州路100号1号楼901钦州路100号1号楼901";
        _model.receiverCity     = @"上海市";
        _model.receiverArea     = @"徐汇区";
        _model.receiverPhone    = @"13555555555";
        _model.note             = @"电源插入无反应,不能使用电力骑行模式";
    }
    return _model;
}

- (NSArray *)titleArray {
    return  @[@"订 单 号:",
              @"快递单号:",
              @"快递公司:",
              @"折旧金额:",
              _model.status < AirPowerStatusWaitRefundCheck ? @"发货地址:" : @"我的信息:",
              _model.status < AirPowerStatusWaitRefundCheck ? @"我的信息:" : @"留        言:"
              ];
}

- (AirPowerView *)airPowerView {
    if (!_airPowerView) {
        AirPowerView *view      = [[AirPowerView alloc] initWithFrame:self.view.frame];
        _airPowerView           = view;
        _airPowerView.delegate  = self;
    }
    return _airPowerView;
}

- (NSString *)statusWithIndex:(NSInteger)index {
    NSArray *status = @[@"正在处理",
                        @"已发货",
                        @"已配对",
                        @"配对取消",
                        @"挂失成功",
                        @"押金退还待审核",
                        @"押金退还审核中",
                        @"电源维修待审核",
                        @"电源维修审核中",
                        @"电源维修审核失败",
                        ];
    if (index >= status.count) {
        return nil;
    }
    return status[index];
}

@end
