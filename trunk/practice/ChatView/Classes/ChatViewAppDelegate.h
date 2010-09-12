//
//  ChatViewAppDelegate.h
//  ChatView
//
//  Created by Leon on 10-6-29.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChatViewViewController;

@interface ChatViewAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ChatViewViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ChatViewViewController *viewController;

@end

