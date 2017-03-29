//
//  NSString+ZHHEncode.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/12/6.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "NSString+ZHHEncode.h"

#import <CommonCrypto/CommonDigest.h>

@implementation NSString (ZHHEncode)
-(NSString *)encodeMd5{
    //对扫描的数据进行打包
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (int)strlen(cStr), result );
    
    NSString *str5 =  [[NSString stringWithFormat:
                        
                        @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                        
                        result[0], result[1], result[2], result[3],
                        
                        result[4], result[5], result[6], result[7],
                        
                        result[8], result[9], result[10], result[11],
                        
                        result[12], result[13], result[14], result[15]
                        
                        ] lowercaseString];
    
    return str5;

}
-(NSString *)encodedBase64{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}
-(NSString *)decodedBase64{
    NSData *nsdataFromBase64String = [[NSData alloc]
                                      initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    return [[NSString alloc] initWithData:nsdataFromBase64String encoding:NSUTF8StringEncoding];
}
-(UIImage *)base64DecodeImage{
    //Base64字符串转UIImage图片：
    
    NSData *decodedImageData = [[NSData alloc]
                                
                                initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    UIImage *decodedImage = [UIImage imageWithData:decodedImageData];
    
    return decodedImage;

}
@end
