//
//  Paris_Demeures_IpadAppDelegate.m
//  Paris Demeures Ipad
//
//  Created by Christophe Bergé on 03/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Paris_Demeures_IpadAppDelegate.h"

#import "Paris_Demeures_IpadViewController.h"

@implementation Paris_Demeures_IpadAppDelegate


@synthesize window=_window;

@synthesize viewController=_viewController;

@synthesize tabBarController, accueilView;
@synthesize favorisView, agenceView, contactView;
@synthesize isAccueil;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
     
    //CORE DATA - - GARDER CE BOUT DE CODE POUR CREER LE FICHIER BDD DANS LE SIMULATEUR IPHONE
	/*******************
     NSManagedObjectContext *context = [self managedObjectContext];
     NSManagedObject *codesPostauxInfo = [NSEntityDescription
     insertNewObjectForEntityForName:@"Codes" 
     inManagedObjectContext:context];
     [codesPostauxInfo setValue:@"77" forKey:@"code"];
     [codesPostauxInfo setValue:@"Seine et Marne" forKey:@"commune"];
     
     NSError *error;
     if (![context save:&error]) {
     NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
     }
     ******************/
	
    isAccueil = NO;
    
	// creates your tab bar so you can add everything else to it
	tabBarController = [[UITabBarController alloc] init];
    
    /******/
	/*** VUE ONGLET ACCUEIL AVEC NAVIGATION ***/
	accueilView = [[Accueil  alloc] init];
    
    UINavigationController *tableNavController = [[[UINavigationController alloc] initWithRootViewController:accueilView] autorelease];
	
    [accueilView release];
    
	//tableNavController.navigationBar.topItem.title = @"Accueil";
    //tableNavController.navigationBarHidden = YES;
    /******/
    
	/*** VUE ONGLET FAVORIS***/
	favorisView = [[Favoris alloc] init];
    
    UINavigationController *tableNavControllerFavoris = [[[UINavigationController alloc] initWithRootViewController:favorisView] autorelease];
	
    [favorisView release];
    
	/*** VUE ONGLET AGENCES***/
	agenceView = [[AgenceViewController alloc] init];
    
	/*** VUE ONGLET CONTACT***/
	contactView = [[ContactViewController alloc] init];
    
	/*** AJOUT DES ONGLETS DANS LA BARRE D'ONGLETS***/
	Utility *utility = [[Utility alloc] init];
	
	NSInteger tag = -1;
	
	tableNavController.tabBarItem = [utility getItem:@"" imagePath:@"/accueil.png" tag:tag++];
    tableNavController.tabBarItem.title = @"Accueil";
    
    tableNavControllerFavoris.tabBarItem = [utility getItem:@"" imagePath:@"/favoris.png" tag:tag++];
    tableNavControllerFavoris.tabBarItem.title = @"Favoris";
    
	//favorisView.tabBarItem = [utility getItem:@"" imagePath:@"/favoris.png" tag:tag++];
	//favorisView.tabBarItem.title = @"Favoris";
    
	agenceView.tabBarItem = [utility getItem:@"" imagePath:@"/lagence.png" tag:tag++];
	agenceView.tabBarItem.title = @"L'agence";
    
	contactView.tabBarItem = [utility getItem:@"" imagePath:@"/contact.png" tag:tag++];
	contactView.tabBarItem.title = @"Contact";
    
	[utility release];
	
	//add both of your navigation controllers to the tab bar. You can put as many controllers on as you like, but they will turn into the more button.
	tabBarController.viewControllers = [NSArray arrayWithObjects: tableNavController,
                                        /*favorisView,*/
                                        tableNavControllerFavoris,
                                        agenceView,
                                        contactView,
                                        nil];
	/*** FIN AJOUT DES ONGLETS DANS LA BARRE D'ONGLETS***/
	/******/
    
	[self.window addSubview:tabBarController.view];
    
    /*** ANIMATION FADING ***/
    /*imagePresentation = [[[UIImageView alloc] autorelease] initWithImage:[UIImage imageNamed:@"Default.png"]];
    [tabBarController.view addSubview:imagePresentation];
    [UIView beginAnimations:@"ImagePresentation" context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector( removeDefaultView: )];
    [UIView setAnimationDelay:2.0];
    [UIView setAnimationDuration:4];
    [imagePresentation setAlpha:0.0];
    [UIView commitAnimations];*/
    /*** ANIMATION FADING ***/
    
    //self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [tabBarController release];
	[accueilView release];
	[favorisView release];
	[agenceView release];
	[contactView release];
	
    [managedObjectContext_ release];
    [managedObjectModel_ release];
    [persistentStoreCoordinator_ release];
    
    [_window release];
    [_viewController release];
    [super dealloc];
}

#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext {
    
    if (managedObjectContext_ != nil) {
        return managedObjectContext_;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext_ = [[NSManagedObjectContext alloc] init];
        [managedObjectContext_ setPersistentStoreCoordinator:coordinator];
    }
    return managedObjectContext_;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel {
    
    if (managedObjectModel_ != nil) {
        return managedObjectModel_;
    }
	
	managedObjectModel_ = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];    
    return managedObjectModel_;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (persistentStoreCoordinator_ != nil) {
        return persistentStoreCoordinator_;
    }
    
	/*---   ---*/
	/*--- LE CODE SUIVANT EST TIRE DE L'EXEMPLE "CoreDataBooks" DE LA DOC APPLE ---*/
	NSString *storePath = [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"Paris_Demeures_Ipad.sqlite"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
	NSError *error1 = nil;
	//NSDictionary *fileAttributes = [[NSDictionary alloc] init];
	
	NSString *defaultStorePath;
	
	defaultStorePath = [[NSBundle mainBundle] pathForResource:@"Paris_Demeures_Ipad" ofType:@"sqlite"];
	[fileManager removeItemAtPath:storePath error:&error1];
	[fileManager copyItemAtPath:defaultStorePath toPath:storePath error:&error1];
	
	/*
     if (![fileManager fileExistsAtPath:storePath]) {
     defaultStorePath = [[NSBundle mainBundle] pathForResource:@"Paris_Demeures_Ipad" ofType:@"sqlite"];
     if (defaultStorePath) {
     [fileManager copyItemAtPath:defaultStorePath toPath:storePath error:&error1];
     }
     }
     else {
     fileAttributes = [fileManager attributesOfItemAtPath:storePath error:&error1];
     if ([fileAttributes fileSize] < 1200000) {
     defaultStorePath = [[NSBundle mainBundle] pathForResource:@"Paris_Demeures_Ipad" ofType:@"sqlite"];
     if (defaultStorePath) {
     [fileManager removeItemAtPath:storePath error:&error1];
     [fileManager copyItemAtPath:defaultStorePath toPath:storePath error:&error1];
     }
     }
     }*/
	
	NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
							 [NSNumber numberWithBool:YES], 
							 NSMigratePersistentStoresAutomaticallyOption, 
							 [NSNumber numberWithBool:YES], 
							 NSInferMappingModelAutomaticallyOption, nil];
	/*--- FIN DE COPIE COLLE ---*/
	/*---   ---*/
	
    NSURL *storeUrl = [NSURL fileURLWithPath:storePath];
	
	//NSLog(@"storeUrl:%@",storeUrl);
	
    NSError *error = nil;
    persistentStoreCoordinator_ = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator_ addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:options error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return persistentStoreCoordinator_;
}

#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the path to the application's Documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

@end
