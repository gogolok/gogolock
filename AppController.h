//
//  AppController.h
//  GogoLock
//
//  Created by gogo on 7/16/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface AppController : NSObject {

}

- (void)registerGlobalShortCutForLocking;

/* NSApplication delegate functions */
- (BOOL)applicationShouldHandleReopen:(NSApplication *)theApplication hasVisibleWindows:(BOOL)flag;

@end

void lockScreen();