//
//  WTWeatherDataModel.h
//  WeatherTest
//
//  Created by Leyner Castillo on 27/02/20.
//  Copyright © 2020 Leyner Castillo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WTWeatherDataModel : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *icon;
@property (nonatomic) NSString *weatherDescription;
@property (nonatomic) NSString *base;
@property (nonatomic) double visibility;
@property (nonatomic) double timezone;
@property (nonatomic) double pressure;
@property (nonatomic) double feelsLike;
@property (nonatomic) double humidity;
@property (nonatomic) double windSpeed;
@property (nonatomic) double currentTemp;
@property (nonatomic) double maximumTemp;
@property (nonatomic) double minimumTemp;

+ (id)initWithDictionary:(NSDictionary*)dictionary;

@end

NS_ASSUME_NONNULL_END
