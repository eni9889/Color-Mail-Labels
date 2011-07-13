//
//  SwipeableExampleAppDelegate.m
//  SwipeableExample
//
//  Created by Tom Irving on 16/06/2010.
//  Copyright Tom Irving 2010. All rights reserved.
//

#import "SwipeableExampleAppDelegate.h"
#import "RootViewController.h"


@implementation SwipeableExampleAppDelegate

@synthesize window;
@synthesize navigationController;



#pragma mark -
#pragma mark Application lifecycle


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    // Override point for customization after app launch   
	
	// Obviously I never do anything like this, but it's quick for the example.
	[self setWindow:[[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease]];
	[self setNavigationController:[[[UINavigationController alloc] initWithRootViewController:[[[RootViewController alloc] initWithStyle:UITableViewStylePlain] autorelease]] autorelease]];
	[[self navigationController] setToolbarHidden:NO];
	[[[self navigationController] toolbar] setBarStyle:UIBarStyleBlackTranslucent];
	
	
	
	UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0 , [[self navigationController] toolbar].frame.size.height/4, [[self navigationController] toolbar].frame.size.width, 21.0f)];
	//[titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
	[titleLabel setBackgroundColor:[UIColor clearColor]];
	[titleLabel setTextColor:[UIColor whiteColor]];
	[titleLabel setText:@"Click Email to Choose a Color Label"];
	[titleLabel setTextAlignment:UITextAlignmentCenter];
	
	
	[[[self navigationController] toolbar] addSubview:titleLabel];
	
	
	
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
	return YES;
}


#pragma mark -
#pragma mark IASKAppSettingsViewControllerDelegate protocol

- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

