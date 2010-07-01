//
//  MessageObject.h
//  ViewTest
//
//  Created by Leon on 10-7-1.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MessageObject : NSObject < NSCopying > {
    NSString * _sender;
    NSString * _message;
    BOOL _fromMy;
    NSDate * _date;

    // UI Oper
    BOOL _gotSize;
    CGSize _validSize;

}

@property (nonatomic, readonly, retain) NSString * sender;
@property (nonatomic, readonly, retain) NSString * message;
@property (nonatomic, readonly) BOOL fromMy;
@property (nonatomic, readonly, assign) NSDate * date;

- (id)initWithSender:(NSString *)sender 
          withMessage:(NSString *)message 
              fromMy:(BOOL)fromMy
            withDate:(NSDate *)date;

- (id)initWithSender:(NSString *)sender
         withMessage:(NSString *)message 
              fromMy:(BOOL)fromMy;

- (id)initWithMessage:(MessageObject *)message;

- (CGSize) getValidSize;

@end
