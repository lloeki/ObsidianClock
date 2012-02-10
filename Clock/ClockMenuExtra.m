//
//  SampleMenuExtra.m
//  MenuExtra
//
//  Created by Loic Nageleisen on 07/01/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ClockMenuExtra.h"
#import "ClockMenuExtraView.h"


@implementation ClockMenuExtra

- (id)initWithBundle:(NSBundle *)bundle
{
    self = [super initWithBundle: bundle];
    if (self == nil)
        return nil;
    
    // seems about nice
    [self setLength: 76];
    
    // create and set the MenuExtraView
    theView = [[ClockMenuExtraView alloc] initWithFrame: [[self view] frame]
                                          menuExtra:     self];
    [self setView: theView];
    [theView setFont];
    
    // build the menu
    theMenu = [[NSMenu alloc] initWithTitle: @"Clock"];
    [theMenu setAutoenablesItems: NO];
    theClockMenuItem = [theMenu addItemWithTitle: @""
                                action:           nil
                                keyEquivalent:    @""];
    [theClockMenuItem setEnabled: false];
    [theMenu addItem: [NSMenuItem separatorItem]];
    [theMenu addItemWithTitle: @"Date & Time Preferences..."
             action:           nil
             keyEquivalent:    @""];
    
    // set up formats
    [self setFormats];
    
    // refresh now, then every once in a while
    [self refreshClock: nil];
    refreshInterval = 1;
    [self setTimer];
    
    return self;
}

- (void)setTimer
{    
    // setup timer
    theTimer = [NSTimer scheduledTimerWithTimeInterval: refreshInterval
                                                target: self
                                              selector: @selector(refreshClock:)
                                              userInfo: nil
                                               repeats: YES];
}

- (void)setFormats
{
    NSLocale *currentLocale = [NSLocale currentLocale];
    
    // menu bar
    menuBarFormatter = [[NSDateFormatter alloc] init];
    [menuBarFormatter setTimeZone: [NSTimeZone systemTimeZone]];
    
    NSString *currentMenuBarFormatString = [NSDateFormatter dateFormatFromTemplate: @"EE HH:mm"
                                                                           options: 0
                                                                            locale: currentLocale];
    menuBarFormatter.dateFormat = currentMenuBarFormatString;

    // menu item
    menuItemFormatter = [[NSDateFormatter alloc] init];
    [menuItemFormatter setTimeZone: [NSTimeZone systemTimeZone]];
    NSString *currentMenuItemFormatString = [NSDateFormatter dateFormatFromTemplate: @"EEEEdMMMMYYYY"
                                                                            options: 0
                                                                             locale: currentLocale];
    menuItemFormatter.dateFormat = currentMenuItemFormatString;
    
}

- (void)refreshClock:(NSTimer*)timer
{    
    NSDate *now = [NSDate date];
    [self setLength: [theView computeLength]];
    
    [theView setText: [menuBarFormatter stringFromDate: now]];
    [theClockMenuItem setTitle:[menuItemFormatter stringFromDate: now]];
    [theView setNeedsDisplay: true];
}

- (NSMenu *)menu
{
	return theMenu;
}

- (void)willUnload
{
    NSLog(@"ClockMenuExtra willUnload");
    [theTimer invalidate];
    [super willUnload];
}

- (void)dealloc
{
    NSLog(@"ClockMenuExtra dealloc");
    [menuItemFormatter release];
    [menuBarFormatter release];
    [theView release];
    [theMenu release];
    [super dealloc];
}

@end
