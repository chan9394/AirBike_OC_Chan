//
//  ZHHPublicTVC.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/11/1.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHPublicTVC.h"
#import "ZHHClearCache.h"
#define kCellH GLOBAL_V(60.0)

@interface ZHHPublicTVC () <ReminderViewDelegate>

@property (nonatomic ,strong)    NSArray                               *dataArray;

@property (nonatomic, strong)    ZHHClearCache                         *cache;

@end

@implementation ZHHPublicTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.tableView.tableFooterView =  [UIView new];
    self.tableView.rowHeight = kCellH;
    [self setupUI];
}

- (void)setupUI {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"guide" ofType:@"plist"];
    if (_type == PublicTypeGuide) {
        [self setupTitleWithText:@"用户指南"];
        _dataArray = [NSDictionary dictionaryWithContentsOfFile:path][@"guide"];
    } else {
        [self setupTitleWithText:@"设置"];
        _dataArray = [NSDictionary dictionaryWithContentsOfFile:path][@"setting"];
        UIButton *btn= [[UIButton alloc] initWithFrame:CGRectMake(GLOBAL_H(22), _dataArray.count * kCellH + GLOBAL_V(50), GLOBAL_SCREENW - GLOBAL_H(44), GLOBAL_V(44))];
        [btn setTitle:@"退出登录" forState:UIControlStateNormal];
        [btn setCornerRadiusWithRadius:GLOBAL_V(22) ];
        btn.backgroundColor = GLOBAL_ASSISTCOLOR;
        [btn addTarget:self action:@selector(quitLog) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pubCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"pubCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:13];
    }
    
    cell.textLabel.text = [_dataArray[indexPath.row] objectForKey:@"cellTitle"];
    cell.separatorInset = UIEdgeInsetsZero;
    return cell;
}

- (void)quitLog{
    ReminderView *view  = [ReminderView reminderViewWithMessage:@"您确定要退出吗?" leftBtnTitle:@"确定" rightBtnTitle:@"取消"];
    view.delegate = self;
    [[UIApplication sharedApplication].keyWindow addSubview:view];
}

- (void)reminderViewDidClickLeftBtn {
    [NetWorks logOutsucdess:^(id response) {
        [[AccountManager shareAccountManager] quit];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellTitle  = _dataArray[indexPath.row][@"cellTitle"];
    if ([_dataArray[indexPath.row][@"className"] isEqualToString:@"WKWebViewController"]) {
        NSNumber *type = _dataArray[indexPath.row][@"type"];
        WKWebViewController *vc = [WKWebViewController webVCWithTitlt:cellTitle type:type.intValue];
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if ([_dataArray[indexPath.row][@"className"] isEqualToString:@"clear"]) {
//        [ZHHClearCache showAlertVCInVC:self];
        ZHHClearCache *cache = [ZHHClearCache new];
        _cache = cache;
        [cache setupClearView];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.selected = NO;
    } else {
        NSString *className = _dataArray[indexPath.row][@"className"];
        if (!className) {
            return;
        }
        Class class = NSClassFromString(className);
        if (class) {
            id vc = [[class alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
}

@end
