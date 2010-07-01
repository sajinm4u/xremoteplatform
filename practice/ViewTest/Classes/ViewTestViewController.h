//
//  ViewTestViewController.h
//  ViewTest
//
//  Created by Leon on 10-7-1.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewTestView.h"
#import "TableViewController.h"
#import "InputViewController.h"
#import "MessageObject.h"
#import "MessageBox.h"

@interface ViewTestViewController : UIViewController {
    ViewTestView * testView;
    
    InputViewController * _inputViewController;
    
    TableViewController * _tableViewController;
    NSMutableArray * _messageBox;
    
    UIImage * _imageBubble1;
    UIImage * _imageBubble2;
}

@property (nonatomic, readonly, assign) NSMutableArray * messageBox;
@property (nonatomic, readonly, assign) UIImage * bubbleImage1;
@property (nonatomic, readonly, assign) UIImage * bubbleImage2;

- (void)loadMessages;

@end

