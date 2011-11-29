//
//  Accueil.m
//  Paris_Demeures_Ipad
//
//  Created by Christophe Bergé on 23/07/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Accueil.h"


@implementation Accueil

@synthesize myTableViewController;
@synthesize rechercheCarte;
@synthesize whichView;
@synthesize tableauAnnonces1;


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
    self.navigationController.navigationBar.hidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(coverFlowAccueil:) name:@"coverFlowAccueil" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(afficheAnnonceReady:) name:@"afficheAnnonceReady" object: nil];
    
	self.view = [[UIView alloc] initWithFrame:CGRectMake(0,0,768,1024)];
    UIImageView *enTete = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.png"]];
    [enTete setFrame:CGRectMake(0,0,768,80)];
    [self.view addSubview:enTete];
    [enTete release];
    
    //BANDEAU FAVORIS
    UIImageView *bandeauFavoris = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bandeau-accueil.png"]];
    [bandeauFavoris setFrame:CGRectMake(0,100,768,40)];
    [self.view addSubview:bandeauFavoris];
    [bandeauFavoris release];
    
    myTableViewController = [[RootViewController alloc] init];
	
	UIButton *boutonRecherche = [UIButton buttonWithType:UIButtonTypeCustom];
	UIButton *boutonCarte = [UIButton buttonWithType:UIButtonTypeCustom];
	
	
	boutonRecherche.tag = 1;
	boutonCarte.tag = 2;
	
	
	[boutonRecherche setFrame:CGRectMake(100, 230, 560, 92)];
	[boutonCarte setFrame:CGRectMake(100, 380, 560, 92)];
		
	[boutonRecherche setUserInteractionEnabled:YES];
	[boutonCarte setUserInteractionEnabled:YES];
    
    boutonRecherche.showsTouchWhenHighlighted = NO;
    boutonCarte.showsTouchWhenHighlighted = NO;
    
	[boutonRecherche addTarget:self action:@selector(buttonPushed:) 
	 forControlEvents:UIControlEventTouchUpInside];
	[boutonCarte addTarget:self action:@selector(buttonPushed:) 
	 forControlEvents:UIControlEventTouchUpInside];
		
	UIImage *image = [self getImage:@"recherche-multicriteres"];
	[boutonRecherche setImage:image forState:UIControlStateNormal];
	
	image = [self getImage:@"recherche-sur-la-carte"];
	[boutonCarte setImage:image forState:UIControlStateNormal];
	
	[self.view addSubview:boutonRecherche];
	[self.view addSubview:boutonCarte];
	
    /*--- BIENS RECENTS ---*/
    
    //REQUETE HTTP POUR AVOIR LES BIENS RECENTS
    isConnectionErrorPrinted = NO;
    
    tableauAnnonces1 = [[NSMutableArray alloc] init];
    whichView = @"accueil";
    [NSThread detachNewThreadSelector:@selector(printHUD) toTarget:self withObject:nil];
    [self makeRequest];
    
    //LABEL
    UILabel *notreSelection = [[UILabel alloc] init];
    [notreSelection  setFrame:CGRectMake(0, 500, 768, 80)];
    notreSelection.text = @"Nos biens récents";
    notreSelection.textAlignment = UITextAlignmentCenter;
    notreSelection.font = [UIFont fontWithName:@"Arial-BoldMT" size:44];
    notreSelection.textColor = [UIColor colorWithRed:(104.0/255.0) green:(94.0/255.0) blue:(67.0/255.0) alpha:1.0];
    notreSelection.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:notreSelection];
    //LABEL
    
    /*--- BIENS RECENTS ---*/
    
    /*--- REALISATION AKIOS ---
    //LABEL
    UILabel *realisation = [[UILabel alloc] init];
    [realisation  setFrame:CGRectMake(500, 890, 300, 80)];
    realisation.text = @"Réalisation AKIOS.FR";
    realisation.textAlignment = UITextAlignmentCenter;
    realisation.font = [UIFont fontWithName:@"Arial" size:18];
    realisation.textColor = [UIColor colorWithRed:(104.0/255.0) green:(94.0/255.0) blue:(67.0/255.0) alpha:1.0];
    realisation.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:realisation];
    //LABEL
    --- REALISATION AKIOS ---*/
    
	[self.view setUserInteractionEnabled:YES];
	
    UIColor *fond = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.view.backgroundColor = fond;
    [fond release];
    
	[super viewDidLoad];
}

- (void) printHUD{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    pvc = [[ProgressViewContoller alloc] init];

    [self.navigationController.view addSubview:pvc.view];
    
    [pool release];
    
}

-(UIImage *) getImage:(NSString *)cheminImage{
	UIImage *image = [UIImage imageWithContentsOfFile:
					  [[NSBundle mainBundle] pathForResource:
					   cheminImage ofType:@"png"]];
	
	return image;
}

- (void) buttonPushed:(id)sender
{
	UIButton *button = sender;
	switch (button.tag) {
		case 1:
            whichView = @"multicriteres";
            [self.navigationController pushViewController:myTableViewController animated:YES];
            break;
		case 2:
            whichView = @"carte";
            rechercheCarte = [[RechercheCarte2 alloc] init];
            rechercheCarte.title = @"Recherche sur la carte";
            [self.navigationController pushViewController:rechercheCarte animated:YES];
            [rechercheCarte release];
            break;
		default:
			break;
	}
}

