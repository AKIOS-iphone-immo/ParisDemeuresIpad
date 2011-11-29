//
//  AgenceViewController.m
//  Paris_Demeures_Ipad
//
//  Created by Christophe Bergé on 14/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AgenceViewController.h"


@implementation AgenceViewController

@synthesize whichView;
@synthesize tableauAnnonces1;

- (void)agenceModalViewDidFinish:(AgenceModalView *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)agenceModalViewFicheDidFinish:(AfficheAnnonceController3 *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

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
    [myOpenFlowView release];
    [tableauAnnonces1 release];
    [networkQueue release];
    [pvc release];
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(afficheTextReady:) name:@"afficheTextReady" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(coverFlowAgence:) name:@"coverFlowAgence" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(afficheAnnonce3Ready:) name:@"afficheAnnonce3Ready" object: nil];
    
    //COULEUR DE FOND
    UIColor *fond = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.view.backgroundColor = fond;
    [fond release];
    
    //HEADER
    UIImageView *enTete = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.png"]];
    [enTete setFrame:CGRectMake(0,0,768,80)];
    [self.view addSubview:enTete];
    [enTete release];
    
    //BANDEAU FAVORIS
    UIImageView *bandeauFavoris = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bandeau-agence.png"]];
    [bandeauFavoris setFrame:CGRectMake(0,100,768,40)];
    [self.view addSubview:bandeauFavoris];
    [bandeauFavoris release];
    
    //POSITIONS BOUTONS
    int x1 = 80;
    int x2 = 385;
    int y1 = 230;
    int y2 = 380;
    int w = 300;
    int l = 100;
    
    /*--- BOUTON HISTORIQUE ---*/
    UIButton *boutonHistorique = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[boutonHistorique setFrame:CGRectMake(x1, y1, w, l)];
	[boutonHistorique setUserInteractionEnabled:YES];
	[boutonHistorique addTarget:self action:@selector(buttonPushed:) 
              forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *image = [UIImage imageNamed:@"historique.png"];
	[boutonHistorique setImage:image forState:UIControlStateNormal];
    
    boutonHistorique.showsTouchWhenHighlighted = NO;
    boutonHistorique.tag = 1;
	
	[self.view addSubview:boutonHistorique];
    /*--- BOUTON HISTORIQUE ---*/
    /*--- BOUTON ENGAGEMENTS ---*/
    UIButton *boutonEngagements = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[boutonEngagements setFrame:CGRectMake(x2, y1, w, l)];
	[boutonEngagements setUserInteractionEnabled:YES];
	[boutonEngagements addTarget:self action:@selector(buttonPushed:) 
               forControlEvents:UIControlEventTouchUpInside];
    
    image = [UIImage imageNamed:@"engagements.png"];
	[boutonEngagements setImage:image forState:UIControlStateNormal];
    
    boutonEngagements.showsTouchWhenHighlighted = NO;
    boutonEngagements.tag = 2;
	
	[self.view addSubview:boutonEngagements];
    /*--- BOUTON ENGAGEMENTS ---*/
    /*--- BOUTON COLLABO ---*/
    UIButton *boutonCollaborateurs = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[boutonCollaborateurs setFrame:CGRectMake(x1, y2, w, l)];
	[boutonCollaborateurs setUserInteractionEnabled:YES];
	[boutonCollaborateurs addTarget:self action:@selector(buttonPushed:) 
                forControlEvents:UIControlEventTouchUpInside];
    
    image = [UIImage imageNamed:@"collaborateurs.png"];
	[boutonCollaborateurs setImage:image forState:UIControlStateNormal];
    
    boutonCollaborateurs.showsTouchWhenHighlighted = NO;
    boutonCollaborateurs.tag = 3;
	
	[self.view addSubview:boutonCollaborateurs];
    /*--- BOUTON COLLABO ---*/
    /*--- BOUTON PRESTA ---*/
    UIButton *boutonPrestations = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[boutonPrestations setFrame:CGRectMake(x2, y2, w, l)];
	[boutonPrestations setUserInteractionEnabled:YES];
	[boutonPrestations addTarget:self action:@selector(buttonPushed:) 
                   forControlEvents:UIControlEventTouchUpInside];
    
    image = [UIImage imageNamed:@"prestations.png"];
	[boutonPrestations setImage:image forState:UIControlStateNormal];
    
    boutonPrestations.showsTouchWhenHighlighted = NO;
    boutonPrestations.tag = 4;
	
	[self.view addSubview:boutonPrestations];
    /*--- BOUTON PRESTA ---*/
    
    /*--- TEXTE ---*/
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(100, 500, 550, 500)];
    textView.text = @"Paris Demeures, conseil en immobilier de prestige & de charme";
    textView.backgroundColor = [UIColor clearColor];
    textView.editable = NO;
    textView.textAlignment = UITextAlignmentCenter;
    textView.font = [UIFont fontWithName:@"Arial" size:28];
    
    [self.view addSubview:textView];
    [textView release];
    /*--- TEXTE ---*/
    
    //REQUETE HTTP POUR AVOIR LES BIENS RECENTS ###OBSOLETE: ON A LES BIENS RECENTS DEPUIS LA PAGE D'ACCUEIL###
    isConnectionErrorPrinted = NO;
    
    tableauAnnonces1 = [[NSMutableArray alloc] init];
    whichView = @"agence";
    [NSThread detachNewThreadSelector:@selector(printHUD) toTarget:self withObject:nil];
    [self makeRequest];
}

