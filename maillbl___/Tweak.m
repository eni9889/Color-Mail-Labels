#import <CaptainHook/CaptainHook.h>
#import <UIKit/UIKit.h>
#import <SpringBoard/SpringBoard.h>
#import "ExampleCell.h"
#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>

#define kConfigPath @"/var/mobile/Library/Preferences/com.UnlimApps.MailLabels.plist"
#define kLinesPath @"/var/mobile/Library/Preferences/com.apple.mobilemail.plist"


CHDeclareClass(MailboxContentViewCell);
CHDeclareClass(MailboxPickerController);
CHDeclareClass(MailboxContentViewController);
CHDeclareClass(ML3MusicLibraryImpl);

@interface OutboxTableCell : NSObject
@end

CHMethod(2, void, MailboxContentViewCell,initWithStyle,int,fp8,reuseIdentifier,id,fp12)
{	
	CHSuper(2,MailboxContentViewCell,initWithStyle,fp8,reuseIdentifier,fp12);
	NSDictionary *config = [NSDictionary dictionaryWithContentsOfFile: kConfigPath];
	NSDictionary *configLines = [NSDictionary dictionaryWithContentsOfFile: kLinesPath];
	int	colorInt = [[config objectForKey:@"mail_label_style"] intValue];
	int	lineInt = [[configLines objectForKey:@"LinesOfPreview"] intValue];
	if(![[configLines objectForKey:@"LinesOfPreview"] respondsToSelector:@selector(intValue)])
	{
		lineInt = 2;
	}

	UIView *mView = (UIView*)[self viewWithTag:333];
	
	if (!mView) 
	{
		UIView *extra;
		switch (colorInt) {
			case 1:
				
				if (lineInt == 0) {
					extra = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, [(UIView *)self frame].size.height)];
					extra.tag = 333;
				}
				else {
					extra = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, [(UIView *)self frame].size.height + (lineInt * 15.00f) + 4)];
					extra.tag = 333;
				}
				
				//[extra setAlpha:.6f];
				break;
			case 2:
				extra = [[UIView alloc] initWithFrame:CGRectMake(11.5f, 8, 10, 10)];
				extra.tag = 333;
				extra.layer.cornerRadius = 6;
				//[extra setAlpha:1.0f];
				break;
			case 3:
				extra = [[UIView alloc] initWithFrame:CGRectMake([(UIView *)self frame].size.width - 20, 9.0, 10, 10)];
				extra.tag = 333;
				extra.layer.cornerRadius = 6;
				[extra setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin || UIViewAutoresizingFlexibleLeftMargin];
				break;
			case 6:
				if (lineInt == 0) {
					extra = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [(UIView *)self frame].size.width, [(UIView *)self frame].size.height)];
					extra.tag = 333;
				}
				else {
					extra = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [(UIView *)self frame].size.width, [(UIView *)self frame].size.height + (lineInt * 15.00f) + 4)];
					extra.tag = 333;
				}
				[extra setAlpha:.3];
				[extra setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
				break;
			case 7:
				extra = [[UIView alloc] initWithFrame:CGRectMake([(UIView *)self frame].size.width - 20, 9.0, 10, 10)];
				extra.tag = 333;
				[extra setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin || UIViewAutoresizingFlexibleLeftMargin];
				break;
            case 8:
				
				if (lineInt == 0) {
					extra = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, [(UIView *)self frame].size.height)];
					extra.tag = 333;
				}
				else {
					extra = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, [(UIView *)self frame].size.height + (lineInt * 15.00f) + 4)];
					extra.tag = 333;
				}
				
				//[extra setAlpha:.6f];
				break;
			default:
				extra = [[UIView alloc] initWithFrame:CGRectMake(11.5f, 8, 10, 10)];
				extra.tag = 333;
				//[extra setAlpha:1.0f];
				break;
		}
		[self addSubview:extra];
	}
	
}

