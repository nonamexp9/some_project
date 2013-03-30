//
//  myPointDetail.h
//  LocationTrial
//
//  Created by Kan Boonprakub on 3/25/56 BE.
//  Copyright (c) 2556 Kan Boonprakub. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>

@interface myPointDetail : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic,copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic,retain) NSString *type;
@property (nonatomic) NSTimer *elapsedTime;
@property (assign) int timer;

- (id)initWithLocation:(CLLocationCoordinate2D) pinCoodinate WithTitle: (NSString *) pinTitle WithSubTitle: (NSString *) pinSubTitle WithType: (NSString *) pinType;

@end
