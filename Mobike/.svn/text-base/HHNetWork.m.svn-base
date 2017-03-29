//
//  HHNetWork.m
//  Mobike
//
//  Created by 郑洪浩 on 16/10/14.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "HHNetWork.h"

@implementation HHNetWork

+(void)netWorkPostWithUrlStr:(NSString *)urlStr httpResult:(HttpResultBlock)block setOutTimer:(NSTimeInterval)timerInterVal{
    
    //创建urlRequest
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setTimeoutInterval:timerInterVal];
    [urlRequest setHTTPMethod:@"POST"];

    //创建HTTPSessionManager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    //发送网络请求
    [[session dataTaskWithRequest:urlRequest
                completionHandler:^(
                                    NSData * _Nullable data,
                                    NSURLResponse * _Nullable response,
                                    NSError * _Nullable error
                                    )
    {
        
        block(data,response,error);
        
    }] resume];
    
}

+(void)netWorkPostWith:(NSString *)urlStr parameters:(NSDictionary *)dic progress:(progress)pro success:(success)suc error:(error)err{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [manager POST:urlStr
       parameters:dic
         progress:^(
                    NSProgress * _Nonnull uploadProgress
                    )
    {
        
        pro(uploadProgress);
        
    } success:^(
                NSURLSessionDataTask * _Nonnull task,
                id  _Nullable responseObject
                )
    {
        
        suc(task,responseObject);
        
    } failure:^(
                NSURLSessionDataTask * _Nullable task,
                NSError * _Nonnull error
                )
    {
        
        err(task,error);
        
    }];

}


@end
