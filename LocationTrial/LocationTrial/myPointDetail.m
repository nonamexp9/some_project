//
//  myPointDetail.m
//  LocationTrial
//
//  Created by Kan Boonprakub on 3/25/56 BE.
//  Copyright (c) 2556 Kan Boonprakub. All rights reserved.
//

#import "myPointDetail.h"

@implementation myPointDetail

@synthesize coordinate, title, subtitle, type, elapsedTime, timer;

- (id)initWithLocation:(CLLocationCoordinate2D)pinCoodinate WithTitle:(NSString *)pinTitle WithSubTitle:(NSString *)pinSubTitle WithType:(NSString *)pinType {
    
    self = [super init];
    
    if(self) {
        
        coordinate = pinCoodinate;
        title = pinTitle;
        subtitle = pinSubTitle;
        type = pinType;
        timer = 1800;
        
        //To Implement timer for 30 minutes and when fire remove pin unless renew/Repeat
        elapsedTime = [NSTimer scheduledTimerWithTimeInterval:1800 target:self selector: @selector(elapsedTimer:) userInfo:nil repeats:NO];
        
    }
    
    return self;
    
}

- (void)elapsedTimer:(NSTimer *)timer
{
    
}

@end
