//
//  ZHHTrackInfoModel.h
//  AirBk
//
//  Created by 郑洪浩 on 2016/12/12.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TrackListModel.h"

@interface ZHHTrackInfoModel : NSObject <YYModel>

@property (nonatomic, strong) NSArray <TrackListModel *> *listModel;  //记录明细
@property (nonatomic,   copy) NSString                              *page;       //页数
@property (nonatomic,   copy) NSString                              *count;      //个数

- (void)modelWithJSON:(id)json;

@end
