//
//  LoginToXMPPViewController.m
//  LoginToXMPP
//
//  Created by Leon on 10-6-28.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "LoginToXMPPViewController.h"
#import "LoginToXMPPAppDelegate.h"

#import <SystemConfiguration/SystemConfiguration.h>

@implementation LoginToXMPPViewController

/////////////////////////////////////////////////////////////////////////
#pragma mark Get Global vars
/////////////////////////////////////////////////////////////////////////
- (XMPPStream *)xmppStream
{
    LoginToXMPPAppDelegate * app = [[UIApplication sharedApplication] delegate];
    
	return [app xmppStream];
}

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    [[self xmppStream] addDelegate:self];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [[self xmppStream] removeDelegate:self];
    [super dealloc];
}



/////////////////////////////////////////////////////////////////////////
#pragma mark IBAction
/////////////////////////////////////////////////////////////////////////

- (IBAction)loginIn:(id)sender{
    XMPPStream * xmppStream = [self xmppStream];
    if (xmppStream == nil) {
        NSLog(@"no xmpp xmppStream");
        return;
    }
    
    [xmppStream setHostName:@"121.14.1.160"];
    [xmppStream setHostPort:5222];
    
    XMPPJID *jid = [XMPPJID jidWithString:@"2000371@kdt.cn" resource:@"kdt_client"];
	[[self xmppStream] setMyJID:jid];
    
    NSError *error = nil;
    BOOL success;
    
    if(![[self xmppStream] isConnected])
	{
		if (/*useSSL*/NO)
			success = [[self xmppStream] oldSchoolSecureConnect:&error];
		else
			success = [[self xmppStream] connect:&error];
	}
	else
	{
		NSString *password = @"111111";
		
		success = [[self xmppStream] authenticateWithPassword:password error:&error];
	}
	
	if (success)
	{
		NSLog(@"001");		
	}
	else
	{
        NSLog(@"001 Error:%@", [error localizedDescription]);
	}
}

/////////////////////////////////////////////////////////////////////////
#pragma mark xmppStream delegate
/////////////////////////////////////////////////////////////////////////

- (void)xmppStreamDidConnect:(XMPPStream *)sender
{
	NSLog(@"---------- xmppStreamDidConnect ----------");
	
	NSString *password = @"111111";
	
	NSError *error = nil;
	BOOL success;
	
	success = [[self xmppStream] authenticateWithPassword:password error:&error];
		
	if (!success)
	{
        NSLog(@"002 Error:%@", [error localizedDescription]);
	}
}


- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
	NSLog(@"---------- xmppStreamDidAuthenticate ----------");
	
	// Send presence
	// [self goOnline];
    // 
    //
    //
    NSLog(@"");
}


- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(NSXMLElement *)error
{
	NSLog(@"---------- xmppStream:didNotAuthenticate: ----------");
	
	// Update tracking variables
		
	// Update GUI
	
    NSLog(@"Invalid username/password");
}


@end
