//
//  ChoixVilleController.h
//  RezoImmoTest1
//
//  Created by Christophe Bergé on 26/07/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ChoixVilleController2 : UIViewController <NSFetchedResultsControllerDelegate, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource> {
	NSFetchedResultsController *resultsController;
    UITableView *myTableView;
	UISearchBar *searchBar;
	BOOL searching;
	BOOL letUserSelectRow;
	NSMutableArray *selection;
    NSString *chosenCity;

}

@property (nonatomic,retain) NSFetchedResultsController *resultsController;
@property (nonatomic,assign) BOOL searching;
@property (nonatomic,assign) BOOL letUserSelectRow;
@property (nonatomic,retain) NSMutableArray *selection;


- (void) searchTableView:(NSString *)theText;
- (void) doneSearching_Clicked:(id)sender;

@end
