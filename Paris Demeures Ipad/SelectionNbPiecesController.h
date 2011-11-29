//
//  SelectionNbPiecesController.h
//  Paris_Demeures_Ipad
//
//  Created by Christophe Bergé on 28/07/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SelectionNbPiecesController : UITableViewController {
	NSMutableArray *listOfItems;
	NSMutableArray *rowSelected;
	NSMutableArray *rowSelectedValue;
    NSString *nb_pieces_mini;
    NSString *nb_pieces_maxi;
}

@property (nonatomic, retain) NSMutableArray *listOfItems;
@property (nonatomic, retain) NSMutableArray *rowSelected;
@property (nonatomic, retain) NSMutableArray *rowSelectedValue;

@end
