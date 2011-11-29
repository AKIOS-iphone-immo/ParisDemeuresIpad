//
//  Utility2.m
//  Paris_Demeures_Ipad
//
//  Created by Christophe Bergé on 17/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Utility2.h"


@implementation Utility2

//@synthesize retourHTTP;

-(void)httpRequestForSmallAdds:(NSMutableDictionary *)postValues{
	//1. RASSEMBLER LES CRITERES DE RECHERCHE ET LES ENVOYER DANS UNE REQUETE HTTP
	//PAR LA METHODE POST
	//2. DECODER LA REPONSE
	
    /*--- TABLEAU POUR LES CODES RETOUR ET ERREURS ---*/
    /* CODES RETOUR: 
     0 : OK
     1 : ERREUR DE CONNECTION RESEAU
     2 : AUCUN BIEN CORRESPONDANT AUX CRITERES TROUVE SUR LE SERVEUR WEB
     */
    
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
    
    NSMutableURLRequest * request;
    
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
	request = [[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:bodyString]] autorelease];
	[request setHTTPMethod:@"GET"];
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (theConnection) {
        // Create the NSMutableData that will hold
        // the received data
        // receivedData is declared as a method instance elsewhere
        receivedData=[[NSMutableData data] retain];
    } else {
        // inform the user that the download could not be made
        NSLog(@"DOWNLOAD COULD NOT BE MADE");
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    // append the new data to the receivedData
    // receivedData is declared as a method instance elsewhere
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // release the connection, and the data object
    [connection release];
    
    // receivedData is declared as a method instance elsewhere
    [receivedData release];
    
    // inform the user
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [retourHTTP replaceObjectAtIndex:0 withObject:[NSNumber numberWithInt:1]];
    [retourHTTP replaceObjectAtIndex:1 withObject:error];
    
    NSLog(@"Connection failed! Error - %@",
          [error localizedDescription]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // do something with the data
    // receivedData is declared as a method instance elsewhere
    retourHTTP = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil];
    
    NSLog(@"dataBrute long: %d",[receivedData length]);
    
    NSString * string = [[NSString alloc] initWithData:receivedData encoding:NSISOLatin1StringEncoding];
    //NSLog(@"REPONSE DU WEB: \"%@\"\n",string);
    
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
            [retourHTTP replaceObjectAtIndex:0 withObject:[NSNumber numberWithInt:2]];
            
            NSDictionary *userInfo = [NSDictionary 
                                      dictionaryWithObject:@"Aucun bien ne correspond à ces critères dans notre base de données."
                                      forKey:NSLocalizedDescriptionKey];
            
            error =[NSError errorWithDomain:@"Aucun bien trouvé."
                                       code:1 userInfo:userInfo];
            [retourHTTP replaceObjectAtIndex:1 withObject:error];
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
        }
        [string release];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"connectionFinished" object:retourHTTP];
    // release the connection, and the data object
    [connection release];
    [receivedData release];
}


@end
