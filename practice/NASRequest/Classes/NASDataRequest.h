//
//  NASDataRequest.h
//  NASRequest
//
//  Created by Leon on 10-5-16.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NASDataRequest : NSObject {
    bool isReceiving;
    bool _isServerTestEnd;
    NSURLConnection * _connection;
    NSData * _nasDataReceived;
    NSString * _nasDataDecrypted;
    NSArray * _imServerAddress;
    NSMutableArray * _imServerTest;
}

@property (nonatomic) bool isReceiving;
@property (nonatomic) bool isServerTestEnd;
@property (nonatomic, readwrite, retain) NSString * nasDataDecrypted;
@property (nonatomic, readwrite, retain) NSArray * imServerAddress;
@property (nonatomic, readwrite, retain) NSMutableArray * imServerTest;

- (void)startRequest;
- (void)stopRequest;
- (void)stopServerTest;

- (NSString *)serverTestResult;
- (NSString *)buildExtendURL:(NSString *)URL;

@end
