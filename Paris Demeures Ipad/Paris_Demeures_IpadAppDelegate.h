//
//  Paris_Demeures_IpadAppDelegate.h
//  Paris Demeures Ipad
//
//  Created by Christophe Bergé on 03/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Utility.h"
#import "Accueil.h"
#import "ContactViewController.h"
#import "Favoris.h"
#import "AgenceViewController.h"

@class Paris_Demeures_IpadViewController, Accueil, AgenceViewController;

@interface Paris_Demeures_IpadAppDelegate : NSObject <UIApplicationDelegate> {

    UITabBarController *tabBarController;
	Accueil *accueilView;
	Favoris *favorisView;
	AgenceViewController *agenceView;
	ContactViewController *contactView;
    BOOL isAccueil;
    UIImageView *imagePresentation;
    
@private
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
	
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet Paris_Demeures_IpadViewController *viewController;

@property (nonatomic, retain) UITabBarController *tabBarController;
@property (nonatomic, retain) Accueil *accueilView;
@property (nonatomic, retain) Favoris *favorisView;
@property (nonatomic, retain) AgenceViewController *agenceView;
@property (nonatomic, retain) ContactViewController *contactView;
@property (nonatomic, assign) BOOL isAccueil;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSString *)applicationDocumentsDirectory;

@end
