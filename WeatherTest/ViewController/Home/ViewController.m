//
//  ViewController.m
//  WeatherTest
//
//  Created by Leyner Castillo on 26/02/20.
//  Copyright © 2020 Leyner Castillo. All rights reserved.
//

#import "ViewController.h"
#import "APIClient.h"
#import "WTLocationManager.h"

#import "HomeWeatherTableViewCell.h"
#import "WTDetailViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, WTLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic) WTLocationManager *locationManager;
@property (nonatomic) NSArray<WTWeatherDataModel*>* weathers;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    
    _locationManager = [WTLocationManager shared];
    _locationManager.delegate = self;
    [_locationManager requestPermission];
}

// MARK: - Setup
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDarkContent;
}

- (void)setupUI {
    [self setupTableView];
    [self setupNavigationBar];
    [self setupLocalizedText];
    [self setupRefreshControl];
}

- (void)setupTableView {
    [_tableView registerNib:[UINib nibWithNibName:[HomeWeatherTableViewCell identifier] bundle:nil] forCellReuseIdentifier:[HomeWeatherTableViewCell identifier]];

    _tableView.estimatedRowHeight = 80;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.dataSource = self;
    _tableView.delegate = self;
}

- (void)setupNavigationBar {
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor blackColor]};
}

- (void)setupLocalizedText {
    self.navigationItem.title = NSLocalizedString(@"home_title", @"");
}

- (void)setupRefreshControl {
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self action:@selector(locationPermissionAuthorized) forControlEvents:UIControlEventValueChanged];

    self.tableView.refreshControl = _refreshControl;
}

- (void)endRefreshControl {
    [_refreshControl endRefreshing];
    [self.tableView reloadData];
}

// MARK: - Helpers
- (void)requestWeatherInformationWithLocation:(WTLocation*)currentLocation {

    if (![_refreshControl isRefreshing]) {
        [_activityIndicator startAnimating];
    }

    [[APIClient shared] fetchWeatherNearToLatitude:currentLocation.latitude longitude:currentLocation.longitude success:^(NSArray<WTWeatherDataModel *> * _Nonnull weathers) {

        self.weathers = weathers;
        [self endRefreshControl];

        if (![self.refreshControl isRefreshing]) {
            [self.activityIndicator stopAnimating];
        }

    } failure:^(NSError * _Nonnull error) {

    }];
}

// MARK: - WTLocationManagerDelegate
- (void)locationPermissionAuthorized {
    [_locationManager startUpdatingLocation];
}

- (void)locationPermissionRestrictedOrDenied {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"request_location_permissions_title", @"") message:NSLocalizedString(@"open_settings_message", @"") preferredStyle:UIAlertControllerStyleAlert];

    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"ok", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];

    }]];

    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"cancel", @"") style:UIAlertActionStyleDefault handler:nil]];

    [self presentViewController:alertController animated:true completion:nil];
}

- (void)locationManager:(WTLocationManager *)manager locationUpdated:(WTLocation *)currentLocation {
    [self requestWeatherInformationWithLocation:currentLocation];
}

// MARK: - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _weathers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeWeatherTableViewCell *cell = (HomeWeatherTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[HomeWeatherTableViewCell identifier]];

    if (cell) {
        WTWeatherDataModel *weatherData = _weathers[indexPath.row];

        NSString *temperatureString = [NSString stringWithFormat:@"%.0fº C", weatherData.currentTemp];

        [cell updateWithImageName:weatherData.icon name:weatherData.name description:weatherData.weatherDescription temperature:temperatureString];
        return cell;
    }

    return [[UITableViewCell alloc] init];
}

// MARK: - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WTWeatherDataModel *weatherData = _weathers[indexPath.row];

    WTDetailViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([WTDetailViewController class])];
    detailViewController.weatherData = weatherData;

    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:detailViewController];

    [self presentViewController:navigationController animated:true completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

@end
