//
//  NSArray+Order.m
//  AirBk
//
//  Created by Damo on 2017/2/20.
//  Copyright © 2017年 ZHH. All rights reserved.
//

#import "NSArray+Order.h"
#import "SearchHistoryModel.h"

@implementation NSArray (Order)

- (NSArray<SearchHistoryModel *> *)OrderedDescending {
    
    NSArray <SearchHistoryModel *> *modelArr  = self;
   NSArray *sortArray = [modelArr sortedArrayUsingComparator:^NSComparisonResult(SearchHistoryModel *  _Nonnull obj1, SearchHistoryModel *  _Nonnull obj2) {
        return [obj2.updateTime compare:obj1.updateTime];
    }];
    
    return sortArray;
}

- (NSArray<SearchHistoryModel *> *)OrderedAcending {
    
    NSArray <SearchHistoryModel *> *modelArr  = self;
    NSArray *sortArray = [modelArr sortedArrayUsingComparator:^NSComparisonResult(SearchHistoryModel *  _Nonnull obj1, SearchHistoryModel *  _Nonnull obj2) {
        return [obj1.updateTime compare:obj2.updateTime];
    }];
    return sortArray;
}

@end
