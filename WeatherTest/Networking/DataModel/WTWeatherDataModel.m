//
//  WTWeatherDataModel.m
//  WeatherTest
//
//  Created by Leyner Castillo on 27/02/20.
//  Copyright © 2020 Leyner Castillo. All rights reserved.
//

#import "WTWeatherDataModel.h"

@interface WTWeatherDataModel()

@end

@implementation WTWeatherDataModel

static NSString *kBase = @"base";
static NSString *kName = @"name";
static NSString *kVisibility = @"visibility";
static NSString *kTimezone = @"timezone";

static NSString *kWeather = @"weather";
static NSString *kIcon = @"icon";
static NSString *kDescription = @"description";

static NSString *kWind = @"wind";
static NSString *kSpeed = @"speed";

static NSString *kMain = @"main";
static NSString *kFeelsLike = @"feels_like";
static NSString *kHumidity = @"humidity";
static NSString *kPressure = @"pressure";
static NSString *kTemp = @"temp";
static NSString *kMaximumTemp = @"temp_max";
static NSString *kMinimumTemp = @"temp_min";

+ (id)initWithDictionary:(NSDictionary*)dictionary {
    WTWeatherDataModel *weather = [[WTWeatherDataModel alloc] init];

    if (self) {
        if (dictionary[kBase] != [NSNull null]) {
            weather.base = dictionary[kBase];
        }

        if (dictionary[kName] != [NSNull null]) {
            weather.name = dictionary[kName];
        }

        if (dictionary[kVisibility] != [NSNull null]) {
            weather.visibility = [dictionary[kVisibility] doubleValue];
        }

        if (dictionary[kTimezone] != [NSNull null]) {
            weather.timezone = [dictionary[kTimezone] doubleValue];
        }

        if (dictionary[kWeather] != [NSNull null]) {

            NSDictionary *weatherDictionary = [dictionary[kWeather] firstObject];

            if (weatherDictionary[kIcon] != [NSNull null]) {
                weather.icon = weatherDictionary[kIcon];
            }

            if (weatherDictionary[kDescription] != [NSNull null]) {
                weather.weatherDescription = weatherDictionary[kDescription];
            }
        }

        if (dictionary[kWind] != [NSNull null]) {

            NSDictionary *windDictionary = dictionary[kWind];

            if (windDictionary[kSpeed] != [NSNull null]) {
                weather.windSpeed = [windDictionary[kSpeed] doubleValue];
            }
        }

        if (dictionary[kMain] != [NSNull null]) {

            NSDictionary *main = dictionary[kMain];

            if (main[kFeelsLike] != [NSNull null]) {
                weather.feelsLike = [main[kFeelsLike] doubleValue];
            }

            if (main[kHumidity] != [NSNull null]) {
                weather.humidity = [main[kHumidity] doubleValue];
            }

            if (main[kPressure] != [NSNull null]) {
                weather.pressure = [main[kPressure] doubleValue];
            }

            if (main[kTemp] != [NSNull null]) {
                weather.currentTemp = [main[kTemp] doubleValue];
            }

            if (main[kMaximumTemp] != [NSNull null]) {
                weather.maximumTemp = [main[kMaximumTemp] doubleValue];
            }

            if (main[kMinimumTemp] != [NSNull null]) {
                weather.minimumTemp = [main[kMinimumTemp] doubleValue];
            }
        }
    }

    return weather;
}

@end
