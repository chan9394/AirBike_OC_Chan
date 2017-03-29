//
//  ZHHUserInfo.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/11/28.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHUserInfo.h"
#import "ZHHLogModel.h"
#import "ZHHGetUserInfoMod.h"

@implementation ZHHUserInfo

+ (ZHHLogModel *)sharedUserInfo {
    // 从文件中读取MJStudent对象
    ZHHLogModel *user = [NSKeyedUnarchiver unarchiveObjectWithFile:[self dataFile]];
    return user;
}
+ (BOOL)hasLogOn {
    //改修后缀名，以免与属性列表创建的文件重复，而加载成旧的的文件。 不用查字典了。。archive表归档
    return [[NSFileManager defaultManager] fileExistsAtPath:[self dataFile]];
}

+ (NSString *)dataFile {
    NSArray *ar = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString *fielpath = [ar objectAtIndex:0];
    return [fielpath stringByAppendingPathComponent:@"user.data"];
}

+ (void)keyedArchiverUserInfo:(ZHHLogModel *)model {
    [NSKeyedArchiver archiveRootObject:model toFile:[self dataFile]];
}

+ (void)logOut {
    [[NSFileManager defaultManager] removeItemAtPath:[self dataFile] error:nil];
    [[NSFileManager defaultManager] removeItemAtPath:[self userInfoModDataFile] error:nil];
}

+ (ZHHGetUserInfoMod *)shareGetUserInfoMod {
    ZHHGetUserInfoMod *user = [NSKeyedUnarchiver unarchiveObjectWithFile:[self userInfoModDataFile]];
    return user;
}

+ (NSString *)userInfoModDataFile {
    NSArray *ar = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString *fielpath = [ar objectAtIndex:0];
    return [fielpath stringByAppendingPathComponent:@"userMod.data"];
}

+ (void)keyedArchiverGetUserInfoMod:(ZHHGetUserInfoMod *)model {
    [NSKeyedArchiver archiveRootObject:model toFile:[self userInfoModDataFile]];
}
@end
