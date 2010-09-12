//
//  NASDataRequest.m
//  NASRequest
//
//  Created by Leon on 10-5-16.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NASDataRequest.h"
#import "NASDataRequest_Private.h"
#import <openssl/blowfish.h>
#import "JSON/JSON.h"
#import "NASServerTest.h"

@implementation NASDataRequest

@synthesize isReceiving;
@synthesize isServerTestEnd = _isServerTestEnd;
@synthesize nasDataDecrypted = _nasDataDecrypted;
@synthesize imServerAddress = _imServerAddress;
@synthesize imServerTest = _imServerTest;

static unsigned char szKey[] = "PF15FDIKEUD82JF9";

static const char szApiSrv[] = "http://api.xt800.cn:80";

- (id)init
{
    self = [super init];
    if( self )
    {
        isReceiving = false;
        _isServerTestEnd = true;
        _imServerTest = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void)dealloc
{
    [_connection release];
    [_nasDataReceived release];
    [_nasDataDecrypted release];
    [_imServerAddress release];
    if (_imServerTest != nil) {
        // Clear before
        for (int i = 0; i < [_imServerTest count]; i ++) {
            NASServerTest * serverTest = [_imServerTest objectAtIndex:i];
            [serverTest stopTest];
            [serverTest release];
        }
        [_imServerTest removeAllObjects];
        [_imServerTest release];
    }
    [super dealloc];
}

- (void)startRequest
{
    if( isReceiving )
    {
        
    }
    else
    {
        [self setIsReceiving:true];
        [self setIsServerTestEnd:false];
        
        NSString * serverUrl = [NSString stringWithCString:szApiSrv encoding:[NSString defaultCStringEncoding]];
        serverUrl = [serverUrl stringByAppendingString:@"/nas"];
        NSString * requestUrl = [self buildExtendURL:serverUrl];
        
        NSURL * url = [NSURL URLWithString:requestUrl];
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

- (void)stopRequest
{
    if( isReceiving )
    {
        if( _connection )
        {
            [_connection cancel];
        }
        [self setIsReceiving:false];
    }
}

- (void)stopServerTest
{
    for (int i = 0; i < [_imServerTest count]; i ++) {
        NASServerTest * serverTest = [_imServerTest objectAtIndex:i];
        [serverTest stopTest];
    }
}

#pragma mark URLConnection Delegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"connection didReceiveResponse");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_nasDataReceived release];
    _nasDataReceived = [[NSData alloc] initWithData:data];
    NSString * output = [[NSString alloc] initWithBytes:[data bytes] 
                                                 length:[data length]
                                               encoding:NSUTF8StringEncoding];
    NSLog(@"connection didReceiveData: %@", output);   
    [output release];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"connection didFailWithError");
    [self setIsReceiving:false];
    [_connection release];
    _connection = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"connection connectionDidFinishLoading");
    [self setIsReceiving:false];
    [_connection release];
    _connection = nil;
    
    if (_nasDataReceived == nil || (([_nasDataReceived length] / 2) % 8 != 0) ) {
        NSLog(@"nas data received invalid");
    }
    else {
        [self decryptNasData];
    }
}

#pragma mark private operations

- (unsigned char)Hex2Char:(const char *)szHex
{
    unsigned char rch = 0;
    for( int i = 0; i < 2; i ++ )
    {
        if( *(szHex + i) >= '0' && *(szHex + i) <= '9' )
        {
            rch = (rch << 4) + (*(szHex + i) - '0');
        }
        else if( *(szHex + i) >= 'A' && *(szHex + i) <= 'F' )
        {
            rch = (rch << 4) + (*(szHex +i) - 'A' + 10);
        }
        else 
        {
            break;
        }
    }
    return rch;
}

