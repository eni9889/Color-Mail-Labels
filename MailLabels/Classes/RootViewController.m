//
//  RootViewController.m
//  SwipeableExample
//
//  Created by Tom Irving on 16/06/2010.
//  Copyright Tom Irving 2010. All rights reserved.
//

#import "RootViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "ColorPickerViewController.h"
#import "ColorPickerView.h"
#import "UIColor-HSVAdditions.h"
#import "AlertPrompt.h"

@implementation RootViewController
@synthesize myAccounts;
@synthesize appSettingsViewController, viewController,aliases;

#pragma mark -
#pragma mark View lifecycle

- (IASKAppSettingsViewController*)appSettingsViewController {
	if (!appSettingsViewController) {
		appSettingsViewController = [[IASKAppSettingsViewController alloc] initWithNibName:@"IASKAppSettingsView" bundle:nil];
		appSettingsViewController.delegate = self;
	}
	return appSettingsViewController;
}

- (void)viewDidLoad {
	
	/*TISwipeableTableView * aTableView = [[TISwipeableTableView alloc] initWithFrame:self.tableView.frame style:self.tableView.style];
	[aTableView setDelegate:self];
	[aTableView setDataSource:self];
	[aTableView setSwipeDelegate:self];
	[aTableView setRowHeight:54];
	[self setTableView:aTableView];
	[aTableView release];*/
	
	[self.navigationItem setTitle:@"Mail Labels"];
	self.navigationItem.rightBarButtonItem = [ [ [UIBarButtonItem alloc]
											   initWithImage:[UIImage imageNamed:@"20-gear2.png"] style:UIBarButtonItemStylePlain target:self action:@selector(showSettingsModal:)]
										autorelease];
	
	self.navigationItem.leftBarButtonItem = [ [ [UIBarButtonItem alloc]
												initWithImage:[UIImage imageNamed:@"13-plus.png"] style:UIBarButtonItemStylePlain target:self action:@selector(addA)]
											  autorelease];
	
	myAccounts = [[NSMutableArray alloc] init];
	aliases = [[NSMutableArray alloc] init];
	
	NSMutableDictionary *plist = [NSDictionary dictionaryWithContentsOfFile: @"/User/Library/Preferences/com.apple.accountsettings.plist"];
	NSMutableArray *sortedKeys = [plist objectForKey:@"Accounts"];
	
	
	NSMutableDictionary *mailAccts = [[NSMutableDictionary alloc] init];
	
	//NSLog(@"%d",[dict count]);
	for(int i=0; i < [sortedKeys count]; i++)
	{
		NSDictionary *tDict = [sortedKeys objectAtIndex:i];
		NSArray *mykeys = [tDict allKeys];
		
		
		if( [tDict objectForKey:@"Username"] && [[tDict objectForKey:@"Username"] rangeOfString:@"@"].length >0)
		{
			[mailAccts setObject:[[tDict objectForKey:@"Username"] lowercaseString] forKey:[[tDict objectForKey:@"Username"] lowercaseString] ];
		}
		else if([[tDict objectForKey:@"EmailAddresses"] objectAtIndex:0] && [[[tDict objectForKey:@"EmailAddresses"] objectAtIndex:0] rangeOfString:@"@"].length > 0) 
		{
			[mailAccts setObject: [[[tDict objectForKey:@"EmailAddresses"] objectAtIndex:0] lowercaseString] forKey:[[[tDict objectForKey:@"EmailAddresses"] objectAtIndex:0] lowercaseString]];
		}
		else {
			
			for(int i=0; i < [mykeys count]; i++)
			{
				if ([[tDict objectForKey:[mykeys objectAtIndex:i]] respondsToSelector:@selector(rangeOfString:)] && [[tDict objectForKey:[mykeys objectAtIndex:i]] rangeOfString:@"@"].length > 0) 
				{
					[mailAccts setObject:[[tDict objectForKey:[mykeys objectAtIndex:i]] lowercaseString] forKey:[[tDict objectForKey:[mykeys objectAtIndex:i]] lowercaseString] ];
				}
			}
		}

		
	}
	
	
	NSMutableArray *Keys = [NSMutableArray arrayWithArray: [mailAccts allKeys]];
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	
	
	for(NSString *temp in Keys)
	{
		[myAccounts addObject:temp];
		
		if([[prefs objectForKey:temp] respondsToSelector:@selector(intValue)])
		{
			[prefs removeObjectForKey:temp];
		}
		
		
		[prefs synchronize];
		
	}
	
	NSMutableDictionary *al = [prefs objectForKey:@"Aliases"];
	if (![prefs objectForKey:@"Aliases"] || ![[prefs objectForKey:@"Aliases"] respondsToSelector:@selector(objectForKey:)]) 
	{
		al = [[NSMutableDictionary alloc] init];
		[prefs setObject:al forKey:@"Aliases"];
		[prefs synchronize];
	}
	else {
		NSArray *keys = [al allKeys];
		
		for(NSString* temp in keys)
		{
			[aliases addObject:temp];
		}
	}

	
	
    [super viewDidLoad];
}

-(void)addA
{
	AlertPrompt *prompt = [AlertPrompt alloc];
    prompt = [prompt initWithTitle:@"Enter Email" message:@"\n" delegate:self cancelButtonTitle:@"Cancel" okButtonTitle:@"Enter"];
    [prompt show];
    [prompt release];
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != [alertView cancelButtonIndex])
    {
        NSString *entered = [(AlertPrompt *)alertView enteredText];
		NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
		if (![prefs objectForKey:entered]) 
		{
			NSMutableDictionary *aliasesA = [[NSMutableDictionary alloc] initWithDictionary:[prefs objectForKey:@"Aliases"]];;
			if([entered rangeOfString:@"@"].length > 0 )
			{
				[aliasesA setObject:[entered lowercaseString] forKey:[entered lowercaseString]];
			}
			[prefs setObject:aliasesA forKey:@"Aliases"];
			[prefs synchronize];
			[self viewDidLoad];
		}
		
    }
	
	[self.tableView reloadData];
}

