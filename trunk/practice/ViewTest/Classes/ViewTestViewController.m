//
//  ViewTestViewController.m
//  ViewTest
//
//  Created by Leon on 10-7-1.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "ViewTestViewController.h"

@implementation ViewTestViewController

@synthesize messageBox = _messageBox;
@synthesize bubbleImage1 = _imageBubble1;
@synthesize bubbleImage2 = _imageBubble2;

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
    testView = (ViewTestView *)[self view];
    
    srand((unsigned int)time(0));
    
    [self loadMessages];
    
    // Load Image
    _imageBubble1 = [[UIImage imageNamed:@"yellow.png"] stretchableImageWithLeftCapWidth:21 topCapHeight:13];
    [_imageBubble1 retain];
    _imageBubble2 = [[UIImage imageNamed:@"grey_2.png"] stretchableImageWithLeftCapWidth:21 topCapHeight:13];
    [_imageBubble2 retain];
        
    CGRect rectBounds = [[self view] bounds];
    
    // add input view;
    CGRect rectSubview = rectBounds;
    rectSubview.origin.y = rectBounds.size.height - 40;
    rectSubview.size.height = 40;
    _inputViewController = [[InputViewController alloc] initWithRect:rectSubview];
    [_inputViewController loadView];
    [testView addSubview:[_inputViewController view]];
    
    // add table view
    rectSubview = rectBounds;
    rectSubview.size.height = rectBounds.size.height - 40;
    _tableViewController = [[TableViewController alloc] initWithStyle:UITableViewStylePlain];
    [_tableViewController setTestViewController:self];
    [[_tableViewController tableView] setFrame:rectSubview];
    [[_tableViewController tableView] setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [testView addSubview:[_tableViewController view]];
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
    [_tableViewController release];
    [_inputViewController release];
    [_messageBox release];
    [_imageBubble1 release];
    [_imageBubble2 release];
    [super dealloc];
}

#pragma mark Operations

const static char msg[][4096] = 
{
    "Characters may be used multiple times. For example, if y is used for the year, 'yy' might produce '99', whereas 'yyyy' produces '1999'. For most numerical fields, the number of characters specifies the field width. For example, if h is the hour, 'h' might produce '5', but 'hh' produces '05'. For some characters, the count specifies whether an abbreviated or full form should be used, but may have other choices, as given below.",
    "问：你对C&C4怎么看？很多人认为C&C4不算是C&C系列的正作。\r\n答：我没有参与该作的开发也没玩过最终成品，离开EALA之前我只玩过该作的预发布版本，由我来品评该作似乎有失公允。\r\n我只能告诉各位，C&C4本来就没打算以泰伯利亚正作的面目出现，它是一部实验性质的在线游戏，原本是以C&C3在线版的身份瞄准亚洲市场。公司决策层不知犯了什么病要为它整一个单机剧情，然后放进盒子里以C&C4的面目推向市场。\r\n开发团队当然反对这个决定，但决定就是决定，团队成员只好尽其所能，在条件允许的情况下争取拿出一款佳作，但它不可避免地成为公司文化的牺牲品。\r\n能开发一款C&C游戏就像美梦终成真，虽然这美梦也能变成噩梦。",
    "Two single quotes represents a literal single quote, either inside or outside single quotes. Text within single quotes is not interpreted in any way (except for two adjacent single quotes). Otherwise all ASCII letter from a to z and A to Z are reserved as syntax characters, and require quoting if they are to represent literal characters. In addition, certain ASCII punctuation characters may become variable in the future (eg \":\" being interpreted as the time separator and '/' as a date separator, and replaced by respective locale-sensitive characters in display).",
    "阿富汗战场，Tier 1特战队员充当制作顾问，寒霜引擎，DICE加持……，结果你发现该作beta阶段的水准与某些免费Mod等量齐观——用一句话来形容就是：“HL2的Insurgency免费Mod现包装上市，开价60美元，可召唤迫击炮火力打击。”",
    "HTC HD2作为Windows Mobile系统的绝代机皇，在微软全力开发Windows Phone 7的时间里，已经确定不能获得官方的WP7系统升级，不过机友仍然有多种玩法可以选择，现在Ubuntu也已经移植到该款手机中。之前我们曾看到过HD2运行Windows 95、修改测试版Windows Phone 7系 统的演示，现在开发者们又放出了这款手机运行Android 2.1和Ubuntu系统的演示。",
    "Tomcat是由Apache软件基金会下属的Jakarta项目开发的一个Servlet容器，按照Sun Microsystems提供的技术规范，实现了对Servlet和JavaServer Page（JSP）的支持，并提供了作为 Web服务器的一些特有功能，如Tomcat管理和控制平台、安全域管理和Tomcat阀等。由于Tomcat本身也内含了一个HTTP服务器，它也可以 被视作一个单独的Web服务器。但是，不能将 Tomcat 和 Apache Web 服务器混淆，Apache Web Server 是一个用 C 语言实现的 HTTP web server；这两个 HTTP web server 不是捆绑在一起的。",
    "Test message send from my",
    "Message send from system",
    "A lot of message send from nowhere!",
    "前EALA（EA洛杉矶分部）“命令与征服”团队资深成员Greg Black提交了一篇反映EA游戏制作文化的访谈：",
};

const static char sdr[][1024] = 
{
    "Tester_001",
    "Tester_009",
};

- (void)loadMessages {
    if (_messageBox == nil) {
        _messageBox = [[NSMutableArray alloc] init];
    }
        
    for (int i = 0; i < 60; i ++) {

        int m = rand() % 10;
        int s = rand() % 2;
        NSString * message = [NSString stringWithCString:msg[m] encoding:NSUTF8StringEncoding];
        NSString * sender = [NSString stringWithCString:sdr[s] encoding:NSUTF8StringEncoding];
        BOOL fromMy = (s == 0);
        MessageObject * msg = [[MessageObject alloc] initWithSender:sender
                                                        withMessage:message
                                                             fromMy:fromMy];
        [_messageBox addObject:msg];
    }
}

@end
