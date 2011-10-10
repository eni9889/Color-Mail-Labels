#import <CaptainHook/CaptainHook.h>
#import <UIKit/UIKit.h>
#import <SpringBoard/SpringBoard.h>
#import "ExampleCell.h"
#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>

#define kConfigPath @"/var/mobile/Library/Preferences/com.UnlimApps.MailLabels.plist"

CHDeclareClass(MailboxContentViewCell);
CHDeclareClass(MailboxPickerController);
CHDeclareClass(MailboxContentViewController);


CHMethod(2, void, MailboxContentViewCell,initWithStyle,int,fp8,reuseIdentifier,id,fp12)
{	
	
	CHSuper(2,MailboxContentViewCell,initWithStyle,fp8,reuseIdentifier,fp12);
	
	NSDictionary *config = [NSDictionary dictionaryWithContentsOfFile: kConfigPath];
	int	colorInt = [[config objectForKey:@"mail_label_style"] intValue];
	UIView *extra;
	
	
	switch (colorInt) {
		case 1:
			extra = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, [(UIView *)self frame].size.height*1.75f)];
			//[extra setAlpha:.6f];
			break;
		case 2:
			extra = [[UIView alloc] initWithFrame:CGRectMake(11.5f, 8, 10, 10)];
			extra.layer.cornerRadius = 6;
			//[extra setAlpha:1.0f];
			break;
		default:
			extra = [[UIView alloc] initWithFrame:CGRectMake(11.5f, 8, 10, 10)];
			//[extra setAlpha:1.0f];
			break;
	}
	if ([[(UIView*)self subviews] count] == 1) 
	{
		[self insertSubview:extra atIndex:0];
	}
	else {
		[self replaceObjectAtIndex:0 withObject:extra];
	}
	
}

CHMethod(2, void, MailboxContentViewCell,setMessage,id,fp8,threaded,BOOL,fp12)
{	
	CHSuper(2,MailboxContentViewCell,setMessage,fp8,threaded,fp12);
	NSDictionary *config = [NSDictionary dictionaryWithContentsOfFile: kConfigPath];
	NSMutableDictionary	*colorInt = [config objectForKey:[[[fp8 account] firstEmailAddress] lowercaseString] ];
	id *wantAl = [config objectForKey:@"main_mailbox_color_aliases"];
	
	if([config objectForKey:@"main_mailbox_color_aliases"] && [wantAl intValue] == 1)
	{
		colorInt = nil;
		id to = [fp8 valueForKeyPath:@"_to"];
		id cc = [fp8 valueForKeyPath:@"_cc"];
		
		NSString *toS = @"";
		if ([to count] > 0) {
			toS = [to objectAtIndex:0];
			NSArray *sString = [toS componentsSeparatedByString:@"<"];
			if ([sString count] > 1) 
			{
				sString = [[sString objectAtIndex:1] componentsSeparatedByString:@">"];
				
				if ([sString count]>1) {
					toS = [sString objectAtIndex:0];
				}
			}
			
			colorInt = [config objectForKey:[toS lowercaseString]];
			
		}
		else if ([cc count] > 0)
		{
			toS = [cc objectAtIndex:0];
			NSArray *sString = [toS componentsSeparatedByString:@"<"];
			if ([sString count] > 1) 
			{
				sString = [[sString objectAtIndex:1] componentsSeparatedByString:@">"];
				
				if ([sString count]>1) {
					toS = [sString objectAtIndex:0];
				}
			}
			
			colorInt = [config objectForKey:[toS lowercaseString]];
		}

		
		if (![colorInt respondsToSelector:@selector(objectForKey:)])
		{
			colorInt = [config objectForKey:[[[fp8 account] firstEmailAddress] lowercaseString] ];
		}
		
	}
	
	
	
	int	optionInt = [[config objectForKey:@"mail_label_style"] intValue];
	
	UIView *extra = [[self subviews] objectAtIndex:0 ];
	id y;
	switch (optionInt)
	{
		case 4:
			y = [self valueForKeyPath:@"_dateLabel"];
			if ([colorInt objectForKey:@"red"]) 
			{
				[y setTextColor:[UIColor colorWithRed:[[colorInt objectForKey:@"red"] floatValue] green:[[colorInt objectForKey:@"green"] floatValue] blue:[[colorInt objectForKey:@"blue"] floatValue] alpha:[[colorInt objectForKey:@"alpha"] floatValue]]];
			}
			else {
				[y setTextColor:[UIColor colorWithRed:0.141176 green:0.439216 blue:0.847059 alpha:1.0]];
				
			}
			break;
		case 3:
			y = [self valueForKeyPath:@"_dataLayer"];
			
			if ([[y subviews] count] == 0) 
			{
				extra = [[UIView alloc] initWithFrame:CGRectMake([(UIView*)y frame].size.width, 8, 10, 10)];
				extra.layer.cornerRadius = 6;
				[extra setAlpha:1.0f];
				[y addSubview:extra];
			}
			else {
				extra = [[y subviews] objectAtIndex:0];
			}
			break;
		default:
			extra = [[self subviews] objectAtIndex:0 ];
			break;
	}
	
	if (![colorInt objectForKey:@"red"] || optionInt == 4 || optionInt == 5) 
	{
		[extra setBackgroundColor:[UIColor whiteColor]];
	}
	else 
	{
		[extra setBackgroundColor:[UIColor colorWithRed:[[colorInt objectForKey:@"red"] floatValue] green:[[colorInt objectForKey:@"green"] floatValue] blue:[[colorInt objectForKey:@"blue"] floatValue] alpha:[[colorInt objectForKey:@"alpha"] floatValue]]];
	}
	
	
}

