//
//  MessageObject.m
//  ViewTest
//
//  Created by Leon on 10-7-1.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MessageObject.h"

#define MAX_WIDTH   300
#define MIN_WIDTH   240

@implementation MessageObject

@synthesize sender = _sender;
@synthesize message = _message;
@synthesize fromMy = _fromMy;
@synthesize date = _date;

- (id)initWithSender:(NSString *)sender 
         withMessage:(NSString *)message 
              fromMy:(BOOL)fromMy
            withDate:(NSDate *)date {
    // Initialize
    self = [super init];
    if (self) {
        _sender = [[NSString alloc] initWithString:sender];
        _message = [[NSString alloc] initWithString:message];
        _date = [date copy];
        _fromMy = fromMy;
        
        _gotSize = NO;
    }
    return self;
}

- (id)initWithSender:(NSString *)sender 
         withMessage:(NSString *)message 
              fromMy:(BOOL)fromMy {
    // Initialize
    self = [super init];
    if (self) {
        _sender = [[NSString alloc] initWithString:sender];
        _message = [[NSString alloc] initWithString:message];
        _date = [[NSDate date] retain];
        _fromMy = fromMy;
        
        _gotSize = NO;        
    }
    return self;
}

- (id)initWithMessage:(MessageObject *)message
{
    self = [super init];
    if (self) {

    _sender = [[NSString alloc] initWithString:[message sender]];
    _message = [[NSString alloc] initWithString:[message message]];
    _date = [[message date] copy];
    _fromMy = [message fromMy];    
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    MessageObject * messageCopy;
    messageCopy = [[[self class] allocWithZone:zone] initWithMessage:self];
    return messageCopy;
}

- (void)dealloc {
    [_sender release];
    [_message release];
    [_date release];
    [super dealloc];
}

- (CGSize) getValidSize {
    CGSize sizeValid = CGSizeMake(MAX_WIDTH, 20);
    
    if (_gotSize == YES) {
        sizeValid = _validSize;
    }
    else {
        UIFont * font = [UIFont systemFontOfSize:14];
        
        CGSize maxSize = CGSizeMake(MAX_WIDTH - 30, MAXFLOAT);
        _validSize = [_message sizeWithFont:font 
                          constrainedToSize:maxSize
                              lineBreakMode:UILineBreakModeWordWrap];        
        _validSize.width += 30;
        _validSize.height += 26;
        _validSize.width = fmax(_validSize.width, MIN_WIDTH);
        
        _gotSize = YES;
        
        sizeValid = _validSize;
    }
    
    return sizeValid;
}


@end
