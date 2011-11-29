//
//  Accueil.h
//  Paris_Demeures_Ipad
//
//  Created by Christophe Bergé on 23/07/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "RootViewController.h"
#import "RechercheCarte2.h"
#import "AFOpenFlowView.h"
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
#import "Annonce.h"
#import "ProgressViewContoller.h"
#import "AfficheAnnonceController2.h"

@class ASINetworkQueue;
@class RootViewController;
@class RechercheCarte2;

@interface Accueil : UIViewController {
    RootViewController *myTableViewController;
    RechercheCarte2 *rechercheCarte;
    NSString *whichView;
    AFOpenFlowView *myOpenFlowView;
    ASINetworkQueue *networkQueue;
    NSMutableArray *tableauAnnonces1;
    BOOL isConnectionErrorPrinted;
    ProgressViewContoller *pvc;
    Annonce *annonceSelected;

}

@property (nonatomic, retain) RootViewController *myTableViewController;
@property (nonatomic, retain) RechercheCarte2 *rechercheCarte;
@property (nonatomic, assign) NSString *whichView;
@property (nonatomic, copy) NSMutableArray *tableauAnnonces1;

-(UIImage *) getImage:(NSString *)cheminImage;

@end
