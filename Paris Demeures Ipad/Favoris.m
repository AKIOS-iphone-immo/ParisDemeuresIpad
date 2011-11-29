//
//  Favoris.m
//  Paris_Demeures_Ipad
//
//  Created by Christophe Bergé on 24/07/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Favoris.h"


@implementation Favoris

@synthesize whichView, rechercheMulti, tableauAnnonces1;

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
    
    self.navigationController.navigationBar.hidden = YES;
    
    tableauAnnonces1 = [[NSMutableArray alloc] init];
    criteres2 = [[NSMutableDictionary alloc] init];
    rechercheMulti = [[RootViewController alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(afficheListeAnnoncesReady:) name:@"afficheListeAnnoncesReady" object: nil];
    
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
    UIImageView *bandeauFavoris = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bandeau-favoris.png"]];
    [bandeauFavoris setFrame:CGRectMake(0,100,768,40)];
    [self.view addSubview:bandeauFavoris];
    [bandeauFavoris release];
    
    isConnectionErrorPrinted = NO;
    
    /*--- QUEUE POUR LES REQUETES HTTP ---*/
    networkQueue = [[ASINetworkQueue alloc] init];
    [networkQueue reset];
	[networkQueue setRequestDidFinishSelector:@selector(requestDone:)];
	[networkQueue setRequestDidFailSelector:@selector(requestFailed:)];
	[networkQueue setDelegate:self];
    /*--- QUEUE POUR LES REQUETES HTTP ---*/
    
    /*--- BOUTONS ---*/
    /*---- 1ERE RANGEE ----*/
    /*----- INFOS -----*/
    int w = 450;
    int h = 400;
    
    UIButton *boutonRangee1 = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[boutonRangee1 setFrame:CGRectMake(50, 80, w, h)];
	[boutonRangee1 setUserInteractionEnabled:YES];
	[boutonRangee1 addTarget:self action:@selector(buttonInfosPushed:) 
            forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *image = [UIImage imageNamed:@"espace-informations.png"];
	[boutonRangee1 setImage:image forState:UIControlStateNormal];
    
    boutonRangee1.showsTouchWhenHighlighted = NO;
    boutonRangee1.tag = 1;
	
	[self.view addSubview:boutonRangee1];
    /*----- INFOS -----*/
    /*----- MODIFIER -----*/
    UIButton *modifierRangee1 = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[modifierRangee1 setFrame:CGRectMake(520, 185, 180, 90)];
	[modifierRangee1 setUserInteractionEnabled:YES];
	[modifierRangee1 addTarget:self action:@selector(buttonModifierPushed:) 
            forControlEvents:UIControlEventTouchUpInside];
    
    image = [UIImage imageNamed:@"bouton-modifier.png"];
	[modifierRangee1 setImage:image forState:UIControlStateNormal];
    
    modifierRangee1.showsTouchWhenHighlighted = NO;
    modifierRangee1.tag = 11;
	
	[self.view addSubview:modifierRangee1];
    /*----- MODIFIER -----*/
    /*----- SUPPRIMER -----*/
    UIButton *supprimerRangee1 = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[supprimerRangee1 setFrame:CGRectMake(520, 280, 180, 90)];
	[supprimerRangee1 setUserInteractionEnabled:YES];
	[supprimerRangee1 addTarget:self action:@selector(buttonSupprimerPushed:) 
              forControlEvents:UIControlEventTouchUpInside];
    
    image = [UIImage imageNamed:@"bouton-supprimer.png"];
	[supprimerRangee1 setImage:image forState:UIControlStateNormal];
    
    supprimerRangee1.showsTouchWhenHighlighted = NO;
    supprimerRangee1.tag = 21;
	
	[self.view addSubview:supprimerRangee1];
    /*----- SUPPRIMER -----*/
    /*---- 1ERE RANGEE ----*/
    /*---- 2EME RANGEE ----*/
    /*----- INFOS -----*/
    UIButton *boutonRangee2 = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[boutonRangee2 setFrame:CGRectMake(50, 300, w, h)];
	[boutonRangee2 setUserInteractionEnabled:YES];
	[boutonRangee2 addTarget:self action:@selector(buttonInfosPushed:) 
            forControlEvents:UIControlEventTouchUpInside];
    
    image = [UIImage imageNamed:@"espace-informations.png"];
	[boutonRangee2 setImage:image forState:UIControlStateNormal];
    
    boutonRangee2.showsTouchWhenHighlighted = NO;
    boutonRangee2.tag = 2;
	
	[self.view addSubview:boutonRangee2];
    /*----- INFOS -----*/
    /*----- MODIFIER -----*/
    UIButton *modifierRangee2 = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[modifierRangee2 setFrame:CGRectMake(520, 405, 180, 90)];
	[modifierRangee2 setUserInteractionEnabled:YES];
	[modifierRangee2 addTarget:self action:@selector(buttonModifierPushed:) 
              forControlEvents:UIControlEventTouchUpInside];
    
    image = [UIImage imageNamed:@"bouton-modifier.png"];
	[modifierRangee2 setImage:image forState:UIControlStateNormal];
    
    modifierRangee2.showsTouchWhenHighlighted = NO;
    modifierRangee2.tag = 12;
	
	[self.view addSubview:modifierRangee2];
    /*----- MODIFIER -----*/
    /*----- SUPPRIMER -----*/
    UIButton *supprimerRangee2 = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[supprimerRangee2 setFrame:CGRectMake(520, 505, 180, 90)];
	[supprimerRangee2 setUserInteractionEnabled:YES];
	[supprimerRangee2 addTarget:self action:@selector(buttonSupprimerPushed:) 
               forControlEvents:UIControlEventTouchUpInside];
    
    image = [UIImage imageNamed:@"bouton-supprimer.png"];
	[supprimerRangee2 setImage:image forState:UIControlStateNormal];
    
    supprimerRangee2.showsTouchWhenHighlighted = NO;
    supprimerRangee2.tag = 22;
	
	[self.view addSubview:supprimerRangee2];
    /*----- SUPPRIMER -----*/
    /*---- 2EME RANGEE ----*/
    /*---- 3EME RANGEE ----*/
    /*----- INFOS -----*/
    UIButton *boutonRangee3 = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[boutonRangee3 setFrame:CGRectMake(50, 520, w, h)];
	[boutonRangee3 setUserInteractionEnabled:YES];
	[boutonRangee3 addTarget:self action:@selector(buttonInfosPushed:) 
            forControlEvents:UIControlEventTouchUpInside];
    
    image = [UIImage imageNamed:@"espace-informations.png"];
	[boutonRangee3 setImage:image forState:UIControlStateNormal];
    
    boutonRangee3.showsTouchWhenHighlighted = NO;
    boutonRangee3.tag = 3;
	
	[self.view addSubview:boutonRangee3];
    /*----- INFOS -----*/
    /*----- MODIFIER -----*/
    UIButton *modifierRangee3 = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[modifierRangee3 setFrame:CGRectMake(520, 625, 180, 90)];
	[modifierRangee3 setUserInteractionEnabled:YES];
	[modifierRangee3 addTarget:self action:@selector(buttonModifierPushed:) 
              forControlEvents:UIControlEventTouchUpInside];
    
    image = [UIImage imageNamed:@"bouton-modifier.png"];
	[modifierRangee3 setImage:image forState:UIControlStateNormal];
    
    modifierRangee3.showsTouchWhenHighlighted = NO;
    modifierRangee3.tag = 13;
	
	[self.view addSubview:modifierRangee3];
    /*----- MODIFIER -----*/
    /*----- SUPPRIMER -----*/
    UIButton *supprimerRangee3 = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[supprimerRangee3 setFrame:CGRectMake(520, 720, 180, 90)];
	[supprimerRangee3 setUserInteractionEnabled:YES];
	[supprimerRangee3 addTarget:self action:@selector(buttonSupprimerPushed:) 
               forControlEvents:UIControlEventTouchUpInside];
    
    image = [UIImage imageNamed:@"bouton-supprimer.png"];
	[supprimerRangee3 setImage:image forState:UIControlStateNormal];
    
    supprimerRangee3.showsTouchWhenHighlighted = NO;
    supprimerRangee3.tag = 23;
	
	[self.view addSubview:supprimerRangee3];
    /*----- SUPPRIMER -----*/
    /*---- 3EME RANGEE ----*/
    /*--- BOUTONS ---*/
    
    /*--- MODELE: RETROUVER LES RECHERCHES SAUVEES ET AFFICHER DANS LES BOUTONS ---*/
    recherchesSauvees = [[NSMutableArray alloc] init];
	
    int xLabel = 0;
    int wLabel = 200;
    
    //TYPES DE BIENS
    labelType1 = [[UILabel alloc] initWithFrame:CGRectMake(xLabel, 110, wLabel, 20)];
    labelType2 = [[UILabel alloc] initWithFrame:CGRectMake(xLabel, 110, wLabel, 20)];
    labelType3 = [[UILabel alloc] initWithFrame:CGRectMake(xLabel, 110, wLabel, 20)];
    
    labelType3.backgroundColor = labelType2.backgroundColor = labelType1.backgroundColor = [UIColor clearColor];
    labelType3.text = labelType2.text = labelType1.text = @"Aucun critères";
    labelType3.textAlignment = labelType2.textAlignment = labelType1.textAlignment = UITextAlignmentCenter;
    labelType1.font = [UIFont fontWithName:@"Arial-BoldMT" size:22];
    labelType1.textColor = [UIColor colorWithRed:(51.0/255.0) green:(50.0/255.0) blue:(50.0/255.0) alpha:1.0];
    labelType3.font = labelType2.font = labelType1.font;
    labelType3.textColor = labelType2.textColor = labelType1.textColor;
    
    [boutonRangee1 addSubview:labelType1];
    [boutonRangee2 addSubview:labelType2];
    [boutonRangee3 addSubview:labelType3];
    
    //VILLES
    labelVille1 = [[UILabel alloc] initWithFrame:CGRectMake(xLabel, 130, wLabel, 20)];
    labelVille2 = [[UILabel alloc] initWithFrame:CGRectMake(xLabel, 130, wLabel, 20)];
    labelVille3 = [[UILabel alloc] initWithFrame:CGRectMake(xLabel, 130, wLabel, 20)];
    
    labelVille3.backgroundColor = labelVille2.backgroundColor = labelVille1.backgroundColor = [UIColor clearColor];
    labelVille3.text = labelVille2.text = labelVille1.text = @"";
    labelVille3.textAlignment = labelVille2.textAlignment = labelVille1.textAlignment = UITextAlignmentCenter;
    labelVille1.font = [UIFont fontWithName:@"Arial-BoldMT" size:22];
    labelVille1.textColor = [UIColor colorWithRed:(255.0/255.0) green:(247.0/255.0) blue:(205.0/255.0) alpha:1.0];
    labelVille3.font = labelVille2.font = labelVille1.font;
    labelVille3.textColor = labelVille2.textColor = labelVille1.textColor;
    
    [boutonRangee1 addSubview:labelVille1];
    [boutonRangee2 addSubview:labelVille2];
    [boutonRangee3 addSubview:labelVille3];
    
    //PRIX
    labelPrix1 = [[UILabel alloc] initWithFrame:CGRectMake(xLabel, 155, wLabel, 20)];
    labelPrix2 = [[UILabel alloc] initWithFrame:CGRectMake(xLabel, 155, wLabel, 20)];
    labelPrix3 = [[UILabel alloc] initWithFrame:CGRectMake(xLabel, 155, wLabel, 20)];
    
    labelPrix3.backgroundColor = labelPrix2.backgroundColor = labelPrix1.backgroundColor = [UIColor clearColor];
    labelPrix3.text = labelPrix2.text = labelPrix1.text = @"";
    labelPrix3.textAlignment = labelPrix2.textAlignment = labelPrix1.textAlignment = UITextAlignmentCenter;
    labelPrix1.font = [UIFont fontWithName:@"Arial" size:16];
    labelPrix1.textColor = [UIColor colorWithRed:(42.0/255.0) green:(42.0/255.0) blue:(42.0/255.0) alpha:1.0];
    labelPrix3.font = labelPrix2.font = labelPrix1.font;
    labelPrix3.textColor = labelPrix2.textColor = labelPrix1.textColor;
    
    [boutonRangee1 addSubview:labelPrix1];
    [boutonRangee2 addSubview:labelPrix2];
    [boutonRangee3 addSubview:labelPrix3];
    
    //SURFACES
    labelSurface1 = [[UILabel alloc] initWithFrame:CGRectMake(xLabel, 175, wLabel, 20)];
    labelSurface2 = [[UILabel alloc] initWithFrame:CGRectMake(xLabel, 175, wLabel, 20)];
    labelSurface3 = [[UILabel alloc] initWithFrame:CGRectMake(xLabel, 175, wLabel, 20)];
    
    labelSurface3.backgroundColor = labelSurface2.backgroundColor = labelSurface1.backgroundColor = [UIColor clearColor];
    labelSurface3.text = labelSurface2.text = labelSurface1.text = @"";
    labelSurface3.textAlignment = labelSurface2.textAlignment = labelSurface1.textAlignment = UITextAlignmentCenter;
    labelSurface1.font = [UIFont fontWithName:@"Arial" size:16];
    labelSurface1.textColor = [UIColor colorWithRed:(42.0/255.0) green:(42.0/255.0) blue:(42.0/255.0) alpha:1.0];
    labelSurface3.font = labelSurface2.font = labelSurface1.font;
    labelSurface3.textColor = labelSurface2.textColor = labelSurface1.textColor;
    
    [boutonRangee1 addSubview:labelSurface1];
    [boutonRangee2 addSubview:labelSurface2];
    [boutonRangee3 addSubview:labelSurface3];
    
    //[self getRecherches];
    /*--- MODELE: RETROUVER LES RECHERCHES SAUVEES ET AFFICHER DANS LES BOUTONS ---*/
}

- (void) afficheListeAnnoncesReady:(NSNotification *)notify {
    NSLog(@"criteres2: %@", criteres2);
    NSLog(@"tableau Annonces: %@", tableauAnnonces1);
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:criteres2 copyItems:NO];
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:tableauAnnonces1 copyItems:NO];
    NSArray *criteresEtAnnonces = [NSArray arrayWithObjects:dict, array, nil];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"afficheListeAnnonces" object: criteresEtAnnonces];
}

