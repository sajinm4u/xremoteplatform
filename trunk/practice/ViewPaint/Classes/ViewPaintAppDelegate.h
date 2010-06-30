//
//  ViewPaintAppDelegate.h
//  ViewPaint
//
//  Created by Leon on 10-6-30.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewPaintViewController;

@interface ViewPaintAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ViewPaintViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ViewPaintViewController *viewController;

@end

