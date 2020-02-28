//
//  WTWeathersDataModel.h
//  WeatherTest
//
//  Created by Leyner Castillo on 27/02/20.
//  Copyright © 2020 Leyner Castillo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WTWeatherDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WTWeathersDataModel : NSObject

@property (nonatomic) int count;
@property (nonatomic) NSArray<WTWeatherDataModel*> *weathers;

+ (id)initWithDictionary:(NSDictionary*)dictionary;
@end

NS_ASSUME_NONNULL_END
