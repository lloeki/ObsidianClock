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
    //NSColor *color;
    if([_menuExtra isMenuDown]) {
        textColor = [NSColor selectedMenuItemTextColor];
        //color = [NSColor selectedMenuItemColor];
    } else {
        textColor =  [NSColor lightGrayColor];
        //color = [NSColor blackColor];
    }
    
    // Disable LCD subpixel smoothing
    CGContextSetShouldSmoothFonts([[NSGraphicsContext currentContext] graphicsPort], false);
    
    NSDictionary *attr = [NSDictionary dictionaryWithObjectsAndKeys: font, NSFontAttributeName,
                                                                     textColor, NSForegroundColorAttributeName,
                                                                     //color, NSBackgroundColorAttributeName,
                                                                     nil];
    
    // Draw    
    NSRect smallerRect = NSMakeRect(1, 0, rect.size.width-1, rect.size.height-1);
    [text drawInRect:smallerRect withAttributes:attr];
}

- (void)setFont
{
    // Get the font right
    font = [NSFont menuBarFontOfSize: 14];
    font = [[NSFontManager sharedFontManager] convertFont:font toHaveTrait:NSBoldFontMask];
}

- (double)computeLength
{
    NSMutableDictionary * fontAttributes = [[NSMutableDictionary alloc] init];
    [fontAttributes setObject:font forKey:NSFontAttributeName];
    CGSize boundingBox = [text sizeWithAttributes:fontAttributes];
    //NSLog(@"Clock Size: %.0f %.0f", boundingBox.width, boundingBox.height);
    return boundingBox.width+2;
}

- (void)dealloc
{
    [text dealloc];
    [super dealloc];
}

@end