- (void)showSettingsModal:(id)sender {
    UINavigationController *aNavController = [[UINavigationController alloc] initWithRootViewController:self.appSettingsViewController];
    //[viewController setShowCreditsFooter:NO];   // Uncomment to not display InAppSettingsKit credits for creators.
    // But we encourage you not to uncomment. Thank you!
    self.appSettingsViewController.showDoneButton = YES;
    [self.navigationController presentModalViewController:aNavController animated:YES];
    [aNavController release];
}

- (void)settingsViewControllerDidEnd:(IASKAppSettingsViewController*)sender {
    [self.navigationController dismissModalViewControllerAnimated:YES];
	
	// your code here to reconfigure the app for changed settings
}

#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
	if(section == 0)
	{
		return [myAccounts count];
	}
	else {
		return [aliases count];
	}



}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	NSString *CellIdentifier = @"";
	
	if (indexPath.section == 0) 
	{
		CellIdentifier = [myAccounts objectAtIndex:indexPath.row];
	}
	else {
		CellIdentifier = [aliases objectAtIndex:indexPath.row];
	}	
	
	ExampleCell * cell = (ExampleCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell = [[[ExampleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	if(indexPath.section == 0)
	{
		[[cell textLabel] setText:[myAccounts objectAtIndex:indexPath.row]];
	}
	else {
		[[cell textLabel] setText:[aliases objectAtIndex:indexPath.row]];
	}

	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	
	
	NSMutableDictionary	*colorInt = [[NSMutableDictionary alloc] init];
	
	if (indexPath.section == 1 && [aliases count] > indexPath.row)
	{
		colorInt = [prefs objectForKey:[aliases objectAtIndex:indexPath.row]];
	}
	else {
		colorInt = [prefs objectForKey:[myAccounts objectAtIndex:indexPath.row]];
	}

	
	if (colorInt && [[colorInt objectForKey:@"red"] respondsToSelector:@selector(floatValue)])
	{
		[[cell contentView] setBackgroundColor:[UIColor colorWithRed:[[colorInt objectForKey:@"red"] floatValue] green:[[colorInt objectForKey:@"green"] floatValue] 
															blue:[[colorInt objectForKey:@"blue"] floatValue] 
														   alpha:[[colorInt objectForKey:@"alpha"] floatValue]]];
	}
	else {
		[[cell contentView] setBackgroundColor:[UIColor whiteColor]];
	}

    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	if(section == 0)
		return @"Mail Accounts";
	else
		return @"Aliases";
}

- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle

forRowAtIndexPath:(NSIndexPath *)indexPath

{
	
    if (editingStyle == UITableViewCellEditingStyleDelete)
		
    {
		
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
		
		if (indexPath.section == 0) 
		{
			[prefs removeObjectForKey:[myAccounts objectAtIndex:indexPath.row]];
		}
		else
		{
			if (![prefs objectForKey:[aliases objectAtIndex:indexPath.row]]) 
			{
				NSMutableDictionary *myAliases = [[NSMutableDictionary alloc] initWithDictionary:[prefs objectForKey:@"Aliases"]];
				[myAliases removeObjectForKey:[aliases objectAtIndex:indexPath.row]];
				[prefs removeObjectForKey:[aliases objectAtIndex:indexPath.row]];
				[prefs setObject:myAliases forKey:@"Aliases"];
				[prefs synchronize];
				[aliases removeObjectAtIndex:indexPath.row];
			}
			else {
				[prefs removeObjectForKey:[aliases objectAtIndex:indexPath.row]];
			}

			
		}

		[prefs synchronize];
		[self viewDidLoad];
		[[self tableView] reloadData];
		
    }
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	viewController = [[ColorPickerViewController alloc] init];
	
	if (indexPath.section == 0) 
	{
		[viewController setEmail:[myAccounts objectAtIndex:indexPath.row]];
	}
	else {
		[viewController setEmail:[aliases objectAtIndex:indexPath.row]];
	}
	
	[viewController setAnIndex:indexPath];
	[self.navigationController presentModalViewController:viewController animated:YES];
	
}


static void completionCallback(SystemSoundID soundID, void * clientData) {
	AudioServicesRemoveSystemSoundCompletion(soundID);
}

/*
- (void)tableView:(UITableView *)tableView didSwipeCellAtIndexPath:(NSIndexPath *)indexPath {
	
	NSString * path = [[NSBundle mainBundle] pathForResource:@"tick" ofType:@"wav"];
	NSURL * fileURL = [NSURL fileURLWithPath:path isDirectory:NO];
	
	SystemSoundID soundID;
	AudioServicesCreateSystemSoundID((CFURLRef)fileURL, &soundID);
	AudioServicesPlaySystemSound(soundID);
	AudioServicesAddSystemSoundCompletion (soundID, NULL, NULL, completionCallback, NULL);
}
*/
/*
- (void)scrollViewDidScroll:(UIScrollView*)scrollView {
	[(TISwipeableTableView*)self.tableView hideVisibleBackView:NO];
}
*/
- (void)dealloc {
	[aliases release];
	[appSettingsViewController release];
	appSettingsViewController = nil;
	[super dealloc];
}

@end

