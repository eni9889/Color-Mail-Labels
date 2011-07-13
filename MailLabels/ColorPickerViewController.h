//
//  ColorPickerViewController.h
//  ColorPicker
//
//  Created by Gilly Dekel on 23/3/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AboutScreenViewController;

@interface ColorPickerViewController : UIViewController {
	AboutScreenViewController *aboutScreenViewController;
	NSString *email;
	NSIndexPath *anIndex;
}

@property (nonatomic, retain) AboutScreenViewController * aboutScreenViewController;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSIndexPath *anIndex;

- (UIColor *) getSelectedColor;

- (IBAction) pressedAboutButton;
- (IBAction) pressedCButton;
@end

