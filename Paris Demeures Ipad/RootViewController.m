//
//  RootViewController.m
//  Paris_Demeures_Ipad
//
//  Created by Christophe Bergé on 16/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"


@implementation RootViewController

@synthesize tableauCommunes, tableauAnnonces1, criteres1, criteres2;

- (void)viewDidLoad {
    /*--- STOCKAGE DES ANNONCES ET CRITERES DE RECHERCHE ---*/
	criteres1 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
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
				nil];
    
    criteres2 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
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
                 nil];
    
	tableauAnnonces1 = [[NSMutableArray alloc] init];
    tableauCommunes = [[NSMutableArray alloc] init];
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(citiesSelected:) name:@"citiesSelected" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(citySelected:) name:@"citySelected" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(typesSelected:) name:@"typesSelected" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(surfaceSelected:) name:@"surfaceSelected" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(nbPiecesSelected:) name:@"nbPiecesSelected" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(budgetSelected:) name:@"budgetSelected" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(afficheListeAnnoncesReady:) name:@"afficheListeAnnoncesReady" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(rechercheSauvee:) name:@"rechercheSauvee" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(getCriteres:) name:@"getCriteres" object: nil];
    
    isConnectionErrorPrinted = NO;
    
    /*--- QUEUE POUR LES REQUETES HTTP ---*/
    networkQueue = [[ASINetworkQueue alloc] init];
    [networkQueue reset];
	[networkQueue setRequestDidFinishSelector:@selector(requestDone:)];
	[networkQueue setRequestDidFailSelector:@selector(requestFailed:)];
	[networkQueue setDelegate:self];
    /*--- QUEUE POUR LES REQUETES HTTP ---*/
    
    /*--- STOCKAGE DES ANNONCES ET CRITERES DE RECHERCHE ---*/
    
    /*--- INTERFACE GRAPHIQUE ---*/
	self.view = [[UIView alloc] initWithFrame:CGRectMake(0,0,768,1024)];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
    
    UIImageView *enTete = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.png"]];
    [enTete setFrame:CGRectMake(0,0,768,80)];
    [self.view addSubview:enTete];
    
    [enTete release];
    
    /*UIImageView *sousEnTete = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"recherche-multi-bandeau-sous-header.png"]];
    [sousEnTete setFrame:CGRectMake(0,50,320,50)];
    [self.view addSubview:sousEnTete];*/
    
    /*--- BOUTONS ---*/
    int xPos = 110;
    int yPos = 150;
    int yDecalage = 120;
    int xSize = 550;
    int ySize = 100;
    
    //BOUTON RETOUR
    UIButton *boutonRetour = [UIButton buttonWithType:UIButtonTypeCustom];
    boutonRetour.showsTouchWhenHighlighted = NO;
    boutonRetour.tag = 6;
    
    [boutonRetour setFrame:CGRectMake(20,12,100,60)];
    [boutonRetour addTarget:self action:@selector(buttonPushed:)
           forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *image = [UIImage imageNamed:@"bouton-retour2.png"];
    [boutonRetour setImage:image forState:UIControlStateNormal];
    
    [self.view addSubview:boutonRetour];
    
    //BOUTON VILLE
    UIButton *boutonVille = [UIButton buttonWithType:UIButtonTypeCustom];
    boutonVille.tag = 0;
    boutonVille.showsTouchWhenHighlighted = NO;
    
    [boutonVille setFrame:CGRectMake(xPos,yPos,xSize,ySize)];
    [boutonVille addTarget:self action:@selector(buttonPushed:) 
              forControlEvents:UIControlEventTouchUpInside];
    
    image = [self getImage:@"ville-departement-etc"];
	[boutonVille setImage:image forState:UIControlStateNormal];
    
    [self.view addSubview:boutonVille];
    
    //BOUTON TYPE DE BIEN
    UIButton *boutonTypeBien = [UIButton buttonWithType:UIButtonTypeCustom];
    boutonTypeBien.tag = 1;
    boutonTypeBien.showsTouchWhenHighlighted = NO;
    
    [boutonTypeBien setFrame:CGRectMake(xPos,yPos + yDecalage,xSize,ySize)];
    [boutonTypeBien addTarget:self action:@selector(buttonPushed:) 
          forControlEvents:UIControlEventTouchUpInside];
    
    image = [self getImage:@"type-de-biens"];
	[boutonTypeBien setImage:image forState:UIControlStateNormal];
    
    [self.view addSubview:boutonTypeBien];
    
    //BOUTON SURFACE
    UIButton *boutonSurface = [UIButton buttonWithType:UIButtonTypeCustom];
    boutonSurface.tag = 2;
    boutonSurface.showsTouchWhenHighlighted = NO;
    
    [boutonSurface setFrame:CGRectMake(xPos,yPos + (yDecalage * 2),xSize,ySize)];
    [boutonSurface addTarget:self action:@selector(buttonPushed:) 
             forControlEvents:UIControlEventTouchUpInside];
    
    image = [self getImage:@"surface"];
	[boutonSurface setImage:image forState:UIControlStateNormal];
    
    [self.view addSubview:boutonSurface];
    
    //BOUTON NB PIECE
    UIButton *boutonNbPiece = [UIButton buttonWithType:UIButtonTypeCustom];
    boutonNbPiece.tag = 3;
    boutonNbPiece.showsTouchWhenHighlighted = NO;
    
    [boutonNbPiece setFrame:CGRectMake(xPos,yPos + (yDecalage * 3),xSize,ySize)];
    [boutonNbPiece addTarget:self action:@selector(buttonPushed:) 
            forControlEvents:UIControlEventTouchUpInside];
    
    image = [self getImage:@"nombre-de-pieces"];
	[boutonNbPiece setImage:image forState:UIControlStateNormal];
    
    [self.view addSubview:boutonNbPiece];
    
    //BOUTON BUDGET
    UIButton *boutonBudget = [UIButton buttonWithType:UIButtonTypeCustom];
    boutonBudget.tag = 4;
    boutonBudget.showsTouchWhenHighlighted = NO;
    
    [boutonBudget setFrame:CGRectMake(xPos,yPos + (yDecalage * 4),xSize,ySize)];
    [boutonBudget addTarget:self action:@selector(buttonPushed:) 
            forControlEvents:UIControlEventTouchUpInside];
    
    image = [self getImage:@"budget"];
	[boutonBudget setImage:image forState:UIControlStateNormal];
    
    [self.view addSubview:boutonBudget];
    
    //BOUTON RECHERCHE
    UIButton *boutonRecherche = [UIButton buttonWithType:UIButtonTypeCustom];
    boutonRecherche.tag = 5;
    boutonRecherche.showsTouchWhenHighlighted = NO;
    
    [boutonRecherche setFrame:CGRectMake(xPos,yPos + (yDecalage * 5),xSize,ySize)];
    [boutonRecherche addTarget:self action:@selector(buttonPushed:) 
            forControlEvents:UIControlEventTouchUpInside];
    
    image = [self getImage:@"rechercher"];
	[boutonRecherche setImage:image forState:UIControlStateNormal];
    
    [self.view addSubview:boutonRecherche];
    /*--- INTERFACE GRAPHIQUE ---*/
    
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
        case 0:
            NSLog(@"Ville");
            ChoixVilleController2 *choixVille = [[ChoixVilleController2 alloc] init];
            [self.navigationController pushViewController:choixVille animated:YES];
            [choixVille release];
            choixVille = nil;
            break;
		case 1:
            NSLog(@"Type de bien");
            SelectionTypeBienController *selectionTypeBienController =
			[[SelectionTypeBienController alloc] initWithStyle:UITableViewStylePlain];
            selectionTypeBienController.title = @"Type de bien";
            [self.navigationController pushViewController:selectionTypeBienController animated:YES];
            [selectionTypeBienController release];
            selectionTypeBienController = nil;
			break;
		case 2:
            NSLog(@"Surface");
            SelectionSurfaceController *selectionSurfaceController =
            [[SelectionSurfaceController alloc] initWithNibName:@"SelectionSurfaceController" bundle:nil];
            selectionSurfaceController.title = @"Surface";
            [self.navigationController pushViewController:selectionSurfaceController animated:YES];
            [selectionSurfaceController release];
            selectionSurfaceController = nil;
            break;
        case 3:
            NSLog(@"Nombre de pieces");
            SelectionNbPiecesController *selectionNbPiecesController =
			[[SelectionNbPiecesController alloc] initWithNibName:@"SelectionNbPiecesController" bundle:nil];
            selectionNbPiecesController.title = @"Nombre de pieces";
            [self.navigationController pushViewController:selectionNbPiecesController animated:YES];
            [selectionNbPiecesController release];
            selectionNbPiecesController = nil;
            break;
        case 4:
            NSLog(@"Budget");
            SelectionBudgetController *selectionBudgetController =
            [[SelectionBudgetController alloc] initWithNibName:@"SelectionBudgetController" bundle:nil];
            selectionBudgetController.title = @"Budget";
            [self.navigationController pushViewController:selectionBudgetController animated:YES];
            [selectionBudgetController release];
            selectionBudgetController = nil;
            break;
        case 5:
            NSLog(@"Lancer la recherche");
            if ([criteres1 valueForKey:@"ville1"] == @"") {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Veuillez choisir au moins une ville."
                                                                message:nil
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
                [alert release];
                
            }
            else {
                
                //ENVOYER LA REQUETE ET AFFICHER LES RESULTATS
                isConnectionErrorPrinted = NO;
                [tableauAnnonces1 removeAllObjects];
                [self makeRequest];
                
            }
            break;
        case 6:
            [self.navigationController popViewControllerAnimated:YES];
            break;
		default:
			break;
	}
}

