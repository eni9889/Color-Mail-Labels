//
//  ColorPickerViewController.m
//  ColorPicker
//
//  Created by Gilly Dekel on 23/3/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "ColorPickerViewController.h"
#import "ColorPickerView.h"
#import "AboutScreenViewController.h"
#import "SwipeableExampleAppDelegate.h"
#import "RootViewController.h"
#import "UIColor-HSVAdditions.h"
#import "GradientView.h"

@implementation ColorPickerViewController

@synthesize aboutScreenViewController,email, anIndex;

NSString *keyForHue = @"hue";
NSString *keyForSat = @"sat";
NSString *keyForBright = @"bright";




// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	NSLog(@"CALL ME ! " );
	
	[[UIApplication sharedApplication] setStatusBarHidden:YES animated:NO];
	
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	NSMutableDictionary	*colorInt = [prefs objectForKey:[self email]];
	
	if (colorInt)
	{
		ColorPickerView *mView = (ColorPickerView *)[self view];
		UIColor *tempC = [UIColor colorWithRed:[[colorInt objectForKey:@"red"] floatValue] 
										 green:[[colorInt objectForKey:@"green"] floatValue] 
										  blue:[[colorInt objectForKey:@"blue"] floatValue] 
										 alpha:[[colorInt objectForKey:@"alpha"] floatValue]];
		
		[mView setCurrentHue:[tempC hue]];
		[mView setCurrentBrightness:[tempC brightness]];
		[mView setCurrentSaturation:[tempC saturation]];
		[[mView showColor] setBackgroundColor:tempC];
		[[mView gradientView] setTheColor:[tempC CGColor]];
	}	
		
}

- (void) viewWillDisappear :(BOOL)animated { 

	[[UIApplication sharedApplication] setStatusBarHidden:NO animated:NO];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (UIColor *) getSelectedColor {
	return [(ColorPickerView *) [self view] getColorShown];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (IBAction) pressedAboutButton { 
	//[self.navigationController dismissModalViewControllerAnimated:YES];
		
	SwipeableExampleAppDelegate* delegate = (SwipeableExampleAppDelegate *)[[UIApplication sharedApplication] delegate];
											 
	UIColor *color = [self getSelectedColor];
	CGColorRef colorref = [color CGColor];
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	int numComponents = CGColorGetNumberOfComponents(colorref);
	
	if (numComponents == 4) {
		const CGFloat *components = CGColorGetComponents(colorref);
		CGFloat red     = components[0];
		CGFloat green = components[1];
		CGFloat blue   = components[2];
		CGFloat alpha = components[3];
		
		
		NSMutableDictionary *colValues = [[NSMutableDictionary alloc] init];
		[colValues setObject:[NSNumber numberWithFloat:red] forKey:@"red"];
		[colValues setObject:[NSNumber numberWithFloat:green] forKey:@"green"];
		[colValues setObject:[NSNumber numberWithFloat:blue] forKey:@"blue"];
		[colValues setObject:[NSNumber numberWithFloat:alpha] forKey:@"alpha"];
		
		[prefs setObject:colValues forKey:[self email]];
		[prefs synchronize];
		
		
		[[[[[delegate navigationController] viewControllers] objectAtIndex:0]  tableView] reloadData];
		
	}	
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction) pressedCButton
{
	[self dismissModalViewControllerAnimated:YES];
}

- (void)dealloc {
    [super dealloc];
	[aboutScreenViewController release];
}

@end
