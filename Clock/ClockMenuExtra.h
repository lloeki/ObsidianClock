//
//  ClockMenuExtra.h
//  MenuExtra
//
//  Created by Loic Nageleisen on 07/01/2011.
//  Copyright 2011 Loic Nageleisen. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NSMenuExtra.h"

@class ClockMenuExtraView;

@interface ClockMenuExtra : NSMenuExtra {
    ClockMenuExtraView *clockMenuExtraView;
    NSMenu *menu;
    NSMenuItem *clockMenuItem;
    NSTimer *timer;
    NSTimeInterval refreshInterval;
}

@end
