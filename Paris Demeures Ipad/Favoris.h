//
//  Favoris.h
//  Paris_Demeures_Ipad
//
//  Created by Christophe Bergé on 24/07/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
#import "AfficheListeAnnoncesController2.h"
//#import "XMLParser.h"

@class RootViewController;
@class ASINetworkQueue;
@class XMLParser;

@interface Favoris : UIViewController {
    NSMutableArray *recherchesSauvees;
    BOOL noRecherche;
    UILabel *labelType1;
    UILabel *labelVille1;
    UILabel *labelPrix1;
    UILabel *labelSurface1;
    
    UILabel *labelType2;
    UILabel *labelVille2;
    UILabel *labelPrix2;
    UILabel *labelSurface2;
    
    UILabel *labelType3;
    UILabel *labelVille3;
    UILabel *labelPrix3;
    UILabel *labelSurface3;
    
    RootViewController *rechercheMulti;
    NSString *whichView;
    NSMutableArray *tableauAnnonces1;
    
    BOOL isConnectionErrorPrinted;
    ASINetworkQueue *networkQueue;
    NSMutableDictionary *criteres2;

}

@property (nonatomic, assign) NSString *whichView;
@property (nonatomic, retain) RootViewController *rechercheMulti;
@property (nonatomic, copy) NSMutableArray *tableauAnnonces1;

@end
