//
//  SampleMenuExtraView.h
//  MenuExtra
//
//  Created by Loic Nageleisen on 07/01/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NSMenuExtra.h"
#import "NSMenuExtraView.h"


@interface ClockMenuExtraView : NSMenuExtraView {
    NSString *text;
}
@property(readwrite, copy) NSString* text;
@end
