//
//  ViewController.m
//  LocationTrial
//  
//  Created by Kan Boonprakub on 3/25/56 BE.
//  Copyright (c) 2556 Kan Boonprakub. All rights reserved.
//

#import "ViewController.h"
#import "myPointDetail.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize mapView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.mapView.delegate = self;
    
    [mapView setMapType:MKMapTypeStandard];
    [mapView setZoomEnabled:YES];
    [mapView setScrollEnabled:YES];
    mapView.mapType=MKMapTypeStandard;
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 2.0; //user needs to press for 2 seconds
    //lpgr.numberOfTapsRequired = 2;
    //lpgr.numberOfTouchesRequired = 2;
    [self.mapView addGestureRecognizer:lpgr];
    
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
         
    if ([annotation isKindOfClass:[myPointDetail class]]) {
        
        //Deque existing view
        MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        
        if (!pinView) {
            
            //create new view if one is not available.
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
            
            pinView.enabled = YES;
            pinView.pinColor = MKPinAnnotationColorRed;
            pinView.animatesDrop = YES;
            pinView.canShowCallout = YES;
            pinView.draggable = YES;
            
            // Add a detail disclosure button to the callout.
            UIButton* rightButton = [UIButton buttonWithType:
                                     UIButtonTypeDetailDisclosure];
            [rightButton addTarget:self action:@selector(viewPinDetail:)
                  forControlEvents:UIControlEventTouchUpInside];
            pinView.rightCalloutAccessoryView = rightButton;
        
        }
        else {
            
            pinView.annotation = annotation;
            
        }
        
        return pinView;
        
    }
    
    return nil;
    
}

- (IBAction)viewPinDetail:(id)sender {
    
    [self performSegueWithIdentifier: @"viewPinDetailSeque" sender: self];
    
}

- (void)handleLongPress:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan)
        return;
    
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D touchMapCoordinate =
    [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    
    //Initiate the Defined Annotation and specify the detail
    myPointDetail *dropPin = [[myPointDetail alloc] init];
    dropPin.title = @"Current Location";
    dropPin.subtitle = @"I Am Here";
    dropPin.coordinate = touchMapCoordinate;
    [self.mapView addAnnotation:dropPin];
    
    
}

- (void) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    MKCoordinateRegion currentLocationRegion = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 100, 100);

    
    [self.mapView setRegion:[self.mapView regionThatFits:currentLocationRegion] animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