- (void) buttonInfosPushed:(id)sender
{
	UIButton *button = sender;
	switch (button.tag) {
		case 1:
            NSLog(@"Recherche 1");
            if ([recherchesSauvees objectAtIndex:0] != @"") {
                [self makeRequest:0];
            }
			break;
		case 2:
            NSLog(@"Recherche 2");
            if ([recherchesSauvees objectAtIndex:1] != @"") {
                [self makeRequest:1];
            }
            break;
        case 3:
            NSLog(@"Recherche 3");
            if ([recherchesSauvees objectAtIndex:2] != @"") {
                [self makeRequest:2];
            }
            break;
        default:
			break;
	}
}

- (void)makeRequest:(int)num{
    whichView = @"favoris";
    NSMutableDictionary *criteres1 = [recherchesSauvees objectAtIndex:num];
    
    NSString *bodyString = @"http://paris-demeures.com/iphone.asp?";
    
    NSEnumerator *enume;
    NSString *key;
    
    enume = [criteres1 keyEnumerator];
    BOOL isFirstObject = YES;
    NSString *esperluette = @"";
    
    [criteres2 removeAllObjects];
    
    while((key = [enume nextObject])) {
        if ([criteres1 objectForKey:key] != @"") {
            if (!isFirstObject) {
                esperluette = @"&";
            }
            else{
                isFirstObject = NO;
            }
            bodyString = [bodyString stringByAppendingFormat:@"%@%@=%@",esperluette, key, [criteres1 valueForKey:key]];
            bodyString = [bodyString stringByAddingPercentEscapesUsingEncoding:NSISOLatin1StringEncoding];
            [criteres2 setObject:[criteres1 objectForKey:key] forKey:key];
        }
    }
    
    NSLog(@"bodyString:%@\n",bodyString);
    
    ASIHTTPRequest *request = [[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:bodyString]] autorelease];
    [request setUserInfo:[NSDictionary dictionaryWithObject:[NSString stringWithString:@"recherche multicriteres"] forKey:@"name"]];
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
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Aucun bien trouvé"
                                                            message:[error localizedDescription]
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            [alert release];
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
            
            /*NSMutableDictionary *tempDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                   @"", @"transaction",
                                                   @"", @"ville1",
                                                   @"", @"ville2",
                                                   @"", @"ville3",
                                                   @"", @"cp1",
                                                   @"", @"cp2",
                                                   @"", @"cp3",
                                                   @"", @"types",
                                                   @"", @"nb_pieces_mini",
                                                   @"", @"nb_pieces_maxi",
                                                   @"", @"prix_mini",
                                                   @"", @"prix_maxi",
                                                   @"", @"surface_mini",
                                                   @"", @"surface_maxi",
                                                   nil];*/
            
            /*[criteres2 setDictionary:tempDictionary];
             
             NSEnumerator *enume;
             NSString *key;
             
             enume = [criteres1 keyEnumerator];
             
             while((key = [enume nextObject])) {
             if ([criteres1 objectForKey:key] != @"") {
             NSString *value = [criteres1 valueForKey:key];
             [criteres2 setValue:value forKey:key];
             }
             }*/
            
            //[self sauvegardeRecherches];
            
            //[criteres1 setDictionary:tempDictionary];
            
            AfficheListeAnnoncesController2 *afficheListeAnnoncesController = 
            [[AfficheListeAnnoncesController2 alloc] init];
            //afficheListeAnnoncesController.title = @"Annonces";
            [self.navigationController pushViewController:afficheListeAnnoncesController animated:YES];
            [afficheListeAnnoncesController release];
            
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
}

