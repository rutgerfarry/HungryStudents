//
//  ViewController.m
//  Hungry Students
//
//  Created by Rutger Farry on 11/15/14.
//  Copyright (c) 2014 Rutger Farry. All rights reserved.
//

#import "ViewController.h"
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <GoogleMaps/GoogleMaps.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property NSMutableArray *mapMarkers;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapMarkers = [NSMutableArray array];
    
    self.mapView.delegate = self;
    [self.mapView setCamera:[GMSCameraPosition cameraWithLatitude:44.56802
                                                            longitude:-123.27926
                                                             zoom:16]];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Announcement"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *announcements, NSError *error) {
        if (error) {
            NSLog(@"%@", error.description);
            return;
        }
        
        for (PFObject *announcement in announcements) {
            [self addMarkerWithAnnouncement:announcement];
        }
    }];
}

- (void)addMarkerWithAnnouncement:(PFObject *)announcement {
    [announcement[@"Photo"] getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (error) {
            NSLog(@"%@", error.description);
            return;
        }
        PFGeoPoint *location = announcement[@"Location"];
        GMSMarker *result = [GMSMarker markerWithPosition:
                             CLLocationCoordinate2DMake(location.latitude, location.longitude)];
        
        UIImage *photo = [UIImage imageWithData:data];
        result.userData = @{ @"Photo" : photo, @"Description" : announcement[@"Description"] };
        result.map = self.mapView;
        
        [self.mapMarkers addObject:result];
    }];
}

- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker {
    UIViewController *destination = [UIViewController new];
    
    NSDictionary *data = marker.userData;
    UIImage *photo = data[@"Photo"];
    
    destination.view = [[UIImageView alloc] initWithImage:photo];
    [self.navigationController pushViewController:destination animated:true];
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

