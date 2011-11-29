//
//  RootViewController.h
//  Paris_Demeures_Ipad
//
//  Created by Christophe Bergé on 16/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ChoixVilleController2.h"
#import "SelectionTypeBienController.h"
#import "SelectionSurfaceController.h"
#import "SelectionNbPiecesController.h"
#import "SelectionBudgetController.h"
#import "AfficheListeAnnoncesController2.h"
#import "Intervalle.h"
#import "Utility.h"
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"

@class ASINetworkQueue;

@interface RootViewController : UIViewController {
	NSMutableArray *tableauAnnonces1;
	NSMutableDictionary *criteres1;
    NSMutableDictionary *criteres2;
    BOOL isConnectionErrorPrinted;
    ASINetworkQueue *networkQueue;
    NSMutableArray *tableauCommunes;
}

@property (nonatomic, copy) NSMutableArray *tableauAnnonces1;
@property (nonatomic, copy) NSMutableArray *tableauCommunes;
@property (nonatomic, copy) NSMutableDictionary *criteres1;
@property (nonatomic, assign) NSMutableDictionary *criteres2;

-(UIImage *) getImage:(NSString *)cheminImage;
- (BOOL) sendRequest;
- (void) sauvegardeRecherches;

@end
