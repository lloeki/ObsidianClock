//
//  ClockMenuExtraView.m
//  MenuExtra
//
//  Created by Loic Nageleisen on 07/01/2011.
//  Copyright 2011 Loic Nageleisen. All rights reserved.
//

#import "ClockMenuExtraView.h"


@implementation ClockMenuExtraView

- (NSColor *)titleBackgroundColor {
    if([_menuExtra isMenuDown]) {
        switch ([NSColor currentControlTint]) {
            case NSGraphiteControlTint:
                return [NSColor colorWithDeviceRed:0.3333333333333333f
                                             green:0.36470588235294116f
                                              blue:0.40784313725490196f
                                             alpha:1.0f];
            case NSBlueControlTint:
                return [NSColor colorWithDeviceRed:0.18823529411764706f
                                             green:0.24705882352941178f
                                              blue:0.9176470588235294f
                                             alpha:1.0f];
            default:
                return [NSColor colorWithDeviceRed:0.0f
                                             green:0.0f
                                              blue:0.0f
                                             alpha:0.0f];
        }
    } else {
        return [NSColor colorWithDeviceRed:0.0f
                                     green:0.0f
                                      blue:0.0f
                                     alpha:0.0f];
    }

}

- (NSColor *)titleForegroundColor {
    if ([_menuExtra isMenuDown]) {
        return [NSColor selectedMenuItemTextColor];
    }
    else {
        //return [NSColor blackColor];
        return [NSColor lightGrayColor]; // maxtheme obsidian menubar
    }
}

- (NSDictionary *)titleAttributes {
    NSFont *font = [NSFont menuBarFontOfSize:0];
    
    NSColor *foregroundColor = [self titleForegroundColor];
    NSColor *backgroundColor = [self titleBackgroundColor];
    
    return [NSDictionary dictionaryWithObjectsAndKeys:
            font,            NSFontAttributeName,
            foregroundColor, NSForegroundColorAttributeName,
            backgroundColor, NSBackgroundColorAttributeName,
            nil];
}

- (NSRect)textBoundingRect {
    return [title boundingRectWithSize:NSMakeSize(1e100, 1e100)
                               options:0
                            attributes:[self titleAttributes]];
}

- (void)setTitle:(NSString *)newTitle
{
    if (![title isEqual:newTitle]) {
        [newTitle retain];
        [title release];
        title = newTitle;

        NSRect textBounds = [self textBoundingRect];
        int newWidth = textBounds.size.width + (2 * MenuExtraViewPaddingWidth);
        // like if we did [_menuExtra setLenght:NSVariableStatusItemLength]
        [self setFrame:NSMakeRect(0, 0, newWidth, 24)];
        [_menuExtra setLength:newWidth];

        [self setNeedsDisplay:YES];
    }
}

- (NSString *)title
{
    return title;
}

- (void)drawRect:(NSRect)rect
{
    [[self titleBackgroundColor] set];
    [NSBezierPath fillRect:rect];

    [_menuExtra drawStatusBarBackgroundInRect:[self bounds]
                                withHighlight:[_menuExtra isMenuDown]];

    NSPoint origin = NSMakePoint(MenuExtraViewPaddingWidth,
                                 MenuExtraViewPaddingHeight);

    [title drawAtPoint:origin
        withAttributes:[self titleAttributes]];
}

- (void)dealloc
{
    [title dealloc];
    [super dealloc];
}

@end
