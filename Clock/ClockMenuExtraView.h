//
//  ClockMenuExtraView.h
//  MenuExtra
//
//  Created by Loic Nageleisen on 07/01/2011.
//  Copyright 2011 Loic Nageleisen. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NSMenuExtra.h"
#import "NSMenuExtraView.h"

#define MenuExtraViewPaddingWidth  6
#define MenuExtraViewPaddingHeight 3

@interface ClockMenuExtraView : NSMenuExtraView {
    NSString *title;
}

@property(readwrite, copy) NSString *title;

@end
