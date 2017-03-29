//
//  ZHHAddrManageCell.h
//  AirBk
//
//  Created by 郑洪浩 on 2016/12/2.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHHPostAddress.h"

@class ZHHAddrManageCell;
@protocol ZHHAddrManageCellDelegate <NSObject>

-(void)changeDefaultAddr:(ZHHAddrManageCell *)cell;
-(void)deleteAddr:(ZHHAddrManageCell *)cell;
-(void)editAddr:(ZHHAddrManageCell *)cell;

@end

@interface ZHHAddrManageCell : UITableViewCell

@property (nonatomic, weak)id<ZHHAddrManageCellDelegate> delegate;//代理

@property (nonatomic, strong)ZHHPostAddress *address;//地址模型
@property (nonatomic, assign)BOOL isDefaultAdr;//默认地址
+(instancetype)addrmanageCell;

@end
