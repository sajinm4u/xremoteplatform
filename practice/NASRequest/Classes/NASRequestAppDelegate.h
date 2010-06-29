//
//  NASRequestAppDelegate.h
//  NASRequest
//
//  Created by Leon on 10-6-29.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NASRequestViewController;

@interface NASRequestAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    NASRequestViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet NASRequestViewController *viewController;

@end

