//
//  NetworkTools.m
//  networdTest
//
//  Created by 朱玉龙 on 16/12/4.
//  Copyright © 2016年 朱玉龙. All rights reserved.
//

#import "NetworkTools.h"

@interface NetworkTools ()

@end
@implementation NetworkTools


+ (instancetype)shareNetworkTools {
    static NetworkTools *tools = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tools = [[NetworkTools alloc] init];
        tools.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        tools.requestSerializer = [AFHTTPRequestSerializer serializer];
        tools.requestSerializer.timeoutInterval = 8.0f;
    });
    return tools;
}

- (NSURLSessionDataTask *)postUrlString:(NSString *)aurlStr parameters:(NSDictionary *)paramters finished:(void(^)(id reponse,NSError * error))finished {
    NSString *urlStr = [AirBike_Url_Domain stringByAppendingString:aurlStr];
    return  [self POST:urlStr parameters:paramters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finished(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        if(error.code == -1001) {
            [HHProgressHUD showHUDInView:GLOBAL_KEYWINDOW animated:YES withText:@"请求超时,请稍后再试"];
            return;
        }
        finished(nil,error);
    }];
}
@end
