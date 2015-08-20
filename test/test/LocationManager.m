//
//  LocationManager.m
//  test
//
//  Created by eshine on 15/8/20.
//  Copyright (c) 2015年 eshine. All rights reserved.
//

#import "LocationManager.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>


@interface LocationManager ()<CLLocationManagerDelegate>
@property (nonatomic,strong) CLLocationManager *locationManager;
@end


@implementation LocationManager

+(LocationManager *)creatLocationManager{
    static LocationManager *location = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        location = [[LocationManager alloc]init];
    });
    return location;
}

- (void)startLocate{
    [self setupLocate];
}
- (void)setupLocate{
    _locationManager = [[CLLocationManager alloc]init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.distanceFilter  = 100.0f;
    if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        //requestWhenInUseAuthorization requestAlwaysAuthorization
        [_locationManager requestWhenInUseAuthorization];
    }
    [_locationManager startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *newLocation = [locations firstObject];
   // CLLocationCoordinate2D coordinate = newLocation.coordinate;
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks.count > 0) {
            for (CLPlacemark *placemark in placemarks) {
                if ([_delegate respondsToSelector:@selector(locateResult:withStatus:)]) {
                    [_delegate locateResult:placemark.name withStatus:LocateEnumSuccess];
                }
            }
            return ;
        }else{
            //定位失败
            if ([_delegate respondsToSelector:@selector(locateResult:withStatus:)]) {
                [_delegate locateResult:nil withStatus:LocateEnumError];
            }
        }
    }];
    
    // test the age of the location measurement to determine if the measurement is cached
    // in most cases you will not want to rely on cached measurements
    NSTimeInterval locationAge = -[newLocation.timestamp timeIntervalSinceNow];
    if (locationAge > 5.0) {
        return;
    }
    
    // test that the horizontal accuracy does not indicate an invalid measurement
    if (newLocation.horizontalAccuracy < 0) {
        return;
    }
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"error  %@",[error localizedDescription]);
    
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    
}
- (void)endLocate{
    [_locationManager stopUpdatingLocation];
    _locationManager.delegate = nil;
}
@end
