//
//  APIClient.m
//  WeatherTest
//
//  Created by Leyner Castillo on 26/02/20.
//  Copyright © 2020 Leyner Castillo. All rights reserved.
//

#import "APIClient.h"
#import <AFNetworking/AFNetworking.h>

#import "WTWeathersDataModel.h"

@implementation APIClient

static APIClient *sharedManager = nil;

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
    }

    return self;
}

- (void)fetchWeatherNearToLatitude:(double)latitude
                       longitude:(double)longitude
                         success:(void (^)(NSArray<WTWeatherDataModel*>* weathers))success
                         failure:(void (^)(NSError *error))failure {

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.openweathermap.org/data/2.5/"] sessionConfiguration:configuration];

    NSDictionary *parameters = @{@"lat": @(latitude), @"lon": @(longitude), @"appid": @"4bea7d9837a972d8b3b11be6967364c0", @"units": @"Metric", @"cnt": @(40)};

    [manager GET:@"find" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        WTWeathersDataModel *weathersDataModel = [WTWeathersDataModel initWithDictionary:responseObject];
        success(weathersDataModel.weathers);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

@end
