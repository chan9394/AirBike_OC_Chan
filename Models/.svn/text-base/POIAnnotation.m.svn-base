//
//  POIAnnotation.m
//  Map
//
//  Created by 郑洪浩 on 16/10/9.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "POIAnnotation.h"
#import "ZHHBikeModel.h"

@implementation POIAnnotation

-(instancetype)initWithPOI:(AMapPOI *)obj{
    
    if (self = [super init]) {
        
        CLLocationCoordinate2D newCoordinate;
        newCoordinate.latitude = obj.location.latitude;
        newCoordinate.longitude = obj.location.longitude;
        [self setCoordinate:newCoordinate];
        self.title = obj.name;
        self.subtitle = obj.address;
        self.hasCollected = NO;
        
    }
    return self;
    
}
-(void)setCoordinate:(CLLocationCoordinate2D)newCoordinate{
    
    _coordinate = newCoordinate;
    
}

-(instancetype)initWithCoordinate:(CLLocationCoordinate2D)newCoordinate{
    self.coordinate = newCoordinate;
    return self;
}

-(instancetype)initWithLongitude:(CGFloat)longitude andLatitude:(CGFloat)latitude{
    
    if (self = [super init]) {
        
        CLLocationCoordinate2D newCoordinate;
        newCoordinate.latitude = latitude;
        newCoordinate.longitude = longitude;
        [self setCoordinate:newCoordinate];

    }
    return self;
    
}
-(instancetype)initWithCoordinate:(CLLocationCoordinate2D)newCoordinate andTitle:(NSString *)title{
    
    if (self = [super init]) {
        
        self.coordinate = newCoordinate;
        self.title = title;
        
        
    }
    return self;
    
}
-(instancetype)initWithCoordinate:(CLLocationCoordinate2D)newCoordinate andTitle:(NSString *)title subTitle:(NSString *)subTitle{
    
    if (self = [super init]) {
        
        self.coordinate = newCoordinate;
        self.title = title;
        self.subtitle = subTitle;
        
        
    }
    return self;
    
}
- (void)encodeWithCoder:(NSCoder *)coder
{
    NSNumber *latitude = [NSNumber numberWithDouble:self.coordinate.latitude];
    NSNumber *longitude = [NSNumber numberWithDouble:self.coordinate.longitude];
    [coder encodeObject:latitude forKey:@"latitude"];
    [coder encodeObject:longitude forKey:@"longitude"];
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.subtitle forKey:@"subtitle"];
    NSNumber *hasCollectec =  @(self.hasCollected);
    [coder encodeObject:hasCollectec forKey:@"hasCollected"];
    
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        CLLocationDegrees latitude = (CLLocationDegrees)[(NSNumber*)[coder decodeObjectForKey:@"latitude"] doubleValue];
        CLLocationDegrees longitude = (CLLocationDegrees)[(NSNumber*)[coder decodeObjectForKey:@"longitude"] doubleValue];
        self.coordinate = (CLLocationCoordinate2D) { latitude, longitude };
        self.title = [coder decodeObjectForKey:@"title"];
        self.subtitle = [coder decodeObjectForKey:@"subtitle"];
        self.hasCollected = [[coder decodeObjectForKey:@"hasCollected"] boolValue];
    }
    return self;
}
+(instancetype)annotationWithBikeModel:(ZHHBikeModel *)model{
    
    CGFloat log = [model.longitude floatValue] ;
    CGFloat lat = [model.latitude floatValue] ;
    CLLocationCoordinate2D coor = CLLocationCoordinate2DMake(lat, log);
    POIAnnotation *anno = [[POIAnnotation alloc] initWithCoordinate:coor];
    anno.modelBike = model;
    return anno;
    
}
@end

@implementation RedWaterAnnotation

@end
