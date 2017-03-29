//
//  ZHHMyNewsCell.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/11/3.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHMyNewsCell.h"

@implementation ZHHMyNewsCell



+ (instancetype)myNewsCellWithTableView:(UITableView *)tableView
{
    NSString *ID = @"myNewsCell";
    ZHHMyNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"myNibs" owner:nil options:nil][1] ;
        //这里需要注意的是为什么是lastObject 应为该Xib中只有一个元素
    }
    return cell;
}
+(instancetype)myNewCell{
    
    ZHHMyNewsCell *cell= [[NSBundle mainBundle] loadNibNamed:@"myNibs" owner:nil options:nil][1];
    return cell;
    
}



@end
