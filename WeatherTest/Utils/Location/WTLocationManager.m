//
//  WTLocationManager.m
//  WeatherTest
//
//  Created by Leyner Castillo on 27/02/20.
//  Copyright © 2020 Leyner Castillo. All rights reserved.
//

#import "WTLocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface WTLocationManager() <CLLocationManagerDelegate>

@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) CLGeocoder *geoCoder;

@end

@implementation WTLocationManager

static WTLocationManager *sharedManager = nil;

+(id)shared {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedManager = [[self alloc] init];
    });

    return sharedManager;
}

- (id)init {
    self = [super init];

    if (self) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;

        _geoCoder = [[CLGeocoder alloc] init];
    }

    return self;
}

// MARK: - Object
- (void)requestPermission {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];

    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            [_locationManager requestWhenInUseAuthorization];
            break;

        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusRestricted:
            [_delegate locationPermissionRestrictedOrDenied];
            break;

        case kCLAuthorizationStatusAuthorizedWhenInUse:
            [_delegate locationPermissionAuthorized];
            break;

        default:
            break;
    }
}

- (void)startUpdatingLocation {
    [_locationManager startUpdatingLocation];
}

// MARK: - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    [self requestPermission];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {

    [_geoCoder reverseGeocodeLocation:[locations lastObject] completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {

        CLPlacemark *placemark = [placemarks lastObject];

        if (placemark) {
            WTLocation *currentLocation = [[WTLocation alloc] init];

            currentLocation.country = placemark.country;
            currentLocation.city = placemark.locality;
            currentLocation.street = placemark.thoroughfare;
            currentLocation.postCode = placemark.postalCode;
            currentLocation.latitude = placemark.location.coordinate.latitude;
            currentLocation.longitude = placemark.location.coordinate.longitude;

            [self.delegate locationManager:self locationUpdated:currentLocation];
        }

        [self.locationManager stopUpdatingLocation];
    }];
}

@end
