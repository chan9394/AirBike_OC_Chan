//
//  ZHHReportModel.h
//  AirBk
//
//  Created by 郑洪浩 on 2016/12/12.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHHReportModel : NSObject
@property (nonatomic, copy)NSString *user_id;///<标注#>
@property (nonatomic, copy)NSString *usetyper_id;///<标注#>
@property (nonatomic, copy)NSString *category;///<标注#>
@property (nonatomic, copy)NSString *adescription;
@property (nonatomic, copy)NSString *created;///<标注#>
@property (nonatomic, copy)NSString *status;///<标注#>
@property (nonatomic, copy)NSString *pictures;///<标注#>
@property (nonatomic, copy)NSString *reportId;///<标注#>
@end
