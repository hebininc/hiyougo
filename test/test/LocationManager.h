//
//  LocationManager.h
//  test
//
//  Created by eshine on 15/8/20.
//  Copyright (c) 2015年 eshine. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    LocateEnumSuccess = 0,
    LocateEnumError  ,
    LocateEnumNone
}LocateStatusEnum;

@protocol LocationManagerDelegate <NSObject>

- (void)locateResult:(NSString *)result withStatus:(LocateStatusEnum)status;

@end
@interface LocationManager : NSObject

@property (assign,nonatomic) id<LocationManagerDelegate>delegate;
+ (LocationManager *)creatLocationManager;

- (void) startLocate;

- (void) endLocate;



@end
