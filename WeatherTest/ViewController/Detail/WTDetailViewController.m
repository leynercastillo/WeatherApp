//
//  WTDetailViewController.m
//  WeatherTest
//
//  Created by Leyner Castillo on 27/02/20.
//  Copyright © 2020 Leyner Castillo. All rights reserved.
//

#import "WTDetailViewController.h"

#import "WTRandomColors.h"
#import <SDWebImage/SDWebImage.h>

@interface WTDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureRangeTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureRangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *windTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *windLabel;
@property (weak, nonatomic) IBOutlet UILabel *feelsLikeTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *feelsLikeLabel;

@end

@implementation WTDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self fillInformation];
}

- (void)setupUI {
    self.view.backgroundColor = [WTRandomColors randomColor];
    [self setupNavigationBar];
    [self setupLocalizedText];
}

- (void)setupNavigationBar {

    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.translucent = true;

    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemClose target:self action:@selector(closeButtonTouched:)];

    self.navigationItem.rightBarButtonItem = closeButton;
}

- (void)setupLocalizedText {
    _windTitleLabel.text = NSLocalizedString(@"wind", @"");
    _feelsLikeTitleLabel.text = NSLocalizedString(@"feels_like", @"");
    _temperatureRangeTitleLabel.text = NSLocalizedString(@"temperature", @"");
}

- (void)fillInformation {
    NSString *imageURL = [NSString stringWithFormat:@"https://openweathermap.org/img/wn/%@@%.0fx.png", _weatherData.icon, [[UIScreen mainScreen] scale]];
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"icon-weather"]];

    _temperatureLabel.text = [NSString stringWithFormat:@"%.0fº C", _weatherData.currentTemp];
    _descriptionLabel.text = [_weatherData.weatherDescription uppercaseString];
    _windLabel.text = [NSString stringWithFormat:@"%.1f m/s", _weatherData.windSpeed];
    _feelsLikeLabel.text = [NSString stringWithFormat:@"%.0fº C", _weatherData.feelsLike];
    _temperatureRangeLabel.text = [NSString stringWithFormat:@"%.0fº C / %.fº C", _weatherData.minimumTemp, _weatherData.maximumTemp];
}

// MARK: - Actions
- (void)closeButtonTouched:(UIBarButtonItem*)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
