//
//  ExampleCell.m
//  SwipeableExample
//
//  Created by Tom Irving on 16/06/2010.
//  Copyright 2010 Tom Irving. All rights reserved.
//

#import "ExampleCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation ExampleCell
@synthesize text;

- (void)setText:(NSString *)aString {
	
	if (aString != text){
		[text release];
		text = [aString retain];
		[self setNeedsDisplay];
	}
}

- (void)buttonWasTapped:(UIButton *)button {
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	[prefs setInteger:button.tag forKey:[self reuseIdentifier]];
	[prefs synchronize];
	
	int	colorInt = [[prefs objectForKey:[self reuseIdentifier]] intValue];
	
	switch (colorInt) {
		case 1:
			[[self contentView] setBackgroundColor:[UIColor blueColor]];
			break;
		case 2:
			[[self contentView] setBackgroundColor:[UIColor redColor]];
			break;
		case 3:
			[[self contentView] setBackgroundColor:[UIColor greenColor]];
			break;
		case 4:
			[[self contentView] setBackgroundColor:[UIColor yellowColor]];
			break;
		case 5:
			[[self contentView] setBackgroundColor:[UIColor purpleColor]];
			break;
		case 6:
			[[self contentView] setBackgroundColor:[UIColor orangeColor]];
			break;
		case 7:
			[[self contentView] setBackgroundColor:[UIColor lightGrayColor]];
			break;
		case 8:
			[[self contentView] setBackgroundColor:[UIColor whiteColor]];
			break;
		case 9:
			[[self contentView] setBackgroundColor:[UIColor blackColor]];
			break;
		case 10:
			[[self contentView] setBackgroundColor:[UIColor magentaColor]];
			break;
		default:
			[[self contentView] setBackgroundColor:[UIColor clearColor]];
			break;
	}
	
		
}

- (void)backViewWillAppear {
	
	UIScrollView *theScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
	[theScroll setContentSize:CGSizeMake(self.frame.size.width*2, self.frame.size.height)];
	
	//Blue Button
	UIButton * blue = [UIButton buttonWithType:UIButtonTypeCustom];
	blue.tag = 1;
	[blue setShowsTouchWhenHighlighted:YES];
	[blue addTarget:self action:@selector(buttonWasTapped:) forControlEvents:UIControlEventTouchUpInside];
	[blue setFrame:CGRectMake(20, 8, 40, self.backView.frame.size.height - 16)];
	[blue setBackgroundColor:[UIColor blueColor]];
	blue.layer.cornerRadius = 6.0;
	[theScroll addSubview:blue];
	
	//Red Button
	UIButton * red = [UIButton buttonWithType:UIButtonTypeCustom];
	red.tag = 2;
	[red setShowsTouchWhenHighlighted:YES];
	[red addTarget:self action:@selector(buttonWasTapped:) forControlEvents:UIControlEventTouchUpInside];
	[red setFrame:CGRectMake(80, 8, 40, self.backView.frame.size.height - 16)];
	[red setBackgroundColor:[UIColor redColor]];
	red.layer.cornerRadius = 6.0;
	[theScroll addSubview:red];
	
	//Green Button
	UIButton * green = [UIButton buttonWithType:UIButtonTypeCustom];
	green.tag = 3;
	[green setShowsTouchWhenHighlighted:YES];
	[green addTarget:self action:@selector(buttonWasTapped:) forControlEvents:UIControlEventTouchUpInside];
	[green setFrame:CGRectMake(140, 8, 40, self.backView.frame.size.height - 16)];
	[green setBackgroundColor:[UIColor greenColor]];
	green.layer.cornerRadius = 6.0;
	[theScroll addSubview:green];
	
	//yellow Button
	UIButton * yellow = [UIButton buttonWithType:UIButtonTypeCustom];
	yellow.tag = 4;
	[yellow setShowsTouchWhenHighlighted:YES];
	[yellow addTarget:self action:@selector(buttonWasTapped:) forControlEvents:UIControlEventTouchUpInside];
	[yellow setFrame:CGRectMake(200, 8, 40, self.backView.frame.size.height - 16)];
	[yellow setBackgroundColor:[UIColor yellowColor]];
	yellow.layer.cornerRadius = 6.0;
	[theScroll addSubview:yellow];
	
	//purple Button
	UIButton * purple = [UIButton buttonWithType:UIButtonTypeCustom];
	purple.tag = 5;
	[purple setShowsTouchWhenHighlighted:YES];
	[purple addTarget:self action:@selector(buttonWasTapped:) forControlEvents:UIControlEventTouchUpInside];
	[purple setFrame:CGRectMake(260, 8, 40, self.backView.frame.size.height - 16)];
	[purple setBackgroundColor:[UIColor purpleColor]];
	purple.layer.cornerRadius = 6.0;
	[theScroll addSubview:purple];
	
	//orange Button
	UIButton * orange = [UIButton buttonWithType:UIButtonTypeCustom];
	orange.tag = 6;
	[orange setShowsTouchWhenHighlighted:YES];
	[orange addTarget:self action:@selector(buttonWasTapped:) forControlEvents:UIControlEventTouchUpInside];
	[orange setFrame:CGRectMake(320, 8, 40, self.backView.frame.size.height - 16)];
	[orange setBackgroundColor:[UIColor orangeColor]];
	orange.layer.cornerRadius = 6.0;
	[theScroll addSubview:orange];
	
	//lightGray Button
	UIButton * lightGray = [UIButton buttonWithType:UIButtonTypeCustom];
	lightGray.tag = 7;
	[lightGray setShowsTouchWhenHighlighted:YES];
	[lightGray addTarget:self action:@selector(buttonWasTapped:) forControlEvents:UIControlEventTouchUpInside];
	[lightGray setFrame:CGRectMake(380, 8, 40, self.backView.frame.size.height - 16)];
	[lightGray setBackgroundColor:[UIColor lightGrayColor]];
	lightGray.layer.cornerRadius = 6.0;
	[theScroll addSubview:lightGray];
	
	//white Button
	UIButton * white = [UIButton buttonWithType:UIButtonTypeCustom];
	white.tag = 8;
	[white setShowsTouchWhenHighlighted:YES];
	[white addTarget:self action:@selector(buttonWasTapped:) forControlEvents:UIControlEventTouchUpInside];
	[white setFrame:CGRectMake(440, 8, 40, self.backView.frame.size.height - 16)];
	[white setBackgroundColor:[UIColor whiteColor]];
	white.layer.cornerRadius = 6.0;
	[theScroll addSubview:white];
	
	//black Button
	UIButton * black = [UIButton buttonWithType:UIButtonTypeCustom];
	black.tag = 9;
	[black setShowsTouchWhenHighlighted:YES];
	[black addTarget:self action:@selector(buttonWasTapped:) forControlEvents:UIControlEventTouchUpInside];
	[black setFrame:CGRectMake(500, 8, 40, self.backView.frame.size.height - 16)];
	[black setBackgroundColor:[UIColor blackColor]];
	black.layer.cornerRadius = 6.0;
	[theScroll addSubview:black];
	
	//magenta Button
	UIButton * magenta = [UIButton buttonWithType:UIButtonTypeCustom];
	magenta.tag = 10;
	[magenta setShowsTouchWhenHighlighted:YES];
	[magenta addTarget:self action:@selector(buttonWasTapped:) forControlEvents:UIControlEventTouchUpInside];
	[magenta setFrame:CGRectMake(560, 8, 40, self.backView.frame.size.height - 16)];
	[magenta setBackgroundColor:[UIColor magentaColor]];
	magenta.layer.cornerRadius = 6.0;
	[theScroll addSubview:magenta];
	
	[self.backView addSubview:theScroll];
	
}

