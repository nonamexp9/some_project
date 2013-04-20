//
//  myPointDetail.m
//  LocationTrial
//
//  Created by Kan Boonprakub on 3/25/56 BE.
//  Copyright (c) 2556 Kan Boonprakub. All rights reserved.
//

#import "myPointDetail.h"

@implementation myPointDetail

@synthesize coordinate, title, subtitle, type, elapsedTime, timer, isNew;

- (id)initWithLocation:(CLLocationCoordinate2D)pinCoordinate WithTitle:(NSString *)pinTitle WithSubTitle:(NSString *)pinSubTitle WithType:(NSString *)pinType {
    
    self = [super init];
    
    if(self) {
        
        coordinate = pinCoordinate;
        title = pinTitle;
        subtitle = pinSubTitle;
        type = pinType;
        timer = 1800;
        
        //To Implement timer for 30 minutes and when fire remove pin unless renew/Repeat
        elapsedTime = [NSTimer scheduledTimerWithTimeInterval:1800 target:self selector: @selector(elapsedTimer:) userInfo:nil repeats:NO];
        isNew = NO;
    }
    
    return self;
    
}

- (id)init:(CLLocationCoordinate2D)pinCoordinate
{
    self = [super init];
    
    if(self) {
        coordinate = pinCoordinate;
        isNew = YES;
    }
    
    return self;
}

- (void)elapsedTimer:(NSTimer *)timer
{
    
}

@end
