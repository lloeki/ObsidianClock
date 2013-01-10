//
//  SampleMenuExtraView.m
//  MenuExtra
//
//  Created by Loic Nageleisen on 07/01/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ClockMenuExtraView.h"


@implementation ClockMenuExtraView

@synthesize text;

- (void)drawRect:(NSRect)rect
{
    NSColor *textColor;
    NSColor *backColor;
    if([_menuExtra isMenuDown]) {
        textColor = [NSColor selectedMenuItemTextColor];
        switch ([NSColor currentControlTint]) {
            case NSGraphiteControlTint:
                backColor = [NSColor colorWithDeviceRed:0.3333333333333333f green:0.36470588235294116f blue:0.40784313725490196f alpha:1.0f];
                break;
            case NSBlueControlTint:
                backColor = [NSColor colorWithDeviceRed:0.18823529411764706f green:0.24705882352941178f blue:0.9176470588235294f alpha:1.0f];
                break;
            default:
                backColor = [NSColor colorWithDeviceRed:0.0f green:0.0f blue:0.0f alpha:0.0f];
                break;
        }
    } else {
        textColor =  [NSColor lightGrayColor];
        backColor = [NSColor colorWithDeviceRed:0.0f green:0.0f blue:0.0f alpha:0.0f];
    }
    
    // Disable LCD subpixel smoothing
    CGContextSetShouldSmoothFonts([[NSGraphicsContext currentContext] graphicsPort], false);
    
    NSDictionary *attr = [NSDictionary dictionaryWithObjectsAndKeys: font, NSFontAttributeName,
                                                                     textColor, NSForegroundColorAttributeName,
                                                                     backColor, NSBackgroundColorAttributeName,
                                                                     nil];
    
    // Draw
    [backColor set];
    [NSBezierPath fillRect:rect];
    NSRect smallerRect = NSMakeRect(1, 0, rect.size.width-1, rect.size.height-1);
    [text drawInRect:smallerRect withAttributes:attr];
}

- (void)setFont
{
    // Get the font right
    font = [NSFont menuBarFontOfSize: 14];
    // Making it bold crashes?
    //font = [[NSFontManager sharedFontManager] convertWeight:YES ofFont:font];
    //font = [[NSFontManager sharedFontManager] convertFont:font toHaveTrait:NSBoldFontMask];
}

- (void)dealloc
{
    [text dealloc];
    [super dealloc];
}

@end
