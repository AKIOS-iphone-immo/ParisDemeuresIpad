//
//  AddressAnnotation.m
//  Paris_Demeures_Ipad
//
//  Created by Christophe Bergé on 16/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddressAnnotation.h"


@implementation AddressAnnotation

@synthesize coordinate;

- (NSString *)subtitle{
    return @"Sub Title";
}

- (NSString *)title{
    return @"Title";
}

-(id)initWithCoordinate:(CLLocationCoordinate2D) c{
    coordinate=c;
    //NSLog(@"%f,%f",c.latitude,c.longitude);
    return self;
}


@end
