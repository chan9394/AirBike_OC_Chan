//
//  NSString+ZHHEncode.h
//  AirBk
//
//  Created by 郑洪浩 on 2016/12/6.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZHHEncode)
-(NSString *)encodeMd5;
-(NSString *)encodedBase64;
-(NSString *)decodedBase64;
-(UIImage *)base64DecodeImage;
@end
