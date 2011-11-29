//
//  Utility.m
//  Paris_Demeures_Ipad
//
//  Created by Christophe Bergé on 24/07/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Utility.h"


@implementation Utility

- (UITabBarItem *)getItem:(NSString *)itemTitle imagePath:(NSString *)imagePath tag:(NSInteger)tag{
	NSString *imageCompletePath = [[[NSBundle mainBundle] resourcePath]  stringByAppendingString:imagePath];
	UIImage *image = [[UIImage alloc] initWithContentsOfFile:imageCompletePath];
	UITabBarItem *barItem = [[UITabBarItem alloc] initWithTitle:itemTitle image:image tag:tag];
	
	
	return barItem;
	[barItem release];
	[image release];
}

-(NSMutableArray *)httpRequestForSmallAdds:(NSMutableDictionary *)postValues{
	//1. RASSEMBLER LES CRITERES DE RECHERCHE ET LES ENVOYER DANS UNE REQUETE HTTP
	//PAR LA METHODE POST
	//2. DECODER LA REPONSE
	
    /*--- TABLEAU POUR LES CODES RETOUR ET ERREURS ---*/
    /* CODES RETOUR: 
     0 : OK
     1 : ERREUR DE CONNECTION RESEAU
     2 : AUCUN BIEN CORRESPONDANT AUX CRITERES TROUVE SUR LE SERVEUR WEB
    */
    NSMutableArray *retour = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil];
    
    /*NSMutableDictionary *postValuesTest = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                           @"0", @"transaction",
                                           @"5", @"nb_pieces_mini",
                                           @"6", @"nb_pieces_maxi",
                                           @"109", @"surface_maxi",
                                           @"92200", @"cp1",
                                           @"Neuilly sur Seine", @"ville1",
                                           @"1500000", @"prix_maxi",
                                           nil];
    postValues = postValuesTest;*/
	NSLog(@"postValues: %@",postValues);
	
	//N'ENVOYER QUE LES VARIABLES NON VIDES
	NSString *bodyString = @"";
    
	NSEnumerator *enume;
	NSString *key;
	
	enume = [postValues keyEnumerator];
    BOOL isFirstObject = YES;
    NSString *esperluette = @"http://paris-demeures.com/iphone.asp?";
    
	while((key = [enume nextObject])) {
        if (!isFirstObject) {
            esperluette = @"&";
        }
        else{
            isFirstObject = NO;
        }
		if ([postValues objectForKey:key] != @"") {
			bodyString = [bodyString stringByAppendingFormat:@"%@%@=%@",esperluette, key, [postValues valueForKey:key]];
            bodyString = [bodyString stringByAddingPercentEscapesUsingEncoding:NSISOLatin1StringEncoding];
		}
    }	
	
    NSLog(@"bodyString:%@\n",bodyString);
    
    NSHTTPURLResponse   * response;
    NSError             * error = nil;
    NSMutableURLRequest * request;
    
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
	request = [[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:bodyString]] autorelease];
	[request setHTTPMethod:@"GET"];
    
	NSData * dataBrute = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSLog(@"dataBrute long: %d",[dataBrute length]);
    
    NSString * string = [[NSString alloc] initWithData:dataBrute encoding:NSISOLatin1StringEncoding];
    //NSLog(@"REPONSE DU WEB: \"%@\"\n",string);
    
    if ([string length] > 0) {
        
        NSUInteger zap = 60;
        
        NSData *dataString = [string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        
        NSData *data = [[NSData alloc] initWithData:[dataString subdataWithRange:NSMakeRange(59, [dataString length] - zap)]];
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        //[string release];
        
        //TESTER ERREUR DE CONNECTION
        //LA LIGNE SUIVANTE EST LE VRAI TEST. A REMETTRE QUAND LES ESSAIS EN LIVE AURONT LIEU
        if (error != nil) {
            //if (error == nil) {
            
            [retour replaceObjectAtIndex:0 withObject:[NSNumber numberWithInt:1]];
            [retour replaceObjectAtIndex:1 withObject:error];
            
            NSLog(@"ERREUR CONNEXION HTTP: \n%@", [error localizedDescription]);
            NSLog(@"RESPONSE HEADERS: \n%@", [response allHeaderFields]);
            NSLog(@"DATA: \n%@", string);
            
            return retour;
        }
        else {
            //ON PARSE DU XML
            
            /*--- POUR LE TEST OFF LINE ---
             NSFileManager *fileManager = [NSFileManager defaultManager];
             NSString *xmlSamplePath = [[NSBundle mainBundle] pathForResource:@"Biens" ofType:@"xml"];
             data = [fileManager contentsAtPath:xmlSamplePath];
             string = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
             NSLog(@"REPONSE DU WEB: %@\n",string);
             [string release];*/
             /*--- ---*/
            
            if ([string rangeOfString:@"<biens></biens>"].length != 0) {
                //AUCUNE ANNONCES
                [retour replaceObjectAtIndex:0 withObject:[NSNumber numberWithInt:2]];
                
                NSDictionary *userInfo = [NSDictionary 
                                          dictionaryWithObject:@"Aucun bien ne correspond à ces critères dans notre base de données."
                                          forKey:NSLocalizedDescriptionKey];
                
                error =[NSError errorWithDomain:@"Aucun bien trouvé."
                                           code:1 userInfo:userInfo];
                [retour replaceObjectAtIndex:1 withObject:error];
                
                return retour;
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
                
                NSLog(@"retour: %@",retour);
                return retour;
            }
            [string release];
        }
    }
    else{
        [retour replaceObjectAtIndex:0 withObject:[NSNumber numberWithInt:1]];
        
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"Le serveur paris-demeures.com ne répond pas."
                                                             forKey:NSLocalizedDescriptionKey];
        
        error =[NSError errorWithDomain:@"Pas de réponse du serveur paris-demeures.com"
                                   code:1 userInfo:userInfo];
        
        [retour replaceObjectAtIndex:1 withObject:error];
        
        return retour;
    }
		
}

@end