- (void)backViewDidDisappear {
	// Remove any subviews from the backView.
	
	for (UIView * subview in self.backView.subviews){
		[subview removeFromSuperview];
	}
}

- (void)drawContentView:(CGRect)rect {
	
	UIColor * textColour = [UIColor blackColor];
	
	if (self.selected) {
		textColour = [UIColor whiteColor];
		[[UIImage imageNamed:@"selectiongradient.png"] drawInRect:rect];
	}
	
	[textColour set];
	
	UIFont * textFont = [UIFont boldSystemFontOfSize:22];
	
	CGSize textSize = [text sizeWithFont:textFont constrainedToSize:rect.size];
	[text drawInRect:CGRectMake((rect.size.width / 2) - (textSize.width / 2), 
								(rect.size.height / 2) - (textSize.height / 2),
								textSize.width, textSize.height)
			withFont:textFont];
}

- (void)drawBackView:(CGRect)rect {
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	[[UIImage imageNamed:@"meshpattern.png"] drawAsPatternInRect:rect];
	[self drawShadowsWithHeight:10 opacity:0.3 InRect:rect forContext:context];
}

- (void)drawShadowsWithHeight:(CGFloat)shadowHeight opacity:(CGFloat)opacity InRect:(CGRect)rect forContext:(CGContextRef)context {
	
	CGColorSpaceRef space = CGBitmapContextGetColorSpace(context);
	
	CGFloat topComponents[8] = {0, 0, 0, opacity, 0, 0, 0, 0};
	CGGradientRef topGradient = CGGradientCreateWithColorComponents(space, topComponents, nil, 2);
	CGPoint finishTop = CGPointMake(rect.origin.x, rect.origin.y + shadowHeight);
	CGContextDrawLinearGradient(context, topGradient, rect.origin, finishTop, kCGGradientDrawsAfterEndLocation);
	
	CGFloat bottomComponents[8] = {0, 0, 0, 0, 0, 0, 0, opacity};
	CGGradientRef bottomGradient = CGGradientCreateWithColorComponents(space, bottomComponents, nil, 2);
	CGPoint startBottom = CGPointMake(rect.origin.x, rect.size.height - shadowHeight);
	CGPoint finishBottom = CGPointMake(rect.origin.x, rect.size.height);
	CGContextDrawLinearGradient(context, bottomGradient, startBottom, finishBottom, kCGGradientDrawsAfterEndLocation);
	
	CGGradientRelease(topGradient);
	CGGradientRelease(bottomGradient);
}

- (void)dealloc {
	
	[text release];
    [super dealloc];
}

@end
