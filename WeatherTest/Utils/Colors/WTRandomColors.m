//
//  WTRandomColors.m
//  WeatherTest
//
//  Created by Leyner Castillo on 27/02/20.
//  Copyright © 2020 Leyner Castillo. All rights reserved.
//

#import "WTRandomColors.h"

@implementation WTRandomColors

+(UIColor*)randomColor {
    int random = arc4random_uniform(5);
    return [[self colors] objectAtIndex:random];
}

+(NSArray*)colors {
    UIColor *firstColor = [UIColor colorWithRed:1.0/255.0 green:87.0/255.0 blue:155.0/255.0 alpha:1];
    UIColor *secondColor = [UIColor colorWithRed:255.0/255.0 green:143.0/255.0 blue:0.0/255.0 alpha:1];
    UIColor *thirdColor = [UIColor colorWithRed:244.0/255.0 green:67.0/255.0 blue:54.0/255.0 alpha:1];
    UIColor *fourthColor = [UIColor colorWithRed:141.0/255.0 green:110.0/255.0 blue:99.0/255.0 alpha:1];
    UIColor *fifthColor = [UIColor colorWithRed:0.0/255.0 green:188.0/255.0 blue:212.0/255.0 alpha:1];
    UIColor *sixthColor = [UIColor colorWithRed:156.0/255.0 green:204.0/255.0 blue:101.0/255.0 alpha:1];

    return @[firstColor, secondColor, thirdColor, fourthColor, fifthColor, sixthColor];
}

@end
