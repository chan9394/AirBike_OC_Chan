//
//  NSDate+Fomatter.m
//  air_bike
//
//  Created by Damo on 16/12/11.
//  Copyright © 2016年 Damo. All rights reserved.
//

#import "NSDate+Formatter.h"

@implementation NSDate (Formatter)

+ (NSString *)dateWithNumber:(NSNumber *)time {
    NSDate *aTime = [NSDate dateWithTimeIntervalSince1970:[time integerValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    NSString *timeStr = [formatter stringFromDate:aTime];
    return timeStr;
}

@end
