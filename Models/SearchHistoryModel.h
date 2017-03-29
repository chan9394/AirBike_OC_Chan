//
//  SearchHistoryModel.h
//  AirBk
//
//  Created by Damo on 2017/2/17.
//  Copyright © 2017年 ZHH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchHistoryModel : NSObject <YYModel>

@property (nonatomic, strong) NSArray <SearchHistoryModel *>  *listArray;    //搜索的历史记录
@property (nonatomic,   copy) NSString                        *ID;           //记录的编号
@property (nonatomic,   copy) NSString                        *searchKey;    //搜索的键
@property (nonatomic,   copy) NSString                        *searchAddr;   //搜索的值
@property (nonatomic,   copy) NSString                        *updateTime;   //地址更新的时间


//json转模型
- (void)modelWIthJSON:(id)json;

@end
