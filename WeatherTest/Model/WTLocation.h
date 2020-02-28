//
//  WTLocation.h
//  WeatherTest
//
//  Created by Leyner Castillo on 27/02/20.
//  Copyright © 2020 Leyner Castillo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WTLocation : NSObject

@property(weak, nonatomic) NSString *country;
@property(weak, nonatomic) NSString *city;
@property(weak, nonatomic) NSString *street;
@property(weak, nonatomic) NSString *postCode;
@property(nonatomic) double latitude;
@property(nonatomic) double longitude;

@end

NS_ASSUME_NONNULL_END
