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
    if(self == nil)
        return nil;
    
    // seems about nice for HH:mm 
    [self setLength: 42];
    
    // we will create and set the MenuExtraView
    theView = [[ClockMenuExtraView alloc] initWithFrame:
			   [[self view] frame] menuExtra:self];
    //[theView setText:@"Clock"];
    [self setView:theView];
    
    // build the menu
    theMenu = [[NSMenu alloc] initWithTitle: @"Clock"];
    [theMenu setAutoenablesItems: NO];
    theClockMenuItem = [theMenu addItemWithTitle: @""
                                action:           nil
                                keyEquivalent:    @""];
    [theClockMenuItem setEnabled:false];
    [theMenu addItem:[NSMenuItem separatorItem]];
    [theMenu addItemWithTitle: @"Date & Time Preferences..."
             action:           nil
             keyEquivalent:    @""];
    
    [self refreshClock:nil];
    
    //[self nextTimer];
    
    return self;
}

- (void)nextTimer
{
    // release the current timer
    [theTimer release];
    
    NSDate *now = [NSDate date];
    
    // reset seconds to zero
    //NSCalendar *calendar = [NSCalendar currentCalendar]; // might leak?
    NSString *localeIdentifier = [[NSLocale currentLocale] objectForKey: NSLocaleCalendar];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: localeIdentifier];
    NSDateComponents *comps = [calendar components: NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit fromDate: now];
    NSDate *currentMinute = [calendar dateFromComponents:comps];
    
    // add one minute
    NSDateComponents *delta = [[NSDateComponents alloc] init];
    [delta setMinute:1];
    
    NSDate *fireDate = [calendar dateByAddingComponents:delta toDate:currentMinute options:0];
    [delta release];
    [calendar release];
    
    // setup timer
    theTimer = [[NSTimer alloc] initWithFireDate:fireDate
                                interval:1
                                target:self
                                selector:@selector(refreshClock:)
                                userInfo:nil
                                repeats:NO];
    
    [[NSRunLoop currentRunLoop] addTimer:theTimer forMode:NSDefaultRunLoopMode];
}

- (void)refreshClock:(NSTimer*)timer
{
    NSDate *now = [NSDate date];
    
    NSLocale *currentLocale = [NSLocale currentLocale];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    
    NSString *currentMenuBarFormatString = [NSDateFormatter dateFormatFromTemplate:@"HH:mm" options:0 locale:currentLocale];
    dateFormatter.dateFormat = currentMenuBarFormatString;
    [theView setText:[dateFormatter stringFromDate:now]];
    [theView setNeedsDisplay:true];
    
    NSString *currentMenuItemFormatString = [NSDateFormatter dateFormatFromTemplate:@"EEEEdMMMMYYYY" options:0 locale:currentLocale];
    dateFormatter.dateFormat = currentMenuItemFormatString;
    [theClockMenuItem setTitle:[dateFormatter stringFromDate:now]];
    
    [dateFormatter release];
    
    [self nextTimer];
}

- (NSMenu *)menu
{
	return theMenu;
}

- (void)dealloc
{
    [theTimer invalidate];
    [theTimer release];
    [theView release];
    [theMenu release];
    [super dealloc];
}

@end
