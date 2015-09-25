//
//  YNNearbyViewController.m
//  2015-07－13
//
//  Created by 农盟 on 15/7/29.
//  Copyright (c) 2015年 YN. All rights reserved.
//

#import "YNNearbyViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "YNBaseAnnotation.h"
#import "YNCallOutAnnotation.h"
#import "YNCallOutAnnotationView.h"
#import "YNLocationAnnotation.h"
#import "YNCallOutContentView.h"
#import "YNWGS84TOGCJ02.h"
#import "YNEnterpriseViewController.h"

#define LatitudeDelta 0.003739
#define LongitudeDelta 0.003201

@interface YNNearbyViewController ()<MKMapViewDelegate, CLLocationManagerDelegate, YNCallOutContentViewDelegate>
@property (nonatomic, strong)  MKMapView *mapview;
@property (nonatomic, strong)  UIButton *locationButton;

@property (nonatomic, strong)  YNCallOutAnnotation *callOutAnnotation;

@property (nonatomic, strong)  YNCallOutAnnotationView *callOutAnnotationView;
//@property (nonatomic, strong)  YNCallOutAnnotationView *tempCallOutAnnotationView;

@property (nonatomic, strong) CLLocationManager *locationManger;
@property (nonatomic, strong) CLLocation *currentLocation;
@property (nonatomic, strong) YNLocationAnnotation *locationAnnotation;
@property (nonatomic, strong) CLGeocoder *geocder;

@property (nonatomic, assign) BOOL isLocated;
@property (nonatomic, assign) BOOL isDeleteAnnotation;

@property (nonatomic, strong) NSArray *enterpriseArray;

@property (nonatomic, assign) NSInteger dataIndex;//数据的索引
@end

@implementation YNNearbyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.mapview];
    [self.view addSubview:self.locationButton];
    
    [self startLocate];
}

- (void)setlayout {
    
}

#pragma mark - life cycle
#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[YNBaseAnnotation class]]) {
        
        static NSString *identify = @"PINANNOTATIONVIEW";
        
        MKPinAnnotationView *pinAnnotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identify];
        if (pinAnnotationView == nil) {
            pinAnnotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identify];
        }
        pinAnnotationView.canShowCallout = NO;
        pinAnnotationView.pinColor = MKPinAnnotationColorPurple;
        return pinAnnotationView;
        
    } else  if ([annotation isKindOfClass:[YNCallOutAnnotation class]]){
        
        static NSString *identify = @"CALLOUTANNOTATIONVIEW";
        
        YNCallOutAnnotationView *callOutAnnotationView = (YNCallOutAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identify];
        if (callOutAnnotationView == nil) {
            callOutAnnotationView = [[YNCallOutAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identify];
        }
        
        callOutAnnotationView.alpha = 1.0;
        self.callOutAnnotationView = callOutAnnotationView;
        YNCallOutContentView *view = [[YNCallOutContentView alloc] initWithFrame:callOutAnnotationView.bounds];
        view.delegate = self;
        [callOutAnnotationView addSubview:view];
        
        return callOutAnnotationView;
        
    } else if ([annotation isKindOfClass:[YNLocationAnnotation class]]) {
        
        static NSString *identify = @"LOCATIONANNOTATIONVIEW";
        
        MKPinAnnotationView *pinAnnotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identify];
        if (pinAnnotationView == nil) {
            pinAnnotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identify];
        }
        pinAnnotationView.canShowCallout = YES;
//        pinAnnotationView.image = [UIImage imageNamed:@"tarBar_nearby_off"];
//        pinAnnotationView.calloutOffset = CGPointMake(-1, -2);
        
        pinAnnotationView.pinColor = MKPinAnnotationColorGreen;
        return pinAnnotationView;
    }
    
    return nil;
    
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    if ([view.annotation isKindOfClass:[YNBaseAnnotation class]]) {
        
        self.isDeleteAnnotation = NO;
        
        YNBaseAnnotation *baseAnnotation = (YNBaseAnnotation *)view.annotation;
        self.dataIndex = baseAnnotation.index;
        
        YNCallOutAnnotation *callOutAnnotation = [[YNCallOutAnnotation alloc] init];
        [callOutAnnotation setCoordinate:view.annotation.coordinate];
        [mapView addAnnotation:callOutAnnotation];
        self.callOutAnnotation = callOutAnnotation;
    }
    
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    
    if (self.callOutAnnotation ) {
        
        self.isDeleteAnnotation = YES;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.callOutAnnotationView.alpha = 0.0;
            
        } completion:^(BOOL finished) {
            
            if (self.isDeleteAnnotation) {
                
                [self.mapview removeAnnotation: self.callOutAnnotation];
                
                self.callOutAnnotation = nil;
            }
            
        }];
        
