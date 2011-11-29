//
//  DiapoController.m
//  RezoImmoTest1
//
//  Created by Christophe Bergé on 22/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DiapoController.h"


@implementation DiapoController

@synthesize arrayWithIndex;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	//arrayWithIndex = nil;
	[[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(afficheDiaporama:) name:@"afficheDiaporama" object: nil];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"afficheDiaporamaReady" object: @"afficheDiaporamaReady"];
	
	IGUIScrollViewImage *svimage = [[IGUIScrollViewImage alloc] init];  
	[svimage setContentArray:[self getImages]];  
	//[svimage setSizeFromParentView:self.view];  
	//[svimage enablePageControlOnBottom];
	
    UIScrollView *diaporama = [svimage getWithPosition:arrayWithIndex.arrayIndex]; 
    
	[self.view addSubview:diaporama];
     [svimage release];
    
    /*--- DIAPORAMA ---*/
    /*UIScrollView *diaporama = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 450)];
    
    NSMutableArray *images = [[NSMutableArray alloc] init];
    images = [self getImages];
    
    [self.view addSubview:diaporama];*/
    /*--- DIAPORAMA ---*/
    
	
}

- (void) afficheDiaporama:(NSNotification *)notify {
	//arrayWithIndex = nil;
	arrayWithIndex = [[ArrayWithIndex alloc] initWithIndexAndArray:[[notify object] arrayIndex] array:[[notify object] array]];
	//arrayWithIndex.array = [[notify object] array];
	//arrayWithIndex.arrayIndex = [[notify object] arrayIndex];
}

- (NSMutableArray *)getImages {
	NSMutableArray *array = [[[NSMutableArray alloc] init] autorelease];
	
	NSString *string = @"";
	
	for (string in arrayWithIndex.array) {
		NSData* imageData = [[NSData alloc]initWithContentsOfURL:
							 [NSURL URLWithString:
							  [NSString stringWithFormat:@"%@",
							   string]]];
		UIImage *image = [[UIImage alloc] initWithData:imageData];
		
		[array addObject:image];
		
		[imageData release];
		[image release];
	}
	return array;
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[arrayWithIndex release];
    [super dealloc];
}


@end
