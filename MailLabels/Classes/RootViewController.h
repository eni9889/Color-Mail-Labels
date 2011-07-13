//
//  RootViewController.h
//  SwipeableExample
//
//  Created by Tom Irving on 16/06/2010.
//  Copyright Tom Irving 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExampleCell.h"
#import "IASKSpecifier.h"
#import "IASKSettingsReader.h"
#import "IASKAppSettingsViewController.h"

@class ColorPickerViewController;

@interface RootViewController : UITableViewController <IASKSettingsDelegate>
{
	NSMutableArray *myAccounts;
	NSMutableArray *aliases;
	IASKAppSettingsViewController *appSettingsViewController;
	ColorPickerViewController *viewController;
}

@property (nonatomic, retain) NSMutableArray *myAccounts;
@property (nonatomic, retain) NSMutableArray *aliases;
@property (nonatomic, retain) IASKAppSettingsViewController *appSettingsViewController;
@property (nonatomic, retain) IBOutlet ColorPickerViewController *viewController;

@end
