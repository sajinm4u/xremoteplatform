//
//  TableViewCell.h
//  ViewTest
//
//  Created by Leon on 10-7-1.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MessageObject;
@class ViewTestViewController;

@interface TableViewCell : UITableViewCell {
    MessageObject * _message;
    ViewTestViewController * _testViewController;
}

@property (nonatomic, readwrite, assign) ViewTestViewController * testViewController;

- (void)setMessage:(MessageObject *)message;

@end
