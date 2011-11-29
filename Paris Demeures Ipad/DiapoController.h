//
//  DiapoController.h
//  RezoImmoTest1
//
//  Created by Christophe Bergé on 22/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IGUIScrollViewImage.h"
#import "ArrayWithIndex.h"


@interface DiapoController : UIViewController {
	ArrayWithIndex *arrayWithIndex;
	NSMutableArray *arrayWithIndex2;
	
}

@property (nonatomic, copy) ArrayWithIndex *arrayWithIndex;
@property (nonatomic, copy) NSMutableArray *arrayWithIndex2;

- (NSMutableArray *)getImages;

@end
