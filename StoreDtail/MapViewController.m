//
//  MapViewController.m
//  StoreDtail
//
//  Created by 薛焱 on 16/1/14.
//  Copyright © 2016年 薛焱. All rights reserved.
//

#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import "MapViewController.h"
#import "MyAnimatedAnnotationView.h"

@interface MapViewController () <BMKMapViewDelegate,BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate>
@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *storeTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *wayButton;

@property (nonatomic, strong) BMKLocationService *locService;
@property (nonatomic, strong) BMKPointAnnotation* pointAnnotation;
@property (nonatomic, strong) BMKPointAnnotation* customeAnnotation;
@property (nonatomic, strong) BMKGeoCodeSearch* geocodesearch;
@property (nonatomic, strong) NSArray *cityArray;
@property (nonatomic, strong) NSArray *addressArray;
@property (nonatomic, strong) NSMutableArray *locationArray;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationArray = [NSMutableArray array];
    self.cityArray = @[@"武汉", @"武汉", @"武汉"];
    self.addressArray = @[@"古田", @"宗关", @"虎泉"];
    self.wayButton.layer.borderColor = UIColorFromRGB(0xffc800).CGColor;
    self.wayButton.layer.borderWidth = 1;
    self.wayButton.layer.cornerRadius = 3;
    
    _locService = [[BMKLocationService alloc]init];
    [_mapView setZoomLevel:13];
    _mapView.delegate = self;
    
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)){
        self.navigationController.navigationBar.translucent = NO;
    }
    
    [self startLocation];
    [self forGetGeocode];
    
}
-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    
    _locService.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
    _geocodesearch.delegate = nil;
}
- (void)dealloc
{
    if (_geocodesearch != nil) {
        _geocodesearch = nil;
    }
    if (_mapView) {
        _mapView = nil;
    }
}

- (void)startLocation{
    [_locService startUserLocationService];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;
    _mapView.showsUserLocation = YES;
}

- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
//    NSLog(@"heading is %@",userLocation.heading);
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
}

- (void)forGetGeocode{
    for (int i = 0; i < 3; i++) {
        [self getGeocodeWithCity:self.cityArray[i] address:self.addressArray[i]];
    }
    
}
- (void)getGeocodeWithCity:(NSString *)city address:(NSString *)address{
    _geocodesearch = [[BMKGeoCodeSearch alloc]init];
    _geocodesearch.delegate = self;
    BMKGeoCodeSearchOption *geocodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
    geocodeSearchOption.city= city;
    geocodeSearchOption.address = address;
    NSLog(@"%@", address);
    BOOL flag = [_geocodesearch geoCode:geocodeSearchOption];
    if(flag)
    {
        NSLog(@"geo检索发送成功");
    }
    else
    {
        NSLog(@"geo检索发送失败");
    }
}

- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == 0) {
//        [self.locationArray addObject:result];
        [self addAnimatedAnnotationWithResult:result];
        NSLog(@"%f--%f",result.location.latitude,result.location.longitude);
        _mapView.centerCoordinate = result.location;
       
    }
}

- (void)addAnimatedAnnotationWithResult:(BMKGeoCodeResult *)result {
//    if (_customeAnnotation == nil) {
        _customeAnnotation = [[BMKPointAnnotation alloc]init];
        _customeAnnotation.coordinate = result.location;
        NSLog(@"--%f--%f",result.location.latitude,result.location.longitude);
        _customeAnnotation.title = result.address;
//    }
    [self.locationArray addObject:_customeAnnotation];
//    [_mapView addAnnotation:_customeAnnotation];
    if (self.locationArray.count == 3) {
       [_mapView addAnnotations:self.locationArray];
    }
    
}


// 根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    //自定义annotation
    NSString *AnnotationViewID = @"AnimatedAnnotation";
    MyAnimatedAnnotationView *annotationView = nil;
    if (annotationView == nil) {
        annotationView = [[MyAnimatedAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
    }
        annotationView.annotationImageView.image = [UIImage imageNamed:@"annotation"];
    return annotationView;
}

// 当点击annotation view弹出的泡泡时，调用此接口
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view;
{
    //添加视图
}
- (IBAction)wayButton:(UIButton *)sender {
    
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
