//
//  AfficheAnnonceController2.h
//  Paris_Demeures_Ipad
//
//  Created by Christophe Bergé on 13/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArrayWithIndex.h"
#import "Annonce.h"
#import "DiapoController3.h"
#import "AFOpenFlowViewDiapo.h"
#import "ProgressViewContoller.h"


@interface AfficheAnnonceController2 : UIViewController <DiapoController3Delegate>{
    Annonce *lAnnonce;
	NSMutableArray *imagesArray;
	ArrayWithIndex *arrayWithIndex;
    AFOpenFlowViewDiapo *myOpenFlowView;
    ProgressViewContoller *pvc;
}

@end
