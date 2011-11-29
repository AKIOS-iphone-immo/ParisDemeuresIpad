//
//  DiapoController3.m
//  Paris_Demeures_Ipad
//
//  Created by Christophe Bergé on 19/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DiapoController3.h"


@implementation DiapoController3

@synthesize delegate=_delegate;

/*
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
 {
 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 if (self) {
 // Custom initialization
 }
 return self;
 }
 */

- (void)dealloc
{
    UIImageView *iv;
    
    for (iv in [diaporama subviews]) {
        [iv release];
    }
    
    [navBar release];
    [diaporama release];
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(afficheDiaporama:) name:@"afficheDiaporama" object: nil];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"afficheDiaporamaReady" object: @"afficheDiaporamaReady"];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    isFirstRotation = YES;
    
    //NAV BAR
    navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 768, 90)];
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:[NSString stringWithString:arrayWithIndex.titre]];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"OK" style:UIBarButtonItemStyleDone target:self action:@selector(done:)];          
    navItem.rightBarButtonItem = anotherButton;
    [navBar pushNavigationItem:navItem animated:NO];
    [anotherButton release];
    
    navBar.backgroundColor = [UIColor blackColor];
    navBar.alpha = 0.5;
    
    [self.view addSubview:navBar];
    
    /*--- DIAPORAMA ---*/
    diaporama = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 768, 1024)];
    
    NSMutableArray *images = [[NSMutableArray alloc] init];
    [self getImages:images];
    
    scrollViewWidth = [images count];
    
    diaporama.contentSize = CGSizeMake(scrollViewWidth * 768, 1024);
    diaporama.pagingEnabled = YES;
    diaporama.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
                                  UIViewAutoresizingFlexibleHeight |
                                  UIViewAutoresizingFlexibleBottomMargin |
                                  UIViewAutoresizingFlexibleLeftMargin |
                                  UIViewAutoresizingFlexibleRightMargin |
                                  UIViewAutoresizingFlexibleTopMargin
                                  );
    diaporama.showsHorizontalScrollIndicator = NO;
    diaporama.showsVerticalScrollIndicator = NO;
    [diaporama setAutoresizesSubviews:YES];
    diaporama.contentMode = UIViewContentModeCenter;
    
    UIImage *image;
    
    int i = 0;
    for (image in images) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        [imageView setImage:image];
        [imageView setFrame:CGRectMake(i * 768, 0, 768, 1024)];
        imageView.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
                                      UIViewAutoresizingFlexibleHeight |
                                      UIViewAutoresizingFlexibleBottomMargin |
                                      UIViewAutoresizingFlexibleLeftMargin |
                                      UIViewAutoresizingFlexibleRightMargin |
                                      UIViewAutoresizingFlexibleTopMargin);
        //imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [diaporama addSubview:imageView];
        i++;
        //[imageView release];
    }
    
    scrollViewIndex = arrayWithIndex.arrayIndex;
    
    CGRect frameCenter = diaporama.frame;
    frameCenter.origin.x = frameCenter.size.width * (arrayWithIndex.arrayIndex);
    frameCenter.origin.y = 0;
    [diaporama scrollRectToVisible:frameCenter animated:NO];
    
    //[self.view addSubview:diaporama];
    [self.view insertSubview:diaporama atIndex:0];
    /*--- DIAPORAMA ---*/
    [images release];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated{
    if ([UIApplication sharedApplication].networkActivityIndicatorVisible == YES) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}

