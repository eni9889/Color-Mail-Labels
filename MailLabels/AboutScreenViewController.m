//
//  AboutScreenViewController.m
//  Eggreeting
//
//  Created by Gilly Dekel on 26/3/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "AboutScreenViewController.h"


@implementation AboutScreenViewController

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

- (IBAction) pressedEmailSupport {
	NSString *url = [NSString stringWithString: @"mailto:support@v-vent.com"];
	[[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
}

- (IBAction) presssedTellYourFriends {
	NSString *url = [NSString stringWithString: @"mailto:?subject=Look%20at%20this%20cool%20app!&body=Hi,%20I%20found%20this%20application%20and%20thought%20you%20might%20like%20it%20http://eggreeting.v-vent.com/%20"];
	[[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
}

- (IBAction) pressedViewAppCatalog {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.mimoapp.com/icat.html"]];
}

- (IBAction) pressedCloseAboutScreen {
	[self.view removeFromSuperview];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}


@end