- (void) buttonModifierPushed:(id)sender
{
	UIButton *button = sender;
    //RootViewController *rechercheMultiCriteres;
    
	switch (button.tag) {
		case 11:
            NSLog(@"Mod Recherche 1");
            whichView = @"favoris_modifier";
            [self.navigationController pushViewController:rechercheMulti animated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"rechercheSauvee"
                                                                object:[recherchesSauvees objectAtIndex:0]];
			break;
		case 12:
            NSLog(@"Mod Recherche 2");
            whichView = @"favoris_modifier";
            [self.navigationController pushViewController:rechercheMulti animated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"rechercheSauvee"
                                                                object:[recherchesSauvees objectAtIndex:1]];
            break;
        case 13:
            NSLog(@"Mod Recherche 3");
            whichView = @"favoris_modifier";
            [self.navigationController pushViewController:rechercheMulti animated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"rechercheSauvee"
                                                                object:[recherchesSauvees objectAtIndex:2]];
            break;
        default:
			break;
	}
}

- (void) buttonSupprimerPushed:(id)sender
{
	UIButton *button = sender;
	switch (button.tag) {
		case 21:
            [self effaceRecherche:1];
            break;
		case 22:
            [self effaceRecherche:2];
            break;
        case 23:
            [self effaceRecherche:3];
            break;
        default:
			break;
	}
}

