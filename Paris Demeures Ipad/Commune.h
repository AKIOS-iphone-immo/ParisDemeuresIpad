//
//  Commune.h
//  Paris Demeures Ipad
//
//  Created by Christophe Bergé on 26/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Commune : NSObject {
	NSString *code;
	NSString *ville;
}

@property (nonatomic, retain) NSString *code;
@property (nonatomic, retain) NSString *ville;

@end
