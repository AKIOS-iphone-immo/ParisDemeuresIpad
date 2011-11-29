//
//  DiapoController3.h
//  Paris_Demeures_Ipad
//
//  Created by Christophe Bergé on 19/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArrayWithIndex.h"

@protocol DiapoController3Delegate;

@interface DiapoController3 : UIViewController <UIScrollViewDelegate>{
    ArrayWithIndex *arrayWithIndex;
    UIScrollView *diaporama;
    BOOL isFirstRotation;
    int scrollViewWidth;
    int scrollViewIndex;
    UINavigationBar *navBar;
}
@property (nonatomic, assign) id <DiapoController3Delegate> delegate;

- (NSMutableArray *)getImages;

@end

@protocol DiapoController3Delegate
- (void)diapoControllerDidFinish:(DiapoController3 *)controller;
@end