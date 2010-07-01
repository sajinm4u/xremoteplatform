//
//  InputView.m
//  ViewTest
//
//  Created by Leon on 10-7-1.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "InputView.h"


@implementation InputView


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef cgContext = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBFillColor (cgContext, 0, 1, 0, 1);
    CGContextFillRect (cgContext, rect);
}


- (void)dealloc {
    [super dealloc];
}


@end