- (void)makeRequest{
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
            //NSLog(@"ici criteres2: %@",criteres2);
        }
    }

    NSLog(@"bodyString:%@\n",bodyString);

    ASIHTTPRequest *request = [[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:bodyString]] autorelease];
    [request setUserInfo:[NSDictionary dictionaryWithObject:[NSString stringWithString:@"recherche multicriteres"] forKey:@"name"]];
    //[networkQueue reset];
    [networkQueue addOperation:request];

    [networkQueue go];
}

- (void) getCriteres:(NSNotification *)notify {
    NSLog(@"criteres1 getCrit: %@",criteres1);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"setCriteres" object: criteres1];
}

- (void) rechercheSauvee:(NSNotification *)notify {
    criteres1 = [notify object];
    NSLog(@"criteres1 rechSauv: %@",criteres1);
}

- (void) citySelected:(NSNotification *)notify {
	NSMutableArray *array = [notify object];
    
    if ([array count] != 0) {
        
        [criteres1 setValue:[array objectAtIndex:0] forKey:@"ville1"];
        [criteres1 setValue:[array objectAtIndex:1] forKey:@"cp1"];
    
    }
	NSLog(@"criteres1: %@",criteres1);
}

- (void) typesSelected:(NSNotification *)notify {
	NSMutableArray *typesSelected = [notify object];
    
	NSString *types = @"";
	
	NSUInteger nbTypes = [typesSelected count];
	
	for (int i = 0; i < nbTypes; i++) {
        NSIndexPath *indexPath = [typesSelected objectAtIndex:i];
        NSString *string = [NSString stringWithFormat:@"%d", indexPath.row];
		types = [types stringByAppendingString:string];
		
		if (i < (nbTypes - 1)) {
            types = [types stringByAppendingString:@","];
        }
        
	}
	
	[criteres1 setValue:types forKey:@"types"];
    NSLog(@"criteres1: %@",criteres1);
}