- (bool)decryptNasData 
{
    if (_nasDataReceived == nil || (([_nasDataReceived length] / 2) % 8 != 0) ) {
        NSLog(@"nas data received invalid");
        return false;
    }
    
    NSData * szBuffer = [NSData dataWithData:_nasDataReceived];
    int bufferLen = [szBuffer length];
    size_t iBlowLen = bufferLen / 2;
    if( iBlowLen <= 0 || (iBlowLen % 8) != 0 )
        return false;
    
    char hexBuffer[4] = {0};
    
    unsigned char * pszBFData = NULL;
    pszBFData = new unsigned char[iBlowLen + 1];
    for (int i = 0; i < iBlowLen; i ++) {
        hexBuffer[0] = *(((char *)[szBuffer bytes]) + (i * 2) + 0);
        hexBuffer[1] = *(((char *)[szBuffer bytes]) + (i * 2) + 1);
        hexBuffer[3] = 0;
        pszBFData[i] = [self Hex2Char:hexBuffer];
    }
    pszBFData[iBlowLen] = 0;
    
    BF_KEY bfKey;
    BF_set_key(&bfKey, 16, szKey);
    
    unsigned char * pszDecryptData = new unsigned char[iBlowLen + 1];
    memset(pszDecryptData, 0, iBlowLen + 1);
    for( int i = 0; i < iBlowLen; i += 8 )
    {
        BF_ecb_encrypt(pszBFData + i, pszDecryptData + i, &bfKey,  BF_DECRYPT);
    }
    
    // [_nasDataDecrypted release];
    [self setNasDataDecrypted:[NSString stringWithCString:(const char *)pszDecryptData encoding:NSASCIIStringEncoding]];
    NSLog(@"%@", _nasDataDecrypted);
    
    delete[] pszBFData;
    delete[] pszDecryptData;
    
    [self getIMServerAddress];
    [self startIMServerTest];
    
    return true;
}

- (int)getIMServerAddress
{
    if (_nasDataDecrypted == nil || [_nasDataDecrypted length] <= 0 ) {
        return -1;
    }
    
    // 调用JSON
    SBJSON * sbjson = [[SBJSON alloc] init];
    [sbjson setMaxDepth:10];
    
    id root = [sbjson objectWithString:_nasDataDecrypted error:NULL];
    if (root != nil) {
        NSDictionary * dict = [NSDictionary dictionaryWithDictionary:root];
        if (dict != nil) {
            id backup = [dict objectForKey:@"im"];
            if (backup != nil) {
                [self setImServerAddress:[NSArray arrayWithArray:backup]];
            }
        }
    }
    
    [sbjson release];
    
    if (_imServerAddress != nil && [_imServerAddress count] > 0 ) {
        int count = [_imServerAddress count];
        for (int i = 0; i < count; i ++) {
            NSString * server = [_imServerAddress objectAtIndex:i];
            NSLog(@"%@", server);
        }
        return count;
    }
    
    return 0;
}

- (void)startIMServerTest
{
    [self setIsServerTestEnd:false];
    if (_imServerTest != nil) {
        // Clear before
        for (int i = 0; i < [_imServerTest count]; i ++) {
            NASServerTest * serverTest = [_imServerTest objectAtIndex:i];
            [serverTest stopTest];
            [serverTest release];
        }
        [_imServerTest removeAllObjects];
    }
    
    for (int i = 0; i < [_imServerAddress count]; i ++) {
        NSString * serverAddress = [_imServerAddress objectAtIndex:i];
        NASServerTest * serverTest = [[NASServerTest alloc] initWithAddress:serverAddress];
        [_imServerTest addObject:serverTest];
        
        // 添加一个监视
        [serverTest addObserver:self forKeyPath:@"isTesting" options:NSKeyValueObservingOptionNew context:nil];
        
        [serverTest startTest];
    }
}

- (NSString *)serverTestResult
{
    NSString * result = @"";
    int count = [_imServerTest count];
    for (int i = 0; i < count; i ++ ) {
        NASServerTest * serverTest = [_imServerTest objectAtIndex:i];
        if ([serverTest isSucceed]) {
            
            NSString * testResult = [NSString stringWithFormat:@"%@(%.2f sec)\n", [serverTest serverAddress], [serverTest interval]];
            result = [result stringByAppendingString:testResult];
        }
        else {
            NSString * testResult = [NSString stringWithFormat:@"%@(未完成)\n", [serverTest serverAddress]];
            result = [result stringByAppendingString:testResult];
        }
    }
    return result;
}

- (NSString *)buildExtendURL:(NSString *)URL
{
    NSString * result = [NSString stringWithString:URL];
    
    result = [result stringByAppendingString:@"?v=1.0.0&t=m"];
              
    return result;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"isTesting"] ) {
        NASServerTest * serverTest = object;
        if ([serverTest isSucceed]) {
            // 关闭其他的
            for (int i = 0; i < [_imServerTest count]; i ++) {
                NASServerTest * serverTest = [_imServerTest objectAtIndex:i];
                [serverTest stopTest];
            }
        }
        
        // 检测，是不是完成了所有测试
        int count = [_imServerTest count];
        if (count > 0) {
            bool allTestComplete = true;
            for (int i = 0; i < count; i ++) {
                NASServerTest * serverTest = [_imServerTest objectAtIndex:i];
                if ([serverTest isTesting]) {
                    allTestComplete = false;
                    break;
                }
            }
            if (allTestComplete) {
                [self setIsServerTestEnd:true];
            }
        }
           
        return;
    }
    
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

@end