CHMethod(2, void, MailboxContentViewCell,setMessage,id,fp8,threaded,BOOL,fp12)
{	
	CHSuper(2,MailboxContentViewCell,setMessage,fp8,threaded,fp12);
	
	NSDictionary *config = [NSDictionary dictionaryWithContentsOfFile: kConfigPath];
	NSMutableDictionary	*colorInt = [config objectForKey:[[[fp8 account] firstEmailAddress] lowercaseString] ];
	id *wantAl = [config objectForKey:@"main_mailbox_color_aliases"];
	int	optionInt = [[config objectForKey:@"mail_label_style"] intValue];
	
	if ([[self subviews] indexOfObject:(UIView*)[self viewWithTag:333]] != 0 && optionInt!=6) 
	{
		[self sendSubviewToBack:(UIView*)[self viewWithTag:333]];
		
	} else if (optionInt == 6)
	{
		[self bringSubviewToFront:(UIView*)[self viewWithTag:333]];	
	}

	
	if([config objectForKey:@"main_mailbox_color_aliases"] && [wantAl intValue] == 1)
	{
		colorInt = nil;
		id to = [fp8 valueForKeyPath:@"_to"];
		id cc = [fp8 valueForKeyPath:@"_cc"];
		id from = [fp8 valueForKeyPath:@"_sender"];
			//CHLog(@"The sender is: %@", from);
		
		NSString *toS = @"";
		
		
		if ([from count] > 0) 
			{
				toS = [from objectAtIndex:0];
				
				NSArray *sString = [toS componentsSeparatedByString:@"<"];
				if ([sString count] > 1) 
				{
					sString = [[sString objectAtIndex:1] componentsSeparatedByString:@">"];
					
					if ([sString count]>1) {
						toS = [sString objectAtIndex:0];
					}
				}
				//CHLog(@"The clean sender is: %@", toS);
				colorInt = [config objectForKey:[toS lowercaseString] ];
				
			}
			
			else if ([to count] > 0) {
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
	
	
	UIView *extra = (UIView*)[self viewWithTag:333];
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
		case 6:
			extra = (UIView*)[self viewWithTag:333];
			break;
		default:
			extra = (UIView*)[self viewWithTag:333];
			break;
	}
	
	
	if (![colorInt objectForKey:@"red"] || optionInt == 4 || optionInt == 5) 
	{
		if (optionInt == 6) {
			[extra setAlpha:0.0f];
		}
		[extra setBackgroundColor:[UIColor whiteColor]];
	}
	else
	{
		if (optionInt == 6) {
			[extra setAlpha:0.3f];
		}
		[extra setBackgroundColor:[UIColor colorWithRed:[[colorInt objectForKey:@"red"] floatValue] green:[[colorInt objectForKey:@"green"] floatValue] blue:[[colorInt objectForKey:@"blue"] floatValue] alpha:[[colorInt objectForKey:@"alpha"] floatValue]]];
	}
	
}

//Testing new method

CHMethod(2, id, MailboxPickerController,tableView,id,fp8,cellForRowAtIndexPath,id,fp12)
{	
    
	id *cell = CHSuper(2,MailboxPickerController,tableView,fp8,cellForRowAtIndexPath,fp12);
	//NSLog(@"The cell is: %@", cell);
    
    if ([cell respondsToSelector:@selector(setAccounts:)])
    {
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
			id from = [[self message] valueForKeyPath:@"_sender"];
			//CHLog(@"The sender is: %@", from);
			
			NSString *toS = @"";
			
			if ([from count] > 0) 
			{
				toS = [from objectAtIndex:0];
				
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
			
			else if ([to count] > 0) 
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
	return cell;
}

CHMethod(2, id, ML3MusicLibraryImpl,insertItemFromPurchaseFolder,id,purchaseFolder,withItemProperties,id,itemProperties)
{	
	id *cell = CHSuper(2,ML3MusicLibraryImpl,insertItemFromPurchaseFolder,purchaseFolder,withItemProperties,itemProperties);
	CHLog(@"This was actually called YAY!");
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
	
	CHLoadLateClass(ML3MusicLibraryImpl);
	CHHook(2, ML3MusicLibraryImpl, insertItemFromPurchaseFolder,withItemProperties);

}