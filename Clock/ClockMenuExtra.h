//
//  SampleMenuExtra.h
//  MenuExtra
//
//  Created by Loic Nageleisen on 07/01/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NSMenuExtra.h"

@class ClockMenuExtraView;

@interface ClockMenuExtra : NSMenuExtra {
    ClockMenuExtraView *theView;
    NSMenu *theMenu;
    NSMenuItem *theClockMenuItem;
    NSTimer *theTimer;
    NSTimeInterval refreshInterval;
    NSDateFormatter *menuBarFormatter;
    NSDateFormatter *menuItemFormatter;
}

- (void)setTimer;
- (void)setFormats;
- (void)refreshClock:(NSTimer*)timer;

@end
