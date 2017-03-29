//
//  HHNetWork.h
//  Mobike
//
//  Created by 郑洪浩 on 16/10/14.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

/*
 对AFNetWorking第三方类进行进一步封装,减少耦合性
 */
@interface HHNetWork : NSObject

/**
 NSURLSession POST网络请求的参数

 @param data 返回的数据
 @param response 响应
 @param error 错误
 */
typedef void(^HttpResultBlock)(
NSData * _Nullable data,
NSURLResponse * _Nullable response,
NSError * _Nullable error
);

/**
 AFN POST上传请求progress参数

 @param uploadProgress 返回的progress值
 */
typedef void(^progress)(
NSProgress * _Nonnull uploadProgress
);

/**
 AFN POST上传请求成功回调参数

 @param task 发送上传请求的对象
 @param responseObject 响应对象
 */
typedef void(^success)(
NSURLSessionDataTask * _Nonnull task,
id  _Nullable responseObject
);

/**
 AFN POST上传请求错误回调参数

 @param task 发送上传请求的对象
 @param error 网络错误
 */
typedef void(^error)(
NSURLSessionDataTask * _Nullable task,
NSError * _Nonnull error
);


/**
 封装NSURLSession POST方法

 @param urlStr url字符串
 @param block 网络请求的结果 块实现
 @param timerInterVal 设置请求超时时间
 */
+(void)netWorkPostWithUrlStr:(NSString *)urlStr
                  httpResult:(HttpResultBlock)block
                 setOutTimer:(NSTimeInterval)timerInterVal;

/**
 封装AFN POST方法

 @param urlStr url字符串
 @param dic 上传参数字典
 @param pro progress参数
 @param suc success参数
 @param err error参数
 */
+(void)netWorkPostWith:(NSString *)urlStr
            parameters:(NSDictionary *)dic
              progress:(progress)pro
               success:(success)suc
                 error:(error)err;

@end
