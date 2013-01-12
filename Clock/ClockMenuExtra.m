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
    self = [super initWithBundle:bundle];
    if (self == nil)
        return nil;

    clockMenuExtraView = [[ClockMenuExtraView alloc] initWithFrame:NSMakeRect(0, 0, 24, 24)
                                                         menuExtra:self];
    [clockMenuExtraView retain];
    [self initMenu];
    [self setView:clockMenuExtraView];

    // refresh now, then every once in a while
    [self refreshClock:nil];
    refreshInterval = 1;
    [self setTimer];

    return self;
}

- (void)initMenu
{
    menu = [[NSMenu alloc] initWithTitle:@"Clock"];
    [menu setAutoenablesItems:NO];
    clockMenuItem = [menu addItemWithTitle:@""
                                    action:nil
                             keyEquivalent:@""];
    [clockMenuItem setEnabled:false];
    [menu addItem: [NSMenuItem separatorItem]];
    [menu addItemWithTitle:@"Open Date & Time Preferences..."
                    action:nil
             keyEquivalent:@""];
}

- (void)setTimer
{    
    // setup timer
    timer = [NSTimer scheduledTimerWithTimeInterval:refreshInterval
                                             target:self
                                           selector:@selector(refreshClock:)
                                           userInfo:nil
                                            repeats:YES];
}

- (NSDateFormatter *)dateFormatterFromTemplate: (NSString *)template
{
    NSLocale *currentLocale = [NSLocale currentLocale];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone: [NSTimeZone systemTimeZone]];
    
    NSString *currentMenuBarFormatString = [NSDateFormatter dateFormatFromTemplate:template
                                                                           options:0
                                                                            locale:currentLocale];
    dateFormatter.dateFormat = currentMenuBarFormatString;
    
    return dateFormatter;
}

- (NSDateFormatter *)dateFormatterForMenuBar
{
    return [self dateFormatterFromTemplate:@"EE HH:mm"];
}

- (NSDateFormatter *)dateFormatterForMenuItem
{
    return [self dateFormatterFromTemplate:@"EEEEdMMMMYYYY"];
}

- (void)refreshClock:(NSTimer*)timer
{
    NSDate *now = [NSDate date];
    
    NSDateFormatter *menuBarFormatter = [self dateFormatterForMenuBar];
    [clockMenuExtraView setTitle:[menuBarFormatter stringFromDate:now]];
    [menuBarFormatter release];

    NSDateFormatter *menuItemFormatter = [self dateFormatterForMenuItem];
    [clockMenuItem setTitle:[menuItemFormatter stringFromDate:now]];
    [menuItemFormatter release];
}

- (NSMenu *)menu
{
	return menu;
}

- (void)willUnload
{
    NSLog(@"ClockMenuExtra willUnload");
    [timer invalidate];
    [super willUnload];
}

- (void)dealloc
{
    NSLog(@"ClockMenuExtra dealloc");
    [clockMenuExtraView release];
    [menu release];
    [super dealloc];
}

@end