/*- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
 {
 NSLog(@"COUCOU");
 [diaporama setFrame:CGRectMake(0, 0, 460, 768)];
 UIImageView *imageView;
 
 for (imageView in [diaporama subviews]) {
 [imageView setFrame:CGRectMake(0, 0, 460, 768)];
 }
 }*/

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    UIImageView *imageView;
    
    int i = 0;
    
    if(fromInterfaceOrientation == UIInterfaceOrientationPortrait)
    {
        //if (isFirstRotation == NO) {
            NSLog(@"offset: %f",diaporama.contentOffset.x);
            CGFloat pageWidth = 768.0;
            [diaporama setFrame:CGRectMake(0, 0, 1024, 768)];
            [navBar setFrame:CGRectMake(0, 0, 1024, 90)];
            diaporama.contentSize = CGSizeMake(scrollViewWidth * 1024, 768);
            
            for (imageView in [diaporama subviews]) {
                [imageView setFrame:CGRectMake(i * 1024, 0, 1024, 768)];
                i++;
            }
            
            
            NSLog(@"pageW: %f",pageWidth);
            
            int page = 0;
            if (diaporama.contentOffset.x != 0.0) {
                page = (diaporama.contentOffset.x / pageWidth);
            }
            
            NSLog(@"page : %d", page);
            
            CGRect frameCenter = diaporama.frame;
            frameCenter.origin.x = frameCenter.size.width * page;
            frameCenter.origin.y = 0;
            [diaporama scrollRectToVisible:frameCenter animated:NO];
            
        /*}
        else{
            isFirstRotation = NO;
        }*/
        
    }
    
    if(fromInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        NSLog(@"offset: %f",diaporama.contentOffset.x);
        CGFloat pageWidth = 1024.0;
        [diaporama setFrame:CGRectMake(0, 0, 768, 1024)];
        [navBar setFrame:CGRectMake(0, 0, 768, 90)];
        diaporama.contentSize = CGSizeMake(scrollViewWidth * 768, 1024);
        
        for (imageView in [diaporama subviews]) {
            [imageView setFrame:CGRectMake(i * 768, 0, 768, 1024)];
            i++;
        }
        
        
        NSLog(@"pageW: %f",pageWidth);
        
        int page = 0;
        if (diaporama.contentOffset.x != 0.0) {
            page = (diaporama.contentOffset.x / pageWidth);
        }
        
        NSLog(@"page : %d", page);
        
        CGRect frameCenter = diaporama.frame;
        frameCenter.origin.x = frameCenter.size.width * page;
        frameCenter.origin.y = 0;
        [diaporama scrollRectToVisible:frameCenter animated:NO];
        
    }
    
    
    if(fromInterfaceOrientation == UIInterfaceOrientationLandscapeLeft)
    {
        NSLog(@"offset: %f",diaporama.contentOffset.x);
        CGFloat pageWidth = 1024.0;
        [diaporama setFrame:CGRectMake(0, 0, 768, 1024)];
        [navBar setFrame:CGRectMake(0, 0, 768, 90)];
        diaporama.contentSize = CGSizeMake(scrollViewWidth * 768, 1024);
        
        for (imageView in [diaporama subviews]) {
            [imageView setFrame:CGRectMake(i * 768, 0, 768, 1024)];
            i++;
        }
        
        
        NSLog(@"pageW: %f",pageWidth);
        
        int page = 0;
        if (diaporama.contentOffset.x != 0.0) {
            page = (diaporama.contentOffset.x / pageWidth);
        }
        
        NSLog(@"page : %d", page);
        
        CGRect frameCenter = diaporama.frame;
        frameCenter.origin.x = frameCenter.size.width * page;
        frameCenter.origin.y = 0;
        [diaporama scrollRectToVisible:frameCenter animated:NO];
        
    }
    
    if(fromInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        NSLog(@"offset: %f",diaporama.contentOffset.x);
        CGFloat pageWidth = 768.0;
        [diaporama setFrame:CGRectMake(0, 0, 1024, 768)];
        [navBar setFrame:CGRectMake(0, 0, 1024, 90)];
        diaporama.contentSize = CGSizeMake(scrollViewWidth * 1024, 768);
        
        for (imageView in [diaporama subviews]) {
            [imageView setFrame:CGRectMake(i * 1024, 0, 1024, 768)];
            i++;
        }
        
        
        NSLog(@"pageW: %f",pageWidth);
        
        int page = 0;
        if (diaporama.contentOffset.x != 0.0) {
            page = (diaporama.contentOffset.x / pageWidth);
        }
        
        NSLog(@"page : %d", page);
        
        CGRect frameCenter = diaporama.frame;
        frameCenter.origin.x = frameCenter.size.width * page;
        frameCenter.origin.y = 0;
        [diaporama scrollRectToVisible:frameCenter animated:NO];
        
    }
    
}

- (void) afficheDiaporama:(NSNotification *)notify {
	//arrayWithIndex = nil;
	arrayWithIndex = [[ArrayWithIndex alloc] initWithIndexAndArray:[[notify object] arrayIndex]
                                                             array:[[notify object] array]
                                                              info:[[notify object] titre]];
	//arrayWithIndex.array = [[notify object] array];
	//arrayWithIndex.arrayIndex = [[notify object] arrayIndex];
}

- (void)getImages:(NSMutableArray *)tableau {
	
	NSString *string = @"";
	
	for (string in arrayWithIndex.array) {
		NSData* imageData = [[NSData alloc]initWithContentsOfURL:
							 [NSURL URLWithString:
							  [NSString stringWithFormat:@"%@",
							   string]]];
		UIImage *image = [[UIImage alloc] initWithData:imageData];
		
		[tableau addObject:image];
		
		[imageData release];
		[image release];
	}
	//return tableau;
}

- (void)done:(id)sender
{
    [self.delegate diapoControllerDidFinish:self];
}
/*
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    CGRect frameCenter = diaporama.frame;
    frameCenter.origin.x = frameCenter.size.width * page;
    frameCenter.origin.y = 0;
    [diaporama scrollRectToVisible:frameCenter animated:NO];
}
*/
@end