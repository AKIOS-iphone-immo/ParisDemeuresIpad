//
//  Annonce.h
//  RezoImmoTest1
//
//  Created by Christophe Bergé on 01/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Annonce : NSObject {
	//NSInteger idAnnonce;
    NSString *ref;
	NSString *nb_pieces;
	NSString *surface;
	NSString *ville;
	NSString *cp;
	NSString *prix;
	NSString *descriptif;
	NSString *photos; 
	
}

//@property (nonatomic, readwrite) NSInteger idAnnonce;
@property (nonatomic, retain) NSString *ref;
@property (nonatomic, retain) NSString *nb_pieces;
@property (nonatomic, retain) NSString *surface;
@property (nonatomic, retain) NSString *ville;
@property (nonatomic, copy) NSString *cp;
@property (nonatomic, retain) NSString *prix;
@property (nonatomic, retain) NSString *descriptif;
@property (nonatomic, retain) NSString *photos;

@end
