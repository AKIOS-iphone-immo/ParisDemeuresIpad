//
//  Utility2.h
//  Paris_Demeures_Ipad
//
//  Created by Christophe Bergé on 17/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLParser.h"


@interface Utility2 : NSObject {
    NSMutableData *receivedData;
    NSMutableArray *retourHTTP;
    
}

-(NSMutableArray *)httpRequestForSmallAdds:(NSMutableDictionary *)postValues;

@end
