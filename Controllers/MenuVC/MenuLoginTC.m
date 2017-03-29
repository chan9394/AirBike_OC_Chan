//
//  MenuLoginTC.m
//  AirBk
//
//  Created by Damo on 2017/1/18.
//  Copyright © 2017年 ZHH. All rights reserved.
//

#import "MenuLoginTC.h"
#import "MenuUserView.h"
#import "HintModel.h"
#import "MenuLoginCell.h"
#import "MenuUserView.h"
#import "ZHHReisterLogOnVC.h"
static NSString *reuseId = @"MenuLoginTCReuseID";

@interface MenuLoginTC () <MenuUserViewDelegate>

@property (nonatomic, strong) NSArray <HintModel *> *dataArray;

@end

@implementation MenuLoginTC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self.tableView registerClass:[MenuLoginCell class] forCellReuseIdentifier:reuseId];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setupTitleViewWithImage:@"imgs_main_logo2"];
}

- (void)setupUI {
    MenuUserView *userView = [MenuUserView userView];
    userView.delegate = self;
    userView.x = 0;
    userView.y = 0;
    userView.width = GLOBAL_SCREENW;
    userView.height = GLOBAL_V(290);
    self.tableView.tableHeaderView = userView;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuLoginCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId forIndexPath:indexPath];
    HintModel *model = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuLoginCell *cell = [[MenuLoginCell alloc] init];
    cell.model = self.dataArray[indexPath.row];
    if (indexPath.row == 5) {
        return cell.modelHeight + 10;
    }
    return cell.modelHeight;
}

- (void)pushRegisterVC {
    ZHHReisterLogOnVC *vc = [[ZHHReisterLogOnVC alloc] init];
    vc.view.frame = self.view.bounds;
    vc.logOnHandle = ^(){
        [self.navigationController popToRootViewControllerAnimated:YES];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MenuHint" ofType:@"plist"]];
        NSArray<NSDictionary *> *ary = [dic objectForKey:@"hintAry"];
        NSMutableArray *marray = [NSMutableArray array];
        [ary enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HintModel *model1 = [HintModel hintModelWith:ary[idx]];
            [marray addObject:model1];
        }];
        _dataArray = marray.copy;
    }
    return _dataArray;
}

@end