- (void) surfaceSelected:(NSNotification *)notify {
	Intervalle *intervalle = [notify object];
	int min = [intervalle min];
	int max = [intervalle max];
	
	if ((min != 0) && (max != 0)) {
		[criteres1 setValue:[@"" stringByAppendingFormat:@"%d",min] forKey:@"surface_mini"];
		[criteres1 setValue:[@"" stringByAppendingFormat:@"%d",max] forKey:@"surface_maxi"];
	}
    
    if ((min != 0) && (max == 0)) {
		[criteres1 setValue:[@"" stringByAppendingFormat:@"%d",min] forKey:@"surface_mini"];
	}
    
    if ((min == 0) && (max != 0)) {
		[criteres1 setValue:[@"" stringByAppendingFormat:@"%d",max] forKey:@"surface_maxi"];
	}
    NSLog(@"criteres1: %@",criteres1);
}

- (void) nbPiecesSelected:(NSNotification *)notify {
	NSMutableArray *nbPiecesSelectedIndexPath = [notify object];
    NSMutableArray *nbPiecesSelectedString = [[NSMutableArray alloc] init];
    
    NSIndexPath *indexPath;
    
    for (indexPath in nbPiecesSelectedIndexPath) {
        NSString *string = [NSString stringWithFormat:@"%d",(indexPath.row + 1)];
        [nbPiecesSelectedString addObject:string];
    }
    
	[nbPiecesSelectedString sortUsingSelector:@selector(caseInsensitiveCompare:)];
    
    if ([nbPiecesSelectedString count] > 0) {
    
        if ([nbPiecesSelectedString count] == 1) {
            if ([[nbPiecesSelectedString objectAtIndex:0] isEqualToString:@"7"]) {
                [criteres1 setValue:@"7" forKey:@"nb_pieces_mini"];
            }
            else{
                [criteres1 setValue:[nbPiecesSelectedString objectAtIndex:0] forKey:@"nb_pieces_mini"];
                int nb_pieces_maxi = [[nbPiecesSelectedString objectAtIndex:0] intValue] + 1;
                [criteres1 setValue:[NSString stringWithFormat:@"%d",nb_pieces_maxi] forKey:@"nb_pieces_maxi"];
            }
        }
        else{
            [criteres1 setValue:[nbPiecesSelectedString objectAtIndex:0] forKey:@"nb_pieces_mini"];
            if (![[nbPiecesSelectedString lastObject] isEqualToString:@"7"]) {
                [criteres1 setValue:[nbPiecesSelectedString lastObject] forKey:@"nb_pieces_maxi"];
            }
        }
    }
    
    NSLog(@"criteres1%@",criteres1);
}

