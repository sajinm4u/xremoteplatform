//
//  NASServerTest.h
//  NASRequest
//
//  Created by Leon on 10-5-18.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NASServerTest : NSObject {
    bool _isTesting;
    bool _isSucceed;
    NSTimeInterval _interval;
    NSTimeInterval _testStart;
    NSTimeInterval _testEnd;
    NSString * _serverAddress;
    NSURLConnection * _connection;
}

@property (nonatomic) bool isTesting;
@property (nonatomic) bool isSucceed;
@property (nonatomic) NSTimeInterval interval;
@property (nonatomic, retain) NSString * serverAddress;

- (id)initWithAddress:(NSString *)address;
- (void)startTest;
- (void)stopTest;

@end
