//
//  NetworkTools.h
//  networdTest
//
//  Created by 朱玉龙 on 16/12/4.
//  Copyright © 2016年 朱玉龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFHTTPSessionManager.h>

@interface NetworkTools : AFHTTPSessionManager

typedef void(^netToolFinish)(id response ,NSError *error);

+ (instancetype)shareNetworkTools;

- (NSURLSessionDataTask *)postUrlString:(NSString *)urlStr parameters:(NSDictionary *)paramters finished:(void(^)(id response,NSError *error))finished;

@end
