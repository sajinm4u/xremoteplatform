//
//  NASRequestViewController.m
//  NASRequest
//
//  Created by Leon on 10-5-16.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "NASRequestViewController.h"
#import "NASDataRequest.h"

@implementation NASRequestViewController



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
    
    if(nasDataReqeust == nil)
    {
        nasDataReqeust = [[NASDataRequest alloc] init];
    }
    [nasDataReqeust addObserver:self forKeyPath:@"isReceiving" options:NSKeyValueObservingOptionNew context:nil];
    [nasDataReqeust addObserver:self forKeyPath:@"imServerAddress" options:NSKeyValueObservingOptionNew context:nil];
    [nasDataReqeust addObserver:self forKeyPath:@"isServerTestEnd" options:NSKeyValueObservingOptionNew context:nil];
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
    [nasDataReqeust release];
    [super dealloc];
}

#pragma mark Observer

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"isReceiving"] && object == nasDataReqeust) {
        if ([nasDataReqeust isReceiving]) {
            [_labelStatus setText:@"正在获取..."];
            [_buttonConnect setTitle:@"Stop" forState:UIControlStateNormal];
            [_textOutput setText:@""];
        }
        else {
            if ([nasDataReqeust isServerTestEnd] == false ) {
                [_labelStatus setText:@"正在测速..."];
            }
            else {
                [_labelStatus setText:@"获取完毕"];
                [_buttonConnect setTitle:@"Connect" forState:UIControlStateNormal];
            }
        }
        return;
    }
    if ([keyPath isEqualToString:@"imServerAddress"] && object == nasDataReqeust) {
        NSArray * servers = [nasDataReqeust imServerAddress];
        NSString * string = @"";
        for (int i = 0; i < [servers count]; i ++) {
            string = [string stringByAppendingString:[servers objectAtIndex:i]];
            string = [string stringByAppendingString:@"\n"];
        }
        [_textOutput setText:string];
        return;
    }
    if ([keyPath isEqualToString:@"isServerTestEnd"] && object == nasDataReqeust) {
        if ([nasDataReqeust isServerTestEnd]) {
            NSString * result = [nasDataReqeust serverTestResult];
            [_textOutput setText:result];
        }

        if ([nasDataReqeust isServerTestEnd] ) {
            [_labelStatus setText:@"测速完毕"];
            [_buttonConnect setTitle:@"Connect" forState:UIControlStateNormal];
        }

        return;
    }
    
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

#pragma mark UI Action

-(IBAction)startNASDataRequest:(id)sender
{
    if ([nasDataReqeust isReceiving]) {
        [nasDataReqeust stopRequest];
    }
    else {
        if ([nasDataReqeust isServerTestEnd] == false) {
            [nasDataReqeust stopServerTest];
        }
        else {
            [nasDataReqeust startRequest];  
        }
    }
}

@end
