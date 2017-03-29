//
//  NSArray+Order.h
//  AirBk
//
//  Created by Damo on 2017/2/20.
//  Copyright © 2017年 ZHH. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SearchHistoryModel;

@interface NSArray (Order)

//降序
- (NSArray <SearchHistoryModel *> *)OrderedDescending;

//升序
- (NSArray<SearchHistoryModel *> *)OrderedAcending;
@end
