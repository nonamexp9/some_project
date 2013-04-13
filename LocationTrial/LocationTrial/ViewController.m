//
//  ViewController.m
//  LocationTrial
//
//  Created by Kan Boonprakub on 3/25/56 BE.
//  Copyright (c) 2556 Kan Boonprakub. All rights reserved.
//

#import "ViewController.h"
#import "myPointDetail.h"
#import "ViewPinDetailViewController.h"

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
    
    [self loadPin];
}

- (void)loadPin
{
    //get data from REST and then put it on the map
    
    //*******test - add pin to the map
    NSMutableArray *annotationList = [[NSMutableArray alloc] initWithCapacity:5];
    
    CLLocationCoordinate2D point;
    point.latitude = 37.7953;
    point.longitude = -122.406417;
    myPointDetail *dropPin = [[myPointDetail alloc] init];
    dropPin.title = @"Test 1";
    dropPin.subtitle = @"test 1";
    dropPin.coordinate = point;
    annotationList[0] = dropPin;
    
    point.latitude = 37.7952;
    point.longitude = -122.406317;
    dropPin = [[myPointDetail alloc] init];
    dropPin.title = @"Test 2";
    dropPin.subtitle = @"test 2";
    dropPin.coordinate = point;
    annotationList[1] = dropPin;
    
    point.latitude = 37.7951;
    point.longitude = -122.406217;
    dropPin = [[myPointDetail alloc] init];
    dropPin.title = @"Test 3";
    dropPin.subtitle = @"test 3";
    dropPin.coordinate = point;
    annotationList[2] = dropPin;
    
    point.latitude = 37.7954;
    point.longitude = -122.406517;
    dropPin = [[myPointDetail alloc] init];
    dropPin.title = @"Test 4";
    dropPin.subtitle = @"test 4";
    dropPin.coordinate = point;
    annotationList[3] = dropPin;
    
    point.latitude = 37.7955;
    point.longitude = -122.406617;
    dropPin = [[myPointDetail alloc] init];
    dropPin.title = @"Test 5";
    dropPin.subtitle = @"test 5";
    dropPin.coordinate = point;
    annotationList[4] = dropPin;
    
    [self.mapView addAnnotations:annotationList];
    
}

- (MKAnnotationView *) mapView:(MKMapView *)map viewForAnnotation:(id<MKAnnotation>)annotation{
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
         
    if ([annotation isKindOfClass:[myPointDetail class]]) {
        
        //Deque existing view
        MKPinAnnotationView *pinView = (MKPinAnnotationView *)[map dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        
        if (pinView == Nil) {
            
            myPointDetail *myPoint = (myPointDetail *)annotation;
            
            //create new view if one is not available.
            //the pin is recently added
            if(myPoint.isNew)
            {
                myPoint.isNew = NO;
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
                [rightButton addTarget:self action:@selector(addPinDetail:)
                      forControlEvents:UIControlEventTouchUpInside];
                pinView.rightCalloutAccessoryView = rightButton;

            }
            //the pin was already added
            else
            {
                pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
                
                pinView.enabled = YES;
                pinView.pinColor = MKPinAnnotationColorRed;
                pinView.animatesDrop = YES;
                pinView.canShowCallout = YES;
                pinView.draggable = NO;
                
                // Add a detail disclosure button to the callout.
                UIButton* rightButton = [UIButton buttonWithType:
                                         UIButtonTypeDetailDisclosure];
                [rightButton addTarget:self action:@selector(viewPinDetail:)
                      forControlEvents:UIControlEventTouchUpInside];
                pinView.rightCalloutAccessoryView = rightButton;
            }
        
        }
        else {
            
            pinView.annotation = annotation;
            
        }
        
        return pinView;
        
    }
    
    return nil;
    
}

- (IBAction)viewPinDetail:(id)sender
{
    [self performSegueWithIdentifier: @"viewPinDetailSegue" sender: self];
}

- (IBAction)addPinDetail:(id)sender
{
    [self performSegueWithIdentifier: @"addPinDetailSegue" sender: self];
}

- (void)handleLongPress:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan)
        return;
    
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D touchMapCoordinate =
    [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    
    //Initiate the Defined Annotation and specify the detail
    myPointDetail *dropPin = [[myPointDetail alloc] init:touchMapCoordinate];
    dropPin.title = @"New Pin";
    dropPin.subtitle = @"New sub";
    //dropPin.coordinate = touchMapCoordinate;
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

- (IBAction)done:(UIStoryboardSegue *)segue
{
    if ([[segue identifier] isEqualToString:@"ReturnInput"]) {
//        ViewPinDetailViewController *viewPinController = [segue sourceViewController];
//        if (addController.birdSighting) {
//            [self.dataController
//             addBirdSightingWithSighting:addController.birdSighting];
//            [[self tableView] reloadData];
//        }
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

@end
