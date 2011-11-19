//
//  OCActOnFileWithScript.m
//  Scriptomatic
//
//  Created by Ian Beck on 10/28/11.
//  Copyright 2011 One Crayon. All rights reserved.
//

#import "OCActOnFileWithScript.h"
#import <EspressoFileActions.h>


// HACK: these are not exposed in the public Espresso API, but we need them to properly locate the root project directory
// DON'T TRY THIS AT HOME! YOUR SUGAR WILL LIKELY BREAK WITH FUTURE ESPRESSO UPDATES
@interface NSObject (ScriptomaticFileActionDeliciousness)
@property(readonly) id document;
@end

@implementation OCActOnFileWithScript

- (BOOL)canPerformActionWithContext:(id)context
{
	// Only allow the action if we have a script and the proper number of files
	return scriptPath != nil && (([[context URLs] count] > 1 && allowMultipleSelections) || [[context URLs] count] == 1 || [[context URLs] count] == 0 && allowNoSelection);
}

- (BOOL)performActionWithContext:(id)context error:(NSError **)outError
{
	// Parse our file path(s) into an argument list
	NSMutableString *paths = [NSMutableString string];
	for (NSURL *url in [context URLs]) {
		[paths appendFormat:@"\"%@\" ", [url path]];
	}
	// Create our environment variables
	NSDictionary *env = [NSDictionary dictionaryWithObjectsAndKeys:
						 [[self projectURLForContext:context] path], @"EDITOR_PROJECT_PATH",
						 myBundlePath, @"EDITOR_SUGAR_PATH",
						 nil];
	// Create our osascript command
	NSString *command = [NSString stringWithFormat:@"osascript %@ %@", scriptPath, paths];
	NSLog(@"%@", [self runCommands:command withEnv:env]);
	return YES;
}

- (NSURL *)projectURLForContext:(id)context
{
    id doc = [[context windowForSheet] document];
	if ([[doc className] isEqualToString:@"ESProjectDocument"]) {
		return [doc directoryURL];
	} else {
		return nil;
	}
}

@end
