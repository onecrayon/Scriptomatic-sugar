//
//  OCActOnFileWithScript.m
//  Scriptomatic
//
//  Created by Ian Beck on 10/28/11.
//  Copyright 2011 MacRabbit. All rights reserved.
//

#import "OCActOnFileWithScript.h"
#import <EspressoFileActions.h>


@implementation OCActOnFileWithScript

- (BOOL)canPerformActionWithContext:(id)context
{
	// Only allow the action if we have a script and the proper number of files
	return scriptPath != nil && (([[context URLs] count] > 1 && allowMultipleSelections) || [[context URLs] count] == 1);
}

- (BOOL)performActionWithContext:(id)context error:(NSError **)outError
{
	// Parse our file path(s) into an argument list
	NSMutableString *paths = [NSMutableString string];
	for (NSURL *url in [context URLs]) {
		[paths appendFormat:@"\"%@\" ", [url path]];
	}
	// Create our osascript command
	NSString *command = [NSString stringWithFormat:@"osascript %@ %@", scriptPath, paths];
	NSLog(@"command: %@", command);
	NSLog(@"%@", [self runCommands:command withEnv:nil]);
	return YES;
}

@end
