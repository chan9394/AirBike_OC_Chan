//
//  UIImage+ZHHImageEncodeCat.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/12/11.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "UIImage+ZHHImageEncodeCat.h"

@implementation UIImage (ZHHImageEncodeCat)
-(NSString *)encodeImageToBase64{
    
    NSData *data = UIImageJPEGRepresentation(self, 0.1f);
    
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSLog(@"%lud",(unsigned long)encodedImageStr.length);
    return encodedImageStr;
    
}
@end
