//
//  YNLocation.m
//  2015-07－13
//
//  Created by 农盟 on 15/7/24.
//  Copyright (c) 2015年 YN. All rights reserved.
//

#import "YNLocation.h"


@interface YNLocation()<CLLocationManagerDelegate>



@end

@implementation YNLocation

- (void)startLocate {
    
    BOOL locationServicesEnabled = [CLLocationManager locationServicesEnabled];
    
    if (locationServicesEnabled) {
        
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
            
            if ([self.locationManger respondsToSelector:@selector(requestWhenInUseAuthorization )]) {
                [self.locationManger requestWhenInUseAuthorization];
                
            }
            
        } else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse){
            
//            self.locationManger.delegate = self;
            self.locationManger.desiredAccuracy = kCLLocationAccuracyBest;
            self.locationManger.distanceFilter = 10;
        }
        
        [self.locationManger startUpdatingLocation];
        
    } else {
        
        NSLog(@"定位未开启");
    }
    
}

#pragma mark - setters and getters

- (CLLocationManager *)locationManger {
    if (_locationManger == nil) {
        _locationManger = [[CLLocationManager alloc] init];
    }
    return _locationManger;
}

//- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
//    
//    NSLog(@"didUpdateLocations");
//}
//
//- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
//    
//    NSLog(@"didChangeAuthorizationStatus - %d", status);
//}

@end
