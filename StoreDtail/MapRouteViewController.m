//
//  MapRouteViewController.m
//  StoreDtail
//
//  Created by 薛焱 on 16/1/15.
//  Copyright © 2016年 薛焱. All rights reserved.
//

#import "MapRouteViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>

@interface MapRouteViewController ()<BMKMapViewDelegate, BMKLocationServiceDelegate>
@property (strong, nonatomic) IBOutlet BMKMapView *mapView;
@property (nonatomic, strong) BMKLocationService *locService;




@end

@implementation MapRouteViewController
-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _locService.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
    _locService.delegate = nil;
}
- (void)dealloc
{
    if (_mapView) {
        _mapView = nil;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _locService = [[BMKLocationService alloc]init];
    _mapView.delegate = self;
    [_mapView setZoomLevel:13];
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    [self startLocation];
    // Do any additional setup after loading the view.
}

- (void)startLocation{
    [_locService startUserLocationService];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
}

- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
