//
//  Commune.m
//  Paris Demeures Ipad
//
//  Created by Christophe Bergé on 26/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Commune.h"


@implementation Commune

@synthesize code, ville;

- (void) dealloc {
    [code release];
	[ville release];
	[super dealloc];
}

@end
