//
//  InputViewController.h
//  ViewTest
//
//  Created by Leon on 10-7-1.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputView.h"

@interface InputViewController : UIViewController {
    CGRect _rectOrgin;
    InputView * _inputView;
}

- (id)initWithRect:(CGRect)rect;

@end
