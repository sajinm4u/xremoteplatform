//
//  ViewTestAppDelegate.h
//  ViewTest
//
//  Created by Leon on 10-7-1.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewTestViewController;

@interface ViewTestAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ViewTestViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ViewTestViewController *viewController;

@end

