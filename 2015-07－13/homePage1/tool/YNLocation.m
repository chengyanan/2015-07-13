//
//  YNLocation.m
//  2015-07－13
//
//  Created by 农盟 on 15/7/24.
//  Copyright (c) 2015年 YN. All rights reserved.
//

#import "YNLocation.h"
#import <CoreLocation/CoreLocation.h>

@interface YNLocation()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManger;

@end

@implementation YNLocation

- (void)startLocate {
    
    
    if ([CLLocationManager locationServicesEnabled]) {
        
        NSLog(@"定位未开启");
    }
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        
        if ([self.locationManger respondsToSelector:@selector(requestWhenInUseAuthorization )]) {
            [self.locationManger requestWhenInUseAuthorization];
            
        }

    } else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse){
        
        self.locationManger.delegate = self;
        self.locationManger.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManger.distanceFilter = 1000;
        
    }
    
     [self.locationManger startUpdatingLocation];
}

#pragma mark - setters and getters

- (CLLocationManager *)locationManger {
    if (_locationManger == nil) {
        _locationManger = [[CLLocationManager alloc] init];
    }
    return _locationManger;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
//    NSLog(@"didChangeAuthorizationStatus - %d", status);
}

@end