- (void) printHUD{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    pvc = [[ProgressViewContoller alloc] init];
    [self.view addSubview:pvc.view];
    
    [pool release];
    
}

- (void) buttonPushed:(id)sender
{
	UIButton *button = sender;
    AgenceModalView *agenceModalView = [[AgenceModalView alloc] init];
    agenceModalView.delegate = self;
    
	switch (button.tag) {
		case 1:
            NSLog(@"HIst");
            buttonTag = [NSNumber numberWithInt:button.tag];
            agenceModalView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self presentModalViewController:agenceModalView animated:YES];
            [agenceModalView release];
			break;
		case 2:
            NSLog(@"Enga");
            buttonTag = [NSNumber numberWithInt:button.tag];
            agenceModalView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self presentModalViewController:agenceModalView animated:YES];
            [agenceModalView release];
            break;
        case 3:
            NSLog(@"collabo");
            buttonTag = [NSNumber numberWithInt:button.tag];
            agenceModalView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self presentModalViewController:agenceModalView animated:YES];
            [agenceModalView release];
            break;
        case 4:
            NSLog(@"presta.");
            buttonTag = [NSNumber numberWithInt:button.tag];
            agenceModalView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self presentModalViewController:agenceModalView animated:YES];
            [agenceModalView release];
            break;
		default:
			break;
	}
}

- (void) coverFlowAgence:(NSNotification *)notify{
    NSNumber *num = [notify object];
    
    annonceSelected = [tableauAnnonces1 objectAtIndex:[num intValue]];
    
    [NSThread detachNewThreadSelector:@selector(printHUD) toTarget:self withObject:nil];
    
    AfficheAnnonceController3 *aMVF = [[AfficheAnnonceController3 alloc] init];
    
    aMVF.delegate = self;
    aMVF.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:aMVF animated:YES];
    [aMVF release];
    aMVF = nil;
    
}

- (void) afficheAnnonce3Ready:(NSNotification *)notify {
	[[NSNotificationCenter defaultCenter] postNotificationName:@"afficheAnnonce3" object: annonceSelected];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"whichViewFrom" object: @"Agence"];
    [myOpenFlowView centerOnSelectedCover:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    [pvc.view removeFromSuperview];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)afficheTextReady:(NSNotification *)notify{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"afficheText" object: buttonTag];
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
            [[NSNotificationCenter defaultCenter] postNotificationName:@"whichViewFrom" object: @"Agence"];
            
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
