//
//  ViewController.m
//  Hungry Students
//
//  Created by Rutger Farry on 11/15/14.
//  Copyright (c) 2014 Rutger Farry. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>
#import <GoogleMaps/GoogleMaps.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.mapView setCamera:[GMSCameraPosition cameraWithLatitude:44.56802
                                                            longitude:-123.27926
                                                             zoom:16]];
    
    GMSMarker *marker = [GMSMarker markerWithPosition:CLLocationCoordinate2DMake(44.56802, -123.27926)];
    marker.title = @"Hello World";
    marker.map = self.mapView;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
