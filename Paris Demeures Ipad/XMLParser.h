//
//  XMLParser.h
//  Paris_Demeures_Ipad
//
//  Created by Christophe Bergé on 01/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Annonce.h"
#import "Paris_Demeures_IpadAppDelegate.h"

@class Paris_Demeures_IpadAppDelegate, Annonce;

@interface XMLParser : NSObject {
	NSMutableString *currentElementValue;
	Annonce *uneAnnonce;
	Paris_Demeures_IpadAppDelegate *appDelegate;
}

- (XMLParser *) initXMLParser;

@end
