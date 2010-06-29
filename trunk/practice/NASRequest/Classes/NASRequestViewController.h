//
//  NASRequestViewController.h
//  NASRequest
//
//  Created by Leon on 10-5-16.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NASDataRequest;

@interface NASRequestViewController: UIViewController {
    IBOutlet UILabel * _labelStatus;
    IBOutlet UITextView * _textOutput;
    IBOutlet UIButton * _buttonConnect;
    NASDataRequest *nasDataReqeust;
}

- (IBAction)startNASDataRequest: (id)sender;

@end

