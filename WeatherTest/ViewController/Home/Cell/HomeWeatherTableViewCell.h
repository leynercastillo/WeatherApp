//
//  HomeWeatherTableViewCell.h
//  WeatherTest
//
//  Created by Leyner Castillo on 27/02/20.
//  Copyright © 2020 Leyner Castillo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeWeatherTableViewCell : UITableViewCell

+ (NSString*)identifier;

- (void)updateWithImageName:(NSString*)imageName
                       name:(NSString*)name
                description:(NSString*)description
                temperature:(NSString*)temperature;

@end

NS_ASSUME_NONNULL_END