//Testing new method

CHMethod(2, id, MailboxPickerController,tableView,id,fp8,cellForRowAtIndexPath,id,fp12)
{	
	id *cell = CHSuper(2,MailboxPickerController,tableView,fp8,cellForRowAtIndexPath,fp12);
	id x = [cell valueForKeyPath:@"_accountTextLabel"];
	NSDictionary *config = [NSDictionary dictionaryWithContentsOfFile: kConfigPath];
	id y = [cell valueForKeyPath:@"_accounts"];
	NSArray *myArray = [y allObjects];
	NSMutableDictionary	*colorInt = [config objectForKey:[[[myArray objectAtIndex:0] firstEmailAddress] lowercaseString] ];
	
	id *wantColor = [config objectForKey:@"main_mailbox_color_lbl"];
		
	if ([fp12 section] == 1 && [wantColor intValue]==1 && [colorInt objectForKey:@"red"])
	{
		[x setTextColor:[UIColor colorWithRed:[[colorInt objectForKey:@"red"] floatValue] green:[[colorInt objectForKey:@"green"] floatValue] blue:[[colorInt objectForKey:@"blue"] floatValue] alpha:[[colorInt objectForKey:@"alpha"] floatValue]]];
				
	}
	else {
		[x setTextColor:[UIColor blackColor]];

	}

		return cell;
}

CHMethod(1, struct CGRect, MailboxContentViewCell,_dateLabelFrame,struct CGRect,fp8)
{	
	
	NSDictionary *config = [NSDictionary dictionaryWithContentsOfFile: kConfigPath];
	int	optionInt = [[config objectForKey:@"mail_label_style"] intValue];
	id *wantAl = [config objectForKey:@"main_mailbox_color_aliases"];
	
	if (optionInt == 5)
	{
		NSMutableDictionary	*colorInt = [config objectForKey:[[[[self message] account] firstEmailAddress] lowercaseString] ];
		
		if([config objectForKey:@"main_mailbox_color_aliases"] && [wantAl intValue] == 1)
		{
			colorInt =nil;
			id to = [[self message] valueForKeyPath:@"_to"];
			id cc = [[self message] valueForKeyPath:@"_cc"];
			
			NSString *toS = @"";
			
			if ([to count] > 0) 
			{
				toS = [to objectAtIndex:0];
				
				NSArray *sString = [toS componentsSeparatedByString:@"<"];
				if ([sString count] > 1) 
				{
					sString = [[sString objectAtIndex:1] componentsSeparatedByString:@">"];
					
					if ([sString count]>1) {
						toS = [sString objectAtIndex:0];
					}
				}
				
				colorInt = [config objectForKey:[toS lowercaseString] ];
				
			}
			else if([cc count] > 0)
			{
				toS = [cc objectAtIndex:0];
				
				NSArray *sString = [toS componentsSeparatedByString:@"<"];
				if ([sString count] > 1) 
				{
					sString = [[sString objectAtIndex:1] componentsSeparatedByString:@">"];
					
					if ([sString count]>1) {
						toS = [sString objectAtIndex:0];
					}
				}
				
				colorInt = [config objectForKey:[toS lowercaseString] ];
			}
			
			if (!colorInt)
			{
				colorInt = [config objectForKey:[[[[self message] account] firstEmailAddress] lowercaseString] ];
			}
		}
		
		UIView *y = [self valueForKeyPath:@"_dateLabel"];	
		
		if ([[y subviews] count] == 0)
		{
			UIView *test = [[UIView alloc] initWithFrame:CGRectMake(0,0,y.frame.size.width,y.frame.size.height)];
			test.layer.cornerRadius = 3;
			[test setAlpha:.30];
			[y addSubview:test];
		}
		
		[[[y subviews] objectAtIndex:0] setBackgroundColor:[UIColor colorWithRed:[[colorInt objectForKey:@"red"] floatValue] green:[[colorInt objectForKey:@"green"] floatValue] blue:[[colorInt objectForKey:@"blue"] floatValue] alpha:[[colorInt objectForKey:@"alpha"] floatValue]]];
		[y bringSubviewToFront:[[y subviews] objectAtIndex:0]];
		
		if ([[[y subviews] objectAtIndex:0] frame].size.width != y.frame.size.width) {
			CGRect frame = [[[y subviews] objectAtIndex:0] frame]; 
			frame.size.width = y.frame.size.width; 
			frame.size.height = y.frame.size.height; 
			[[[y subviews] objectAtIndex:0] setFrame:frame];
		}
	}
	return CHSuper(1,MailboxContentViewCell,_dateLabelFrame,fp8);
		
}

CHMethod(2, id, MailboxContentViewController,tableView,id,fp8,cellForRowAtIndexPath,id,fp12)
{	
	id *cell = CHSuper(2,MailboxContentViewController,tableView,fp8,cellForRowAtIndexPath,fp12);
	//[cell bringSubviewToFront:[cell valueForKeyPath:@"_dateLabel"]];
	return cell;
}

CHConstructor
{		
	CHLoadLateClass(MailboxContentViewCell);
	CHHook(2, MailboxContentViewCell, initWithStyle,reuseIdentifier);
	CHHook(2, MailboxContentViewCell, setMessage,threaded);	
	CHHook(1, MailboxContentViewCell, _dateLabelFrame);	
		
	CHLoadLateClass(MailboxPickerController);
	CHHook(2, MailboxPickerController, tableView,cellForRowAtIndexPath);
	
	CHLoadLateClass(MailboxContentViewController);
	CHHook(2, MailboxContentViewController, tableView,cellForRowAtIndexPath);
	
}

