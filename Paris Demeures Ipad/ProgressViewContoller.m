//
//  ProgressViewContoller.m
//  Paris_Demeures_Ipad
//
//  Created by Christophe Bergé on 17/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ProgressViewContoller.h"


@implementation ProgressViewContoller

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [indic release];
    [waitLabel release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    self.view.layer.cornerRadius = 25;
    
    [self.view setFrame:CGRectMake(234, 362, 300, 300)];
    
    //indic = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(150, 150, 60, 60)];
    
    indic = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [indic setCenter:CGPointMake(150, 150)];
    
    [self.view addSubview:indic];
    
    [indic startAnimating];
    
    waitLabel = [[UILabel alloc] init];
    waitLabel.text = @"Chargement en cours...";
    waitLabel.backgroundColor = [UIColor clearColor];
    waitLabel.textAlignment = UITextAlignmentCenter;
    waitLabel.textColor = [UIColor whiteColor];
    waitLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:22];
    
    [waitLabel setFrame:CGRectMake(0, 200, 300, 50)];
    
    [self.view addSubview:waitLabel];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillDisappear: (BOOL)animated
{
    [indic stopAnimating];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
