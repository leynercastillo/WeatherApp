//
//  WTWeathersDataModel.m
//  WeatherTest
//
//  Created by Leyner Castillo on 27/02/20.
//  Copyright © 2020 Leyner Castillo. All rights reserved.
//

#import "WTWeathersDataModel.h"

@implementation WTWeathersDataModel

static NSString *kCount = @"count";
static NSString *kList = @"list";

+ (id)initWithDictionary:(NSDictionary*)dictionary {
    WTWeathersDataModel *weathers = [[WTWeathersDataModel alloc] init];

    if (dictionary[kCount] != [NSNull null]) {
        weathers.count = [dictionary[kCount] intValue];
    }

    if (dictionary[kList] != [NSNull null]) {
        NSArray *list = dictionary[kList];

        NSMutableArray<WTWeatherDataModel*>* arrayWeather = [NSMutableArray array];

        for (NSDictionary *weatherDictionary in list) {
            WTWeatherDataModel *weatherDataModel = [WTWeatherDataModel initWithDictionary:weatherDictionary];
            [arrayWeather addObject:weatherDataModel];
        }

        weathers.weathers = arrayWeather;
    }

    return weathers;
}

@end
