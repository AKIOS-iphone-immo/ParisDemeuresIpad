//
//  Paris_Demeures_IpadAppDelegate.h
//  Paris Demeures Ipad
//
//  Created by Christophe Bergé on 03/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Paris_Demeures_IpadViewController;

@interface Paris_Demeures_IpadAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet Paris_Demeures_IpadViewController *viewController;

@end
