//
//  WTDetailViewController.h
//  WeatherTest
//
//  Created by Leyner Castillo on 27/02/20.
//  Copyright © 2020 Leyner Castillo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WTWeatherDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WTDetailViewController : UIViewController

@property (nonatomic) WTWeatherDataModel *weatherData;

@end

NS_ASSUME_NONNULL_END
