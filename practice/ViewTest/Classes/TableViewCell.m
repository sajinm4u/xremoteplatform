//
//  TableViewCell.m
//  ViewTest
//
//  Created by Leon on 10-7-1.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TableViewCell.h"
#import "MessageObject.h"
#import "ViewTestViewController.h"

@implementation TableViewCell

@synthesize testViewController = _testViewController;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        _message = nil;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)drawRect:(CGRect)rect {
    UIImage * imageBubble;
    if ([_message fromMy]) {
        imageBubble = [_testViewController bubbleImage1];
    }
    else {
        imageBubble = [_testViewController bubbleImage2];
    }
    UIFont * textFont = [UIFont systemFontOfSize:14];
    UIFont * textBoldFont = [UIFont boldSystemFontOfSize:11];
       
    // 画泡泡
    CGRect rectBubble = rect;
    CGSize sizeMessage = [_message getValidSize];
  
    rectBubble.size = sizeMessage;
    if ([_message fromMy]) {
        rectBubble.origin.x = rect.size.width - rectBubble.size.width;
        rectBubble.origin.y = 0;
    }
    else {
        rectBubble.origin.x = 0;
        rectBubble.origin.y = 0;

    }
    [imageBubble drawInRect:rectBubble];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDefaultDate:[_message date]];
    [formatter setDateFormat:@"MM-dd HH:mm"];

    // 绘制文字
    NSString * string = [_message message];
    if ([_message fromMy]) {
        rectBubble.origin.x += 12;
        rectBubble.origin.y += 19;
        rectBubble.size.width -= 30;
        rectBubble.size.height -= 12;
        [string drawInRect:rectBubble withFont:textFont];
        // 名称
        string = [_message sender];    
        rectBubble.origin.y = 4;
        rectBubble.size.height = 12;
        [string drawInRect:rectBubble withFont:textBoldFont];
        // 日期
        string = [formatter stringFromDate:[_message date]];
        textFont = [UIFont systemFontOfSize:11];
        CGSize sizeDate = [string sizeWithFont:textFont];
        rectBubble.origin.x = rectBubble.origin.x + (rectBubble.size.width - sizeDate.width);
        rectBubble.size = sizeDate;
        [string drawInRect:rectBubble withFont:textFont];
    }
    else {
        rectBubble.origin.x += 18;
        rectBubble.origin.y += 19;
        rectBubble.size.width -= 30;
        rectBubble.size.height -= 12;
        [string drawInRect:rectBubble withFont:textFont];
        // 名称
        string = [_message sender];    
        rectBubble.origin.y = 4;
        rectBubble.size.height = 12;
        [string drawInRect:rectBubble withFont:textBoldFont];
        // 日期
        string = [formatter stringFromDate:[_message date]];
        textFont = [UIFont systemFontOfSize:11];
        CGSize sizeDate = [string sizeWithFont:textFont];
        rectBubble.origin.x = rectBubble.origin.x + (rectBubble.size.width - sizeDate.width);
        rectBubble.size = sizeDate;
        [string drawInRect:rectBubble withFont:textFont];
    }
                  
    [formatter release]; 
    
   
}

- (void)dealloc {
    [_message release];
    [super dealloc];
}

#pragma mark Operations

- (void)setMessage:(MessageObject *)message {
    if (_message != nil) {
        [_message release];    
    }
    _message = [message copy];
    [self setNeedsDisplay];
}

@end
