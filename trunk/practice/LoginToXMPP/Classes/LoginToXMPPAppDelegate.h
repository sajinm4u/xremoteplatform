//
//  LoginToXMPPAppDelegate.h
//  LoginToXMPP
//
//  Created by Leon on 10-6-28.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMPP.h"

@class LoginToXMPPViewController;

@interface LoginToXMPPAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    LoginToXMPPViewController *viewController;
    
    // XMPP Global vars
    XMPPStream *xmppStream;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet LoginToXMPPViewController *viewController;

@property (nonatomic, readonly) XMPPStream *xmppStream;

@end

