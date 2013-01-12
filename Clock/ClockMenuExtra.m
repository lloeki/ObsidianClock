//
//  ClockMenuExtra.m
//  MenuExtra
//
//  Created by Loic Nageleisen on 07/01/2011.
//  Copyright 2011 Loic Nageleisen. All rights reserved.
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

- (void)readPreferences
{
    // TODO: watch the plist for changes
    // for now, read once and be done with it
    // as polling every second is just bad
    if (preferences != nil) {
        return;
    }

    NSString* plistPath = @"/Users/lloeki/Library/Preferences/com.apple.menuextra.clock.plist";
    NSDictionary *newPreferences = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    [newPreferences retain];
    if (preferences != nil) {
        [preferences release];
    }
    preferences = newPreferences;
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
    NSMenuItem *item = [menu addItemWithTitle:@"Open Date & Time Preferences..."
                                       action:@selector(openDateAndTimePreferencePane)
                                keyEquivalent:@""];
    [item setTarget:self];
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

- (NSString *)dateFormatTemplateForMenuBar
{
    return [preferences objectForKey:@"DateFormat"];
}

- (NSString *)dateFormatTemplateForMenuItem
{
    // TODO: this format order may depend on locale settings
    return @"EEEEdMMMMYYYY";
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
    // TODO: memoize
    return [self dateFormatterFromTemplate:[self dateFormatTemplateForMenuBar]];
}

- (NSDateFormatter *)dateFormatterForMenuItem
{
    // TODO: memoize
    return [self dateFormatterFromTemplate:[self dateFormatTemplateForMenuItem]];
}

- (void)refreshClock:(NSTimer*)timer
{
    [self readPreferences];

    NSDate *now = [NSDate date];
    
    NSDateFormatter *menuBarFormatter = [self dateFormatterForMenuBar];
    [clockMenuExtraView setTitle:[menuBarFormatter stringFromDate:now]];
    [menuBarFormatter release]; // TODO: once memoized, move to dealloc

    NSDateFormatter *menuItemFormatter = [self dateFormatterForMenuItem];
    [clockMenuItem setTitle:[menuItemFormatter stringFromDate:now]];
    [menuItemFormatter release]; // TODO: once memoized, move to dealloc
}

- (NSMenu *)menu
{
	return menu;
}

- (void)openDateAndTimePreferencePane
{
    [[NSWorkspace sharedWorkspace] openFile:@"/System/Library/PreferencePanes/DateAndTime.prefPane"];
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
    [preferences release];
    [menu release];
    [super dealloc];
}

@end
