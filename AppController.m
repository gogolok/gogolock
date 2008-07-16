//
//  AppController.m
//  GogoLock
//
//  Created by gogo on 7/16/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#include <Carbon/Carbon.h>

#import "AppController.h"

OSStatus globalShortCutForLockingHandler(EventHandlerCallRef nextHandler, EventRef theEvent, void* userData);

@implementation AppController

- (id)init
{
	NSLog(@"AppController::init");
	
	if( ![super init] )
		return nil;
	
	[self registerGlobalShortCutForLocking];

	return self;
}

- (void)registerGlobalShortCutForLocking
{
	NSLog(@"Registering global shortcut to 'lock screen'");
	
	EventTypeSpec eventType;
	eventType.eventClass = kEventClassKeyboard;
	eventType.eventKind  = kEventHotKeyPressed;
	
	InstallApplicationEventHandler(&globalShortCutForLockingHandler, 1, &eventType, NULL, NULL);
	
	EventHotKeyID g_HotKeyID;
	g_HotKeyID.signature = 'htk1';
	g_HotKeyID.id = 1;
	
	EventHotKeyRef g_HotKeyRef;
	
	RegisterEventHotKey(124, cmdKey + optionKey, g_HotKeyID, GetApplicationEventTarget(), 0, &g_HotKeyRef);
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)theApplication hasVisibleWindows:(BOOL)flag
{
	NSLog(@"dock clicked");
	
	lockScreen();
	
	return YES;
}

@end

OSStatus globalShortCutForLockingHandler(EventHandlerCallRef nextHandler, EventRef theEvent, void* userData)
{
	lockScreen();
	
	return noErr;
}

void lockScreen()
{
	NSLog(@"Lock screen!");
	
	NSTask *task = [[NSTask alloc] init];
	
	[task setLaunchPath:@"/System/Library/CoreServices/Menu Extras/User.menu/Contents/Resources/CGSession"];
	
	NSArray *args = [NSArray arrayWithObject:@"-suspend"];
	[task setArguments:args];
	
	[task launch];
	
	[task release];
}