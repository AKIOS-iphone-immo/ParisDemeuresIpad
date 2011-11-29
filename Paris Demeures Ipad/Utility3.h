//
//  Utility3.h
//  Paris_Demeures_Ipad
//
//  Created by Christophe Bergé on 18/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XMLParser.h"

@interface Utility3 : NSObject {
    NSMutableArray *retourHTTP;
    BOOL isRequestFinished;
    
}

- (UITabBarItem *)getItem:(NSString *)itemTitle imagePath:(NSString *)imagePath tag:(NSInteger)tag;
-(NSMutableArray *)httpRequestForSmallAdds:(NSMutableDictionary *)postValues;

@end
