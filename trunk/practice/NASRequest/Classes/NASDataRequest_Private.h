//
//  NASDataRequest.h
//  NASRequest
//
//  Created by Leon on 10-5-16.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NASDataRequest (Private)

- (bool)decryptNasData;

- (int)getIMServerAddress;

- (void)startIMServerTest;

@end