- (void) coverFlowAccueil:(NSNotification *)notify{
    NSNumber *num = [notify object];
    
    annonceSelected = [tableauAnnonces1 objectAtIndex:[num intValue]];
    
    [NSThread detachNewThreadSelector:@selector(printHUD) toTarget:self withObject:nil];
    
	AfficheAnnonceController2 *afficheAnnonceController = [[AfficheAnnonceController2 alloc] init];
	[self.navigationController pushViewController:afficheAnnonceController animated:YES];
	[afficheAnnonceController release];
    afficheAnnonceController = nil;
    
}

- (void) afficheAnnonceReady:(NSNotification *)notify {
	[[NSNotificationCenter defaultCenter] postNotificationName:@"afficheAnnonce" object: annonceSelected];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}

-(void)viewWillAppear:(BOOL)animated{
    
    //[self makeRequest];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"whichViewFrom" object: @"Accueil"];
    [myOpenFlowView centerOnSelectedCover:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    [pvc.view removeFromSuperview];
    //[myOpenFlowView release];
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
    [myTableViewController release];
    [rechercheCarte release];
    [myOpenFlowView release];
    [tableauAnnonces1 release];
    [networkQueue release];
    [pvc release];
    [super dealloc];
}

- (void)makeRequest{
    /*--- QUEUE POUR LES REQUETES HTTP ---*/
    networkQueue = [[ASINetworkQueue alloc] init];
    [networkQueue reset];
	[networkQueue setRequestDidFinishSelector:@selector(requestDone:)];
	[networkQueue setRequestDidFailSelector:@selector(requestFailed:)];
	[networkQueue setDelegate:self];
    /*--- QUEUE POUR LES REQUETES HTTP ---*/
    
    NSString *bodyString = @"http://paris-demeures.com/biens_recents.asp";
    
    NSLog(@"bodyString:%@\n",bodyString);
    
    ASIHTTPRequest *request = [[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:bodyString]] autorelease];
    [request setUserInfo:[NSDictionary dictionaryWithObject:[NSString stringWithString:@"biens recents"] forKey:@"name"]];
    [networkQueue addOperation:request];
    
    [networkQueue go];
}

- (void)requestDone:(ASIHTTPRequest *)request
{
	NSData *responseData = [request responseData];
    
    NSLog(@"dataBrute long: %d",[responseData length]);
    
    NSString * string = [[NSString alloc] initWithData:responseData encoding:NSISOLatin1StringEncoding];
    NSLog(@"REPONSE DU WEB: \"%@\"\n",string);
    
    NSError *error = nil;
    
    if ([string length] > 0) {
        
        NSUInteger zap = 60;
        
        NSData *dataString = [string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        
        NSData *data = [[NSData alloc] initWithData:[dataString subdataWithRange:NSMakeRange(59, [dataString length] - zap)]];
        
        //ON PARSE DU XML
        
        /*--- POUR LE TEST OFF LINE ---
         NSFileManager *fileManager = [NSFileManager defaultManager];
         NSString *xmlSamplePath = [[NSBundle mainBundle] pathForResource:@"Biens" ofType:@"xml"];
         data = [fileManager contentsAtPath:xmlSamplePath];
         string = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
         NSLog(@"REPONSE DU WEB: %@\n",string);
         */
        
        if ([string rangeOfString:@"<biens></biens>"].length != 0) {
            //AUCUNE ANNONCES
            NSDictionary *userInfo = [NSDictionary 
                                      dictionaryWithObject:@"Aucun bien ne correspond à ces critères dans notre base de données."
                                      forKey:NSLocalizedDescriptionKey];
            
            error =[NSError errorWithDomain:@"Aucun bien trouvé."
                                       code:1 userInfo:userInfo];
        }
        else{
            NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:data];
            XMLParser *parser = [[XMLParser alloc] initXMLParser];
            
            [xmlParser setDelegate:parser];
            
            BOOL success = [xmlParser parse];
            
            if(success)
                NSLog(@"No Errors on XML parsing.");
            else
                NSLog(@"Error on XML parsing!!!");
            
            //COVER FLOW
            NSMutableArray *imagesArray = [[NSMutableArray alloc] init];
            
            for (Annonce *uneAnnonce in tableauAnnonces1) {
                NSString *photos = [uneAnnonce valueForKey:@"photos"];
                if ([photos length] > 0) {
                    [imagesArray addObject:[[NSMutableArray arrayWithArray:[photos componentsSeparatedByString:@","]] objectAtIndex:0]];
                }
            }
            
            
            myOpenFlowView = [[AFOpenFlowView alloc] init];
            int num = [imagesArray count];
            [myOpenFlowView setNumberOfImages:num];
            
            [myOpenFlowView setFrame:CGRectMake(30, 600, 700, 305)];
            for (int index = 0; index < num; index++){
                NSData* imageData = [[NSData alloc]initWithContentsOfURL:
                                     [NSURL URLWithString:
                                      [NSString stringWithFormat:@"%@",
                                       [imagesArray objectAtIndex:index]]]];
                if (imageData != nil) {
                    UIImage *image = [[UIImage alloc] initWithData:imageData];
                    [myOpenFlowView setImage:image forIndex:index];
                }
                [imageData release];
            }
            
            [self.view addSubview:myOpenFlowView];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"whichViewFrom" object: @"Accueil"];
            
            [pvc.view removeFromSuperview];
        }
        [string release];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    UIAlertView *alert;
    
    NSLog(@"Connection failed! Error - %@",
          [error localizedDescription]);
    
    if (!isConnectionErrorPrinted) {
        alert = [[UIAlertView alloc] initWithTitle:@"Erreur de connection."
                                           message:[error localizedDescription]
                                          delegate:self
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil];
        [alert show];
        [alert release];
        isConnectionErrorPrinted = YES;
    }
    [pvc.view removeFromSuperview];
}

@end
