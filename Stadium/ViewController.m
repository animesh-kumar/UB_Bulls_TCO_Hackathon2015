//
//  ViewController.m
//  Stadium
//
//  Created by Mani Kishore Chitrala on 6/18/15.
//  Copyright (c) 2015 Mani Kishore Chitrala. All rights reserved.
//


#import "ViewController.h"
#import <Parse/Parse.h>
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>
#import <GoogleMaps/GoogleMaps.h>
#import <AFHTTPRequestOperationManager.h>
#import <Spotify/Spotify.h>

#import "Result.h"
#import "GlobalData.h"

@interface ViewController ()<GMSMapViewDelegate,CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
}
@property (strong, nonatomic) GMSMapView *mapView;
@end
NSString *const urlString = @"http://stadium.mybluemix.net/SQLDBSample";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[[SPTAuth defaultInstance]session] isValid]) {
        [self setupMapView];
    }else {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setupMapView) name:@"showMap" object:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupMapView
{
    locationManager = [[CLLocationManager alloc]init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    locationManager.activityType    = CLActivityTypeOther;
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];

    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:locationManager.location.coordinate.latitude
                                                            longitude:locationManager.location.coordinate.longitude
                                                                 zoom:14];
    _mapView = [GMSMapView mapWithFrame:self.view.frame camera:camera];
    _mapView.delegate = self;
    _mapView.myLocationEnabled = YES;
    _mapView.settings.myLocationButton = YES;
    
    [self.view addSubview:_mapView];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations lastObject];

    [_mapView animateToLocation:location.coordinate];
    [_mapView animateToZoom:14.0];

    NSDictionary *parameters = @{@"lat":[NSNumber numberWithDouble:location.coordinate.latitude],@"lon":[NSNumber numberWithDouble:location.coordinate.longitude],@"username":[GlobalData sharedGlobalData].session.canonicalUsername,@"accessToken":[GlobalData sharedGlobalData].session.accessToken};
    
    [[AFHTTPRequestOperationManager manager]GET:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        NSError *error = nil;
        NSArray *array = (NSMutableArray *)[MTLJSONAdapter modelsOfClass:[Result class] fromJSONArray:responseObject error:&error];
        for (Result *result in array) {
            GMSMarker *marker = [GMSMarker markerWithPosition:CLLocationCoordinate2DMake([result.lat doubleValue], [result.lon doubleValue])];
            marker.map = _mapView;
            marker.userData = result;
            marker.snippet = [NSString stringWithFormat:@"%@ %@",result.username,result.spotifyScore];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.localizedDescription);
    }];
    [locationManager stopUpdatingLocation];
}

- (BOOL) didTapMyLocationButtonForMapView:(GMSMapView *)mapView {
    [_mapView animateToLocation:locationManager.location.coordinate];
    [_mapView animateToZoom:14.0];
    return YES;
}

- (IBAction)loginWithSpotify:(id)sender {
    NSURL *loginURL = [[SPTAuth defaultInstance] loginURL];
    [[UIApplication sharedApplication] performSelector:@selector(openURL:)
                      withObject:loginURL afterDelay:0.1];

}

@end
