//
//  GradientView.h
//  ColorPicker
//
//  Created by Gilly Dekel on 23/3/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GradientView : UIView {
	CGGradientRef gradient;
	CGColorRef theColor;
}

@property (readwrite) CGColorRef theColor;
- (void) setupGradient;
@end