//        [self.mapview removeAnnotation: self.callOutAnnotation];
//        self.callOutAnnotation = nil;

    }
}

//- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
//    
//    NSLog(@"%f,%f",mapView.region.span.latitudeDelta,mapView.region.span.longitudeDelta);
//}


- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    self.currentLocation = userLocation.location;
    
    CLGeocoder *geocder = [[CLGeocoder alloc] init];
    [geocder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        CLPlacemark *placemark = placemarks.firstObject;
        
        
                    if (placemark.thoroughfare) {
        
                        NSMutableString *title = [NSMutableString stringWithString:placemark.thoroughfare];
        
                        if (placemark.subThoroughfare) {
        
                            [title appendString:placemark.subThoroughfare];
                        }
        
                         userLocation.title = title;
                        
                       
                    }
        
//        [self.locationAnnotation setCoordinate:userLocation.coordinate];
        
                if (!self.isLocated) {
        
                    [self showMyLocation:userLocation.location.coordinate];
                    [self addEnterpriseAnnotation];
                    self.isLocated = YES;
//                    MKCoordinateSpan span = MKCoordinateSpanMake(LatitudeDelta, LongitudeDelta);
//                    MKCoordinateRegion regin = MKCoordinateRegionMake(userLocation.location.coordinate, span);
//                    [self.mapview setRegion:regin animated:YES];
//        
                    
                    
                }
        
        
//        for (CLPlacemark *placemark in placemarks) {
//            
//             NSLog(@"name - %@", placemark.name);
//            NSLog(@"thoroughfare - %@", placemark.thoroughfare);
//            NSLog(@"subThoroughfare - %@", placemark.subThoroughfare);
//            NSLog(@"locality - %@", placemark.locality);//城市
//            NSLog(@"subLocality - %@", placemark.subLocality);//区
//            NSLog(@"administrativeArea - %@", placemark.administrativeArea);//省份
//            NSLog(@"subAdministrativeArea - %@", placemark.subAdministrativeArea);
//            NSLog(@"postalCode - %@", placemark.postalCode);
//            NSLog(@"ISOcountryCode - %@", placemark.ISOcountryCode);//国家代表CN
//            NSLog(@"country - %@", placemark.country);//国家
//            NSLog(@"inlandWater - %@", placemark.inlandWater);
//            NSLog(@"ocean - %@", placemark.ocean);
//            NSLog(@"areasOfInterest - %@", placemark.areasOfInterest);
//            
//
//        }
       
    }];
    
//    NSLog(@"didUpdateUserLocation %@", userLocation.title);
}


- (void)addEnterpriseAnnotation {
    YNBaseAnnotation *baseAnnotation1 = [[YNBaseAnnotation alloc] init];
    baseAnnotation1.index = 0;
    baseAnnotation1.coordinate = CLLocationCoordinate2DMake(self.currentLocation.coordinate.latitude - 0.001, self.currentLocation.coordinate.longitude );
    
    YNBaseAnnotation *baseAnnotation2 = [[YNBaseAnnotation alloc] init];
    baseAnnotation2.index = 1;
    baseAnnotation2.coordinate = CLLocationCoordinate2DMake(self.currentLocation.coordinate.latitude + 0.001, self.currentLocation.coordinate.longitude );
    
    [self.mapview addAnnotations:@[baseAnnotation1, baseAnnotation2]];
    
}

#pragma mark - CLLocationManagerDelegate

//- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
//    
//    
//    
//    CLLocation *newLocation = locations.lastObject;
//    
//    BOOL isInChina = [YNWGS84TOGCJ02 isLocationOutOfChina:newLocation.coordinate];
//    
//    if (!isInChina) {
//        
//         CLLocationCoordinate2D coordinate = [YNWGS84TOGCJ02 transformFromWGSToGCJ:newLocation.coordinate];
//        
////        NSLog(@"%f%f", coordinate.latitude, coordinate.longitude);
//        CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
//        
//        if (!self.isLocated) {
//            
//            MKCoordinateSpan span = MKCoordinateSpanMake(0.49, 0.42);
//            MKCoordinateRegion regin = MKCoordinateRegionMake(coordinate, span);
//            [self.mapview setRegion:regin animated:YES];
//
//            self.isLocated = YES;
//        }
//        
//        [self.locationAnnotation setCoordinate:coordinate];
//        
//        [self.geocder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
//            
//            CLPlacemark *placemark = placemarks.firstObject;
//            
//            if (placemark.thoroughfare) {
//                
//                NSMutableString *title = [NSMutableString stringWithString:placemark.thoroughfare];
//                
//                if (placemark.subThoroughfare) {
//                    
//                    [title appendString:placemark.subThoroughfare];
//                }
//                
//                 self.locationAnnotation.title = title;
//            }
//            
//            [self.mapview selectAnnotation:_locationAnnotation animated:YES];
//            
//            
////            for (CLPlacemark *placemark in placemarks) {
////                
////                NSLog(@"name - %@", placemark.name);
////                NSLog(@"thoroughfare - %@", placemark.thoroughfare);
////                NSLog(@"subThoroughfare - %@", placemark.subThoroughfare);
////                NSLog(@"locality - %@", placemark.locality);//城市
////                NSLog(@"subLocality - %@", placemark.subLocality);//区
////                NSLog(@"administrativeArea - %@", placemark.administrativeArea);//省份
////                 NSLog(@"country - %@", placemark.country);//国家
////                NSLog(@"subAdministrativeArea - %@", placemark.subAdministrativeArea);
////                NSLog(@"postalCode - %@", placemark.postalCode);
////                NSLog(@"ISOcountryCode - %@", placemark.ISOcountryCode);//国家代表CN
////               
////                NSLog(@"inlandWater - %@", placemark.inlandWater);
////                NSLog(@"ocean - %@", placemark.ocean);
////                NSLog(@"areasOfInterest - %@", placemark.areasOfInterest);
////                
////                
////            }
//            
//        }];
//
//    }
//    
//}
#pragma mark - YNCallOutContentViewDelegate
- (void)callOutContentViewTaped {
    
    NSLog(@" I am taped");
    
    YNEnterpriseViewController *vc = [[YNEnterpriseViewController alloc] init];
    vc.title = @"商家详情";
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark - event response
- (void)showMyLocation:(CLLocationCoordinate2D)coordinate {
    
    MKCoordinateSpan span = MKCoordinateSpanMake(LatitudeDelta, LongitudeDelta);
    MKCoordinateRegion regin = MKCoordinateRegionMake(coordinate, span);
    [self.mapview setRegion:regin animated:YES];
    
}
- (void)locationButtonHasClicked {
    
    [self showMyLocation:self.currentLocation.coordinate];
}
#pragma mark - private Methods
- (void)startLocate {
    
    BOOL locationServicesEnabled = [CLLocationManager locationServicesEnabled];
    
    if (locationServicesEnabled) {
        
        CLAuthorizationStatus state = [CLLocationManager authorizationStatus];
        
        if (state == kCLAuthorizationStatusNotDetermined) {
            
            if ([self.locationManger respondsToSelector:@selector(requestWhenInUseAuthorization )]) {
                [self.locationManger requestWhenInUseAuthorization];
                
            }
            
        } else if (state == kCLAuthorizationStatusAuthorizedWhenInUse || state ==kCLAuthorizationStatusAuthorizedAlways){
            
            self.locationManger.delegate = self;
            self.locationManger.desiredAccuracy = kCLLocationAccuracyBest;
            self.locationManger.distanceFilter = 10;
        }
        
        [self.locationManger startUpdatingLocation];
        
    } else {
        
        NSLog(@"定位未开启");
    }
    
}



#pragma mark - getters

- (MKMapView *)mapview {
    if (_mapview == nil) {
        _mapview = [[MKMapView alloc] initWithFrame:self.view.bounds];
        
        _mapview.mapType = MKMapTypeStandard;
        _mapview.showsUserLocation = YES;
        _mapview.userTrackingMode = MKUserTrackingModeFollow;
        _mapview.delegate = self;
        
    }
    return _mapview;
}
- (UIButton *)locationButton {
    if (_locationButton == nil) {
        _locationButton = [[UIButton alloc] init];
        _locationButton.frame = CGRectMake(10, self.view.frame.size.height - 90, 36, 36);
        [_locationButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_locationButton setTitle:@"定位" forState:UIControlStateNormal];
        [_locationButton addTarget:self action:@selector(locationButtonHasClicked) forControlEvents:UIControlEventTouchUpInside];
        _locationButton.backgroundColor = [UIColor whiteColor];
    }
    return _locationButton;
}

- (CLLocationManager *)locationManger {
    if (_locationManger == nil) {
        _locationManger = [[CLLocationManager alloc] init];
        _locationManger.pausesLocationUpdatesAutomatically = YES;
    }
    return _locationManger;
}

- (YNLocationAnnotation *)locationAnnotation {
    if (_locationAnnotation == nil) {
        _locationAnnotation = [[YNLocationAnnotation alloc] init];
        
        [self.mapview addAnnotation:_locationAnnotation];
    }
    return _locationAnnotation;
}
- (CLGeocoder *)geocder {
    if (_geocder == nil) {
        _geocder = [[CLGeocoder alloc] init];
    }
    return _geocder;
}
#pragma mark - setters
- (void)setCurrentLocation:(CLLocation *)currentLocation {
    
    if (_currentLocation != currentLocation) {
        _currentLocation = currentLocation;
    }
}

@end
