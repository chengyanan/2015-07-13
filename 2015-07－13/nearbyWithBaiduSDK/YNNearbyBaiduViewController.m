//
//  YNNearbyBaiduViewController.m
//  2015-07－13
//
//  Created by os on 15/8/5.
//  Copyright (c) 2015年 YN. All rights reserved.
//

#import "YNNearbyBaiduViewController.h"
#import <BMapKit.h>

@interface YNNearbyBaiduViewController()<BMKMapViewDelegate, BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate>

@property (nonatomic, strong) BMKMapView *mapView;
@property (nonatomic, strong) BMKLocationService *locationService;
@property (nonatomic, strong) BMKGeoCodeSearch *geoCodeSearch;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@end

@implementation YNNearbyBaiduViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view = self.mapView;
    [self.locationService startUserLocationService];
    
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    [_mapView viewWillAppear];
//    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
//}
//-(void)viewWillDisappear:(BOOL)animated
//{
//    [_mapView viewWillDisappear];
//    _mapView.delegate = nil; // 不用时，置nil
//}

#pragma mark - BMKLocationServiceDelegate
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    
    [self.mapView updateLocationData:userLocation];
    
//    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    self.coordinate = userLocation.location.coordinate;
    
    self.mapView.centerCoordinate = userLocation.location.coordinate;
    
    CLLocationCoordinate2D pt = CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc] init];
    reverseGeocodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [self.geoCodeSearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag)
    {
        //        NSLog(@"反geo检索发送成功");
    }
    else
    {
        //        NSLog(@"反geo检索发送失败");
    }
    
}

#pragma mark - BMKGeoCodeSearchDelegate
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    
    if (error == BMK_SEARCH_NO_ERROR) {
        
        NSLog(@"address-%@\nstreetName-%@\nstreetNumber-%@\ndistrict-%@\ncity-%@\nprovince-%@",result.address, result.addressDetail.streetName, result.addressDetail.streetNumber,result.addressDetail.district, result.addressDetail.city,result.addressDetail.province);

    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}


#pragma mark - BMKMapViewDelegate
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
//    NSLog(@"%f,%f",mapView.region.span.latitudeDelta,mapView.region.span.longitudeDelta);
}
#pragma mark - getters
- (BMKMapView *)mapView {
    if (_mapView == nil) {
        _mapView = [[BMKMapView alloc] initWithFrame:self.view.bounds];
        _mapView.showsUserLocation = YES;
        _mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
        _mapView.mapType = BMKMapTypeStandard;
        
    }
    return _mapView;
}

- (BMKLocationService *)locationService {
    if (_locationService == nil) {
        
        //设置定位精确度，默认：kCLLocationAccuracyBest
        [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
        //指定最小距离更新(米)，默认：kCLDistanceFilterNone
        [BMKLocationService setLocationDistanceFilter:10.f];
        
        _locationService = [[BMKLocationService alloc] init];
        _locationService.delegate = self;
        
    }
    return _locationService;
}
- (BMKGeoCodeSearch *)geoCodeSearch {
    if (_geoCodeSearch == nil) {
        _geoCodeSearch = [[BMKGeoCodeSearch alloc] init];
        _geoCodeSearch.delegate = self;
    }
    return _geoCodeSearch;
}

@end