- (void) effaceRecherche:(int)num{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *directory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    [fileManager removeItemAtPath:
     [directory stringByAppendingPathComponent:[NSString stringWithFormat:@"%d.plist",num]]
                            error:NULL];

    switch (num) {
        case 1:
            labelType1.text = @"Aucun critères";
            labelVille1.text = @"";
            labelSurface1.text = @"";
            labelPrix1.text = @"";
            break;
        case 2:
            labelType2.text = @"Aucun critères";
            labelVille2.text = @"";
            labelSurface2.text = @"";
            labelPrix2.text = @"";
            break;
        case 3:
            labelType3.text = @"Aucun critères";
            labelVille3.text = @"";
            labelSurface3.text = @"";
            labelPrix3.text = @"";
            break;
        default:
            break;
    }
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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

- (void) getRecherches{
    [recherchesSauvees removeAllObjects];
    NSString *directory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
	NSMutableDictionary *recherche;
    
    noRecherche = YES;
    int i = 0;
	for (i = 0; i < 3; i++) {
		[recherchesSauvees addObject:@""];
		
		recherche = [NSMutableDictionary dictionaryWithContentsOfFile:
					 [directory stringByAppendingPathComponent:
					  [NSString stringWithFormat:@"%d.plist",i+1]]];
		
		if (recherche != nil) {
            noRecherche = NO;
			[recherchesSauvees replaceObjectAtIndex:i withObject:recherche];
		}
		
	}
    if (noRecherche == NO) {
        i = 0;
        for (i = 0; i < 3; i++) {
            @try{
                recherche = [recherchesSauvees objectAtIndex:i];
            }
            @catch(NSException* ex){
                break;
            }
            NSLog(@"recherche%d: %@", i, recherche);
            
            if (recherche != @"") {
                NSString *typesInt = [recherche objectForKey:@"types"];
                
                NSArray *types = [typesInt componentsSeparatedByString:@","];
                NSString *typeString = @"";
                
                for (NSString *type in types) {
                    if (type != @"") {
                        
                        switch ([type intValue]) {
                            case 0:
                                typeString = [typeString stringByAppendingString:@"Appartement "];
                                break;
                            case 1:
                                typeString = [typeString stringByAppendingString:@"Maison "];
                                break;
                            case 2:
                                typeString = [typeString stringByAppendingString:@"Terrain "];
                                break;
                            case 3:
                                typeString = [typeString stringByAppendingString:@"Bureau "];
                                break;
                            case 4:
                                typeString = [typeString stringByAppendingString:@"Commerce "];
                                break;
                            case 5:
                                typeString = [typeString stringByAppendingString:@"Immeuble "];
                                break;
                            case 6:
                                typeString = [typeString stringByAppendingString:@"Parking "];
                                break;
                            case 7:
                                typeString = [typeString stringByAppendingString:@"Autre "];
                                break;
                            default:
                                break;
                        }
                    }
                }
                
                switch (i) {
                    case 0:
                        labelType1.text = typeString;
                        break;
                    case 1:
                        labelType2.text = typeString;
                        break;
                    case 2:
                        labelType3.text = typeString;
                        break;
                    default:
                        break;
                }
                
                NSString *ville = [recherche objectForKey:@"ville1"];
                
                switch (i) {
                    case 0:
                        labelVille1.text = ville;
                        break;
                    case 1:
                        labelVille2.text = ville;
                        break;
                    case 2:
                        labelVille3.text = ville;
                        break;
                    default:
                        break;
                }
                
                NSString *prix_mini = [recherche objectForKey:@"prix_mini"];
                NSString *prix_maxi = [recherche objectForKey:@"prix_maxi"];
                NSString *prix = @"";
                NSLog(@"prix_mini: %@",prix_mini);
                
                if (prix_mini != nil && prix_maxi != nil) {
                    NSNumber *formattedResult;
                    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                    [formatter setGroupingSeparator:@" "];
                    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
                    
                    formattedResult = [NSNumber numberWithInt:[prix_mini intValue]];
                    prix_mini = [formatter stringForObjectValue:formattedResult];
                    
                    formattedResult = [NSNumber numberWithInt:[prix_maxi intValue]];
                    prix_maxi = [formatter stringForObjectValue:formattedResult];
                    //
                    prix = [NSString stringWithFormat:@"de %@€ à %@€", prix_mini, prix_maxi];
                }
                
                if (prix_mini != nil && prix_maxi == nil) {
                    NSNumber *formattedResult;
                    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                    [formatter setGroupingSeparator:@" "];
                    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
                    
                    formattedResult = [NSNumber numberWithInt:[prix_mini intValue]];
                    prix_mini = [formatter stringForObjectValue:formattedResult];
                    
                    prix = [NSString stringWithFormat:@"à partir de %@€", prix_mini];
                }
                
                if (prix_mini == nil && prix_maxi != nil) {
                    NSNumber *formattedResult;
                    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                    [formatter setGroupingSeparator:@" "];
                    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
                    
                    formattedResult = [NSNumber numberWithInt:[prix_maxi intValue]];
                    prix_maxi = [formatter stringForObjectValue:formattedResult];
                    
                    prix = [NSString stringWithFormat:@"jusqu'à %@€", prix_maxi];
                }
                
                switch (i) {
                    case 0:
                        labelPrix1.text = prix;
                        break;
                    case 1:
                        labelPrix2.text = prix;
                        break;
                    case 2:
                        labelPrix3.text = prix;
                        break;
                    default:
                        break;
                }
                
                NSString *surface_mini = [recherche objectForKey:@"surface_mini"];
                NSString *surface_maxi = [recherche objectForKey:@"surface_maxi"];
                NSString *surface = @"";
                
                if (surface_mini != nil && surface_maxi != nil) {
                    NSNumber *formattedResult;
                    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                    [formatter setGroupingSeparator:@" "];
                    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
                    
                    formattedResult = [NSNumber numberWithInt:[surface_mini intValue]];
                    surface_mini = [formatter stringForObjectValue:formattedResult];
                    
                    formattedResult = [NSNumber numberWithInt:[surface_maxi intValue]];
                    surface_maxi = [formatter stringForObjectValue:formattedResult];
                    //€
                    surface = [NSString stringWithFormat:@"de %@m² à %@m²", surface_mini, surface_maxi];
                }
                
                if (surface_mini != nil && surface_maxi == nil) {
                    NSNumber *formattedResult;
                    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                    [formatter setGroupingSeparator:@" "];
                    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
                    
                    formattedResult = [NSNumber numberWithInt:[surface_mini intValue]];
                    surface_mini = [formatter stringForObjectValue:formattedResult];
                    
                    surface = [NSString stringWithFormat:@"à partir de %@m²", surface_mini];
                }
                
                if (surface_mini == nil && surface_maxi != nil) {
                    NSNumber *formattedResult;
                    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                    [formatter setGroupingSeparator:@" "];
                    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
                    
                    formattedResult = [NSNumber numberWithInt:[surface_maxi intValue]];
                    surface_maxi = [formatter stringForObjectValue:formattedResult];
                    
                    surface = [NSString stringWithFormat:@"jusqu'à %@m²", surface_maxi];
                }
                
                switch (i) {
                    case 0:
                        labelSurface1.text = surface;
                        break;
                    case 1:
                        labelSurface2.text = surface;
                        break;
                    case 2:
                        labelSurface3.text = surface;
                        break;
                    default:
                        break;
                }
                
            }
        }
    }
}

- (void) viewWillAppear:(BOOL)animated{
    [self getRecherches];
}

- (void)dealloc {
    [recherchesSauvees release];
    [labelType1 release];
    [labelType2 release];
    [labelType3 release];
    
    [labelVille1 release];
    [labelVille2 release];
    [labelVille3 release];
    
    [labelPrix1 release];
    [labelPrix2 release];
    [labelPrix3 release];
    
    [labelSurface1 release];
    [labelSurface2 release];
    [labelSurface3 release];
    
    [rechercheMulti release];
    [tableauAnnonces1 release];
    [criteres2 release];
    
    [super dealloc];
}


@end
