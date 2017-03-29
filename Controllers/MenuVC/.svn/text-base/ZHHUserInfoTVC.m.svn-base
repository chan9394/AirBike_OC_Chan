//
//  ZHHUserInfoTVC.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/11/10.
//  Copyright © 2016年 ZHH. All rights reserved.
//
#import "ZHHChangePhoneVC.h"
#import "ZHHUserInfoTVC.h"
#import "ZHHPicketPhotoVC.h"
#import "ZHHChangeNameVC.h"
#import "UIImage+ZHHImageEncodeCat.h"
#define kHeadHeight  120.0
#define kOtherHeight  70.0


@interface ZHHUserInfoTVC ()<ZHHPicketPhotoVCDelegate>
@property (nonatomic, strong) NSArray              *cellNameAry;//cell的title
@property (nonatomic,   weak) AccountManager *manager;      //用户信息

@end

@implementation ZHHUserInfoTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor whiteColor];
    NSDictionary *dic =[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MenuHint" ofType:@"plist"]];
    NSDictionary *cellnameDic = [dic objectForKey:@"userInfoTvc"];
    NSArray *cellNameAry = [cellnameDic objectForKey:@"cellName"];
    self.cellNameAry = cellNameAry;
    [self setupTitleWithText:@"个人信息"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [NetWorks getUserInfoDetailSuccessGet:^(id response) {
        AccountManager *manager = [AccountManager shareAccountManager];
        [manager yy_modelSetWithJSON:response];
        [self.tableView reloadData];
    } pushRegisterVC:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cellNameAry.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ((NSArray *)self.cellNameAry[section]).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"2"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"2"];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            UIImageView *view = [[UIImageView alloc] init];
            view.frame = CGRectMake(GLOBAL_H(265), (kHeadHeight - GLOBAL_H(74) ) / 2, GLOBAL_H(74), GLOBAL_H(74));
            view.tag = 15;
            [cell.contentView addSubview:view];
        }
        
        UIImageView *view = [cell viewWithTag:15];
        view.image = [UIImage imageNamed:@"imgs_menu_person"];
        [view loadImageUrlStr:self.manager.urlStr placeHolderImageName:nil radius:CGFLOAT_MIN];
        cell.backgroundColor = [UIColor colorWithRed:248.0 / 255 green:254.0 / 255 blue:254.0 / 255 alpha:1];
        cell.textLabel.text = ((NSArray *)self.cellNameAry[indexPath.section])[indexPath.row];
    }
    else  if (indexPath.section == 0&& (indexPath.row == 1 || indexPath.row == 4)){
        cell = [tableView dequeueReusableCellWithIdentifier:@"1"];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"1"];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - GLOBAL_H(185), 0, GLOBAL_H(150), kOtherHeight)];
            label.font = [UIFont systemFontOfSize:13];
            label.textColor = GLOBAL_CONTENTCOLOR;
            label.textAlignment = NSTextAlignmentRight;
            label.tag = 15;
            [cell.contentView addSubview:label];
        }
        
        UILabel *label = [cell viewWithTag:15];
        if (indexPath.row == 1) {
            label.text = self.manager.userModel.nickName;
        }else if(indexPath.row == 4){
            label.text = self.manager.userModel.mobile;
        }
    } else if (indexPath.section == 0 && (indexPath.row == 2 || indexPath.row == 3)){
        cell = [tableView dequeueReusableCellWithIdentifier:@"3"];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"3"];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(GLOBAL_H(250),0, GLOBAL_H(100),kOtherHeight)];
            label.font = [UIFont systemFontOfSize:13];
            label.textColor = GLOBAL_CONTENTCOLOR;
            label.textAlignment = NSTextAlignmentRight;
            label.tag = 15;
            [cell.contentView addSubview:label];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        UILabel *label = [cell viewWithTag:15];
        if (indexPath.row == 2) {
            NSString *name = @"未认证";
            if ([self.manager hasRealName]) {
                name = self.manager.userModel.realName;
            }
            label.text =name;
        } else {
            NSString *name = @"未认证";
            if ([self.manager hasRealName]) {
                name = @"已认证";
            }
            label.text = name;
        }
    }
    cell.textLabel.text = ((NSArray *)self.cellNameAry[indexPath.section])[indexPath.row];
    cell.textLabel.textColor = GLOBAL_CONTENTCOLOR;
    
    if (indexPath.section == 0 && (indexPath.row ==0 || indexPath.row == 1|| indexPath.row == 4)) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.separatorInset = UIEdgeInsetsZero;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0&&indexPath.row==0) {
        return kHeadHeight;
    }
    return kOtherHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView cellForRowAtIndexPath:indexPath].selected = NO;
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        ZHHPicketPhotoVC *vc =[[ZHHPicketPhotoVC alloc] init];
        vc.delegate = self;
        [self.view addSubview:vc.view];
        [self addChildViewController:vc];
    } else if (indexPath.section == 0&& indexPath.row == 1){
        ZHHChangeNameVC *vc = [[ZHHChangeNameVC alloc] init];
        vc.view.frame = self.navigationController.view.frame;
        vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self.navigationController presentViewController:vc animated:YES completion:^{
        }];
    } else if(indexPath.section == 0 &&indexPath.row == 4){
        ZHHChangePhoneVC *vc = [[ZHHChangePhoneVC alloc] init];
        vc.view.frame = self.view.frame;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)hhPickerController:(ZHHPicketPhotoVC *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [self updateimageHeader:info[UIImagePickerControllerOriginalImage]];
}

#pragma mark - 上传头像 网络请求 -
- (void)updateimageHeader:(UIImage *)image {
    typeof (self) weakSelf = self;
    
    [NetWorks changeHeadImg:[image encodeImageToBase64] andSuccess:^(id response) {
        [weakSelf.manager.userModel modelWIthJSON:response[@"result"]];
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        UIImageView *viewImg = [cell.contentView viewWithTag:15];
        UIImage *img = [image drawRctWithRoundCorner:viewImg.height / 2 andSize:viewImg.size];
        [viewImg setImage:img];
    }];
}

- (AccountManager *)manager {
    return [AccountManager shareAccountManager];
}
@end
