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
    NSColor *color;
    if([_menuExtra isMenuDown]) {
        color = [NSColor selectedMenuItemTextColor];
    } else {
        color =  [NSColor lightGrayColor];
    }
    
    // Disable LCD subpixel smoothing
    CGContextSetShouldSmoothFonts([[NSGraphicsContext currentContext] graphicsPort], false);
    
    // Get the font right
    NSFont *font = [NSFont menuBarFontOfSize: 14];
    font = [[NSFontManager sharedFontManager] convertFont:font toHaveTrait:NSBoldFontMask];
    
    NSDictionary *attr = [NSDictionary dictionaryWithObjectsAndKeys: font, NSFontAttributeName, color, NSForegroundColorAttributeName, nil];
    
    // Draw
    NSRect smallerRect = NSMakeRect(1, 0, rect.size.width-1, rect.size.height-1);
    [text drawInRect:smallerRect withAttributes:attr];
}

- (void)dealloc
{
    [text dealloc];
    [super dealloc];
}

@end
