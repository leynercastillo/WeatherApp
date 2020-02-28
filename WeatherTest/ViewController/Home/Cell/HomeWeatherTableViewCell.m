//
//  HomeWeatherTableViewCell.m
//  WeatherTest
//
//  Created by Leyner Castillo on 27/02/20.
//  Copyright © 2020 Leyner Castillo. All rights reserved.
//

#import "HomeWeatherTableViewCell.h"

#import <SDWebImage/SDWebImage.h>

@interface HomeWeatherTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *borderView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;

@end

@implementation HomeWeatherTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [_iconImageView sd_cancelCurrentImageLoad];
    [_iconImageView setImage:[UIImage imageNamed:@"icon-weather"]];
}

// MARK: - Statics
+ (NSString*)identifier {
    return NSStringFromClass([HomeWeatherTableViewCell class]);
}

// MARK: - Object
- (void)updateWithImageName:(NSString*)imageName
                       name:(NSString*)name
                description:(NSString*)description
                temperature:(NSString*)temperature {
    _nameLabel.text = name;
    _descriptionLabel.text = description;
    _temperatureLabel.text = temperature;

    NSString *imageURL = [NSString stringWithFormat:@"https://openweathermap.org/img/wn/%@@%.0fx.png", imageName, [[UIScreen mainScreen] scale]];
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"icon-weather"]];
}

// MARK: - Helper
- (void)setupUI {
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    _borderView.layer.borderWidth = 0.5;
    _borderView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _borderView.layer.cornerRadius = 4;
}



@end
