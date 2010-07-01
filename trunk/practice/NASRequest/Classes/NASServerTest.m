//
//  NASServerTest.m
//  NASRequest
//
//  Created by Leon on 10-5-18.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NASServerTest.h"

@implementation NASServerTest

@synthesize isTesting = _isTesting;
@synthesize isSucceed = _isSucceed;
@synthesize interval = _interval;
@synthesize serverAddress = _serverAddress;

- (id) init
{
    self = [super init];
    if (self) {
        _isTesting = false;
        _isSucceed = false;
        _interval = 0;
        _testStart = 0;
        _testEnd = 0;
    }
    return self;
}

- (id)initWithAddress:(NSString *)address
{
    self = [super init];
    if (self) {
        _serverAddress = [[NSString alloc] initWithString:address];
        _isTesting = false;
        _isSucceed = false;
        _interval = 0;
        _testStart = 0;
        _testEnd = 0;
    }
    return self;
}

- (void)dealloc
{
    [_connection release];
    [_serverAddress release];
    [super dealloc];
}

- (void)startTest
{
    if( _isTesting )
    {
        
    }
    else
    {
        NSString * server = [NSString stringWithString:_serverAddress];
        NSRange range = [server rangeOfString:@":"];
        if (range.length > 0 && range.location > 0) {
            server = [server substringToIndex:range.location];
        }
        NSString * urlString = [NSString stringWithFormat:@"http://%@", server];
        
        [self setIsSucceed:false];
        [self setIsTesting:true];
        _testStart = [[NSDate date] timeIntervalSince1970];
        _testEnd = 0;
        _interval = 0;
        
        NSURL * url = [NSURL URLWithString:urlString];
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
        if(_connection)
        {
            [_connection release];
            _connection = nil;
        }
        _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        [_connection start];
    }
    
}

- (void)stopTest
{
    if( _isTesting )
    {
        if( _connection )
        {
            [_connection cancel];
        }
        [self setIsTesting:false];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"server test connection didFailWithError");
    
    [_connection release];
    _connection = nil;
    
    [self setIsSucceed:false];
    [self setIsTesting:false];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"server test connection connectionDidFinishLoading");

    [_connection release];
    _connection = nil;

    _testEnd = [[NSDate date] timeIntervalSince1970];
    [self setInterval:(_testEnd - _testStart)];
    [self setIsSucceed:true];
    [self setIsTesting:false];
}

@end
