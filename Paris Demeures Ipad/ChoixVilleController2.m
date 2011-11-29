//
//  ChoixVilleController.m
//  RezoImmoTest1
//
//  Created by Christophe Bergé on 26/07/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ChoixVilleController2.h"
#import "Paris_Demeures_IpadAppDelegate.h"

@implementation ChoixVilleController2

@synthesize resultsController, searching, letUserSelectRow, selection;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	
    self.navigationController.navigationBar.hidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(setCriteres:) name:@"setCriteres" object: nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"getCriteres" object: nil];
    
    //HEADER
    UIImageView *enTete = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.png"]];
    [enTete setFrame:CGRectMake(0,0,768,80)];
    [self.view addSubview:enTete];
    [enTete release];
    
    //BOUTON RETOUR
    UIButton *boutonRetour = [UIButton buttonWithType:UIButtonTypeCustom];
    boutonRetour.showsTouchWhenHighlighted = NO;
    boutonRetour.tag = 0;
    
    [boutonRetour setFrame:CGRectMake(20,12,100,60)];
    [boutonRetour addTarget:self action:@selector(buttonPushed:) 
           forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *image = [UIImage imageNamed:@"bouton-retour2.png"];
    [boutonRetour setImage:image forState:UIControlStateNormal];
    
    [self.view addSubview:boutonRetour];
    
	//Set the title
	//self.navigationItem.title = @"Villes";
	
    //TABLE VIEW
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 101, 768, 974) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cell.png"]];
    [self.view addSubview:myTableView];
    
	//Add the search bar
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 768, 88)];
	myTableView.tableHeaderView = searchBar;
	searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    searchBar.delegate = self;
	searchBar.tintColor = [UIColor colorWithRed:148.0/255.0 green:127.0/255.0 blue:96.0/255.0 alpha:0.0];
    searchBar.text = chosenCity;
    
	searching = NO;
	letUserSelectRow = YES;
	
	selection = [[NSMutableArray alloc] init];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) buttonPushed:(id)sender
{
	UIButton *button = sender;
    
	switch (button.tag) {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
            break;
		default:
			break;
	}
}

- (void) setCriteres:(NSNotification *)notify
{
    NSLog(@"criteres setCriteres %@",[notify object]);
    NSMutableDictionary *criteres = [notify object];
    chosenCity = [criteres valueForKey:@"ville1"];
    NSLog(@"chosencity: %@",chosenCity);
    
    if (chosenCity != @"") {
        searchBar.text = chosenCity;
    }
}

- (void)viewWillAppear:(BOOL)animated {
	[myTableView reloadData];
    [super viewWillAppear:animated];
	[myTableView reloadData];
}


- (void)viewDidAppear:(BOOL)animated {
	[myTableView reloadData];
    [super viewDidAppear:animated];
	[myTableView reloadData];
}


- (void)viewWillDisappear:(BOOL)animated {
	//[[NSNotificationCenter defaultCenter] postNotificationName:@"citySelected" object: selection];
    //self.navigationController.navigationBar.hidden = YES;
    [super viewWillDisappear:animated];
}

/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
	
	return 1;
	
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	if (searching)
		return [[self.resultsController fetchedObjects] count];
	else {
		
		return 0;
	}
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSManagedObject *info = [resultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [info valueForKey:@"commune"];
    cell.detailTextLabel.text = [info valueForKey:@"code"];
    //cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cell.png"]];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"ObjectCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    
	//cell.textLabel.text = [[resultsController fetchedObjects] objectAtIndex:indexPath.row];
	/*NSManagedObject *managedObject = [resultsController objectAtIndexPath:indexPath];
	cell.textLabel.text = [managedObject valueForKey:@"commune"];
	cell.detailTextLabel.text = [managedObject valueForKey:@"code"];*/
	[self configureCell:cell atIndexPath:indexPath];
	
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (NSIndexPath *)tableView :(UITableView *)theTableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if(letUserSelectRow)
		return indexPath;
	else
		return nil;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSManagedObject *managedObject = [resultsController objectAtIndexPath:indexPath];
	
	NSString *commune = [[NSString alloc] initWithFormat:@"%@",[managedObject valueForKey:@"commune"]];
	NSString *code = [[NSString alloc] initWithFormat:@"%@",[managedObject valueForKey:@"code"]];
	
    [selection release];
    selection = [[NSMutableArray alloc] init];
    
	[selection addObject:commune];
	[selection addObject:code];
	
	[commune release];
	[code release];
	
    [[NSNotificationCenter defaultCenter] postNotificationName:@"citySelected" object: selection];
    
	[self.navigationController popViewControllerAnimated:YES];
	
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90.0;
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
	searchBar = nil;
	resultsController = nil;
}


- (void)dealloc {
	[searchBar release];
	[selection release];
    //[chosenCity release];
    [super dealloc];
}

#pragma mark -
#pragma mark searchBar delegate

- (void) searchBarTextDidBeginEditing:(UISearchBar *)theSearchBar {
	
	searching = YES;
	letUserSelectRow = NO;
	myTableView.scrollEnabled = NO;

}

- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText {
	
	if([searchText length] > 1) {
		searching = YES;
		letUserSelectRow = YES;
		myTableView.scrollEnabled = YES;
		[self searchTableView:searchText];
	}
	else {
		
		searching = NO;
		letUserSelectRow = NO;
		myTableView.scrollEnabled = NO;
	}
	
	[myTableView reloadData];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar {
	
	[self searchTableView:theSearchBar.text];
}

- (void) searchTableView:(NSString *)theText {
	
	//REQUETE SUR LA BDD
	
	Paris_Demeures_IpadAppDelegate *appDelegate = (Paris_Demeures_IpadAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *context = appDelegate.managedObjectContext;
	
	NSFetchRequest *requete = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Codes" inManagedObjectContext:context];
	
	[requete setEntity:entity];
	[requete setFetchBatchSize:20];
	
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"commune" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	
	[requete setSortDescriptors:sortDescriptors];
	
	[sortDescriptor release];
	[sortDescriptors release];
	
	NSPredicate *predicat;
	
	if ( ([searchBar.text intValue] > 0)) {
		predicat = [NSPredicate predicateWithFormat:@"code beginswith[cd] %@", theText];
	}
	else {
		predicat = [NSPredicate predicateWithFormat:@"commune beginswith[cd] %@", theText];
	}
	
	
	[requete setPredicate:predicat];
	
	NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] 
															initWithFetchRequest:requete
															managedObjectContext:context
															sectionNameKeyPath:nil
															cacheName:nil];
	fetchedResultsController.delegate = self;
	NSError *error;
	BOOL success = [fetchedResultsController performFetch:&error];
	if (!success) {
		// Gérez l'erreur ici.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	
	[requete release];
	
	resultsController = fetchedResultsController;
	
}

- (void) doneSearching_Clicked:(id)sender {
	
	searchBar.text = @"";
	[searchBar resignFirstResponder];
	
	letUserSelectRow = YES;
	searching = NO;
	self.navigationItem.rightBarButtonItem = nil;
	myTableView.scrollEnabled = YES;
	
	[myTableView reloadData];
}

@end