- (void) budgetSelected:(NSNotification *)notify {
	Intervalle *intervalle = [notify object];
	int min = [intervalle min];
	int max = [intervalle max];
	
	if ((min != 0) && (max != 0)) {
		[criteres1 setValue:[@"" stringByAppendingFormat:@"%d",min] forKey:@"prix_mini"];
		[criteres1 setValue:[@"" stringByAppendingFormat:@"%d",max] forKey:@"prix_maxi"];
	}
    
    if ((min != 0) && (max == 0)) {
		[criteres1 setValue:[@"" stringByAppendingFormat:@"%d",min] forKey:@"prix_mini"];
	}
    
    if ((min == 0) && (max != 0)) {
		[criteres1 setValue:[@"" stringByAppendingFormat:@"%d",max] forKey:@"prix_maxi"];
	}
    NSLog(@"criteres1: %@",criteres1);
}

- (void) afficheListeAnnoncesReady:(NSNotification *)notify {
    NSLog(@"criteres2: %@", criteres2);
    NSLog(@"tableau Annonces: %@", tableauAnnonces1);
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:criteres2 copyItems:NO];
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:tableauAnnonces1 copyItems:NO];
    NSArray *criteresEtAnnonces = [NSArray arrayWithObjects:dict, array, nil];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"afficheListeAnnonces" object: criteresEtAnnonces];
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
            
            NSMutableDictionary *tempDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:
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
                                                   nil];
            
            [self sauvegardeRecherches];
            
            [criteres1 setDictionary:tempDictionary];
            
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

-(void) sauvegardeRecherches{
	int i = 0;
	NSMutableDictionary *recherche;
	NSMutableArray *recherches = [[NSMutableArray alloc] init];
	NSString *directory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
	
	for (i = 0; i < 3; i++) {
		[recherches addObject:@""];
		if ((recherche = [NSDictionary dictionaryWithContentsOfFile:
						  [directory stringByAppendingPathComponent:
						   [@"" stringByAppendingFormat:@"%d.plist",i+1]]]) != nil ) {
                              [recherches replaceObjectAtIndex:i withObject:recherche];
                          }
	}
	
	for (i = 2; i > 0; i--) {
		if ([recherches objectAtIndex:i-1] != @"") {
			[recherches replaceObjectAtIndex:i withObject:[recherches objectAtIndex:i-1]];
		}
	}
    
	/*NSMutableDictionary *criteresCopy = [NSDictionary dictionaryWithDictionary:criteres];
     NSEnumerator *enume;
     NSString *key;
     
     enume = [criteresCopy keyEnumerator];
     
     while(key = [enume nextObject]) {
     if ([criteresCopy valueForKey:key] == @"") {
     [criteres setObject:@"VIDE" forKey:key];
     }
     }*/
	
	[recherches replaceObjectAtIndex:0 withObject:criteres2];
	
	for (i = 0; i < 3; i++) {
		if ([recherches objectAtIndex:i] != @"") {
			recherche = [recherches objectAtIndex:i];
			[recherche writeToFile:[directory stringByAppendingPathComponent:
									[@"" stringByAppendingFormat:@"%d.plist",i+1]] atomically:YES];
		}
	}
	NSLog(@"recherches: %@",recherches);
    [recherche release];
    //[recherches release];
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)viewWillAppear:(BOOL)animated {
    //[criteres removeAllObjects];
    [super viewWillAppear:animated];
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
    [self.view release];
    [tableauAnnonces1 release];
    [tableauCommunes release];
	[criteres1 release];
    [criteres2 release];
    [networkQueue release];
    [super dealloc];
}


@end

