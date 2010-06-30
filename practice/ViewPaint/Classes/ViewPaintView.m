//
//  ViewPaintView.m
//  ViewPaint
//
//  Created by Leon on 10-6-30.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ViewPaintView.h"


@implementation ViewPaintView


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    if ((self = [super initWithCoder:decoder])) {
        // Init
        imageBubble1 = [[UIImage imageNamed:@"yellow.png"] stretchableImageWithLeftCapWidth:21 topCapHeight:13];
        [imageBubble1 retain];
        imageBubble2 = [[UIImage imageNamed:@"grey_2.png"] stretchableImageWithLeftCapWidth:21 topCapHeight:13];
        [imageBubble2 retain];
        
        testString = [[NSString alloc] initWithString:@"测试文字1234567测试文字1234567测试文字1234567测试文字1234567测试文字1234567测试文字1234567测试文字1234567测试文字1234567"];
        
        UILabel *label = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
        label.font = [UIFont systemFontOfSize:13];
        label.text = testString;
        label.numberOfLines = 20;
        
        CGRect bounds = CGRectMake(0, 0, 240, 200);
        textBounds = [label textRectForBounds:bounds limitedToNumberOfLines:20];
        
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    NSLog(@"Paint here!");
    
    UIFont * textFont = [UIFont systemFontOfSize:13];
    
    // 画泡泡
    CGRect rectBubble = textBounds;
    rectBubble.size.width += 30;
    rectBubble.size.height += 16;
    rectBubble.origin.x = rect.size.width - rectBubble.size.width;
    rectBubble.origin.y = 0;
    [imageBubble1 drawInRect:rectBubble];
    
    // 画文字
    rectBubble.origin.x += 12;
    rectBubble.origin.y += 6;
    rectBubble.size.width -= 30;
    rectBubble.size.height -= 12;
    [testString drawInRect:rectBubble withFont:textFont];
    
    // 画第二个泡泡
    rectBubble = textBounds;
    rectBubble.size.width += 30;
    rectBubble.size.height += 16;
    rectBubble.origin.x = 0;
    rectBubble.origin.y += rectBubble.size.height + 5;
    [imageBubble2 drawInRect:rectBubble];
    
    // 第二段文字
    rectBubble.origin.x += 18;
    rectBubble.origin.y += 6;
    rectBubble.size.width -= 30;
    rectBubble.size.height -= 12;
    [testString drawInRect:rectBubble withFont:textFont];
}


- (void)dealloc {
    [imageBubble1 release];
    [imageBubble2 release];
    [super dealloc];
}

/////////////////////////////////////////////////////////////////////////
#pragma mark ...
/////////////////////////////////////////////////////////////////////////


@end
