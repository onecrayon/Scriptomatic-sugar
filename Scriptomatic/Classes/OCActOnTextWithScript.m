//
//  OCActOnTextWithScript.m
//  Scriptomatic
//
//  Created by Ian Beck on 11/1/11.
//  Copyright 2011 MacRabbit. All rights reserved.
//

#import "OCActOnTextWithScript.h"
#import <EspressoTextActions.h>
#import <NSString+MRFoundation.h>


@implementation OCActOnTextWithScript

- (BOOL)canPerformActionWithContext:(id)context
{
	// Only allow the action if we have a script, at least one selection, and the proper number of selections (one or multiple)
	return scriptPath != nil && [[[context selectedRanges] objectAtIndex:0] rangeValue].length > 0 && (([[context selectedRanges] count] > 1 && allowMultipleSelections) || [[context selectedRanges] count] == 1);
}

- (BOOL)performActionWithContext:(id)context error:(NSError **)outError
{
	// Parse our selection(s) into an argument list
	NSMutableString *selections = [NSMutableString string];
	NSMutableString *tempSelection = [NSMutableString string];
	for (NSValue *rngValue in [context selectedRanges]) {
		// Grab our selected text
		[tempSelection setString:[[context string] substringWithRange:[rngValue rangeValue]]];
		// Escape any quotation marks in the string
		[tempSelection replaceOccurrencesOfString:@"\"" withString:@"\\\""];
		// Add the string to our list of arguments
		[selections appendFormat:@"\"%@\" ", tempSelection];
	}
	// Create our osascript command
	NSString *command = [NSString stringWithFormat:@"osascript %@ %@", scriptPath, selections];
	NSLog(@"command: %@", command);
	NSLog(@"%@", [self runCommands:command withEnv:nil]);
	return YES;
}

@end
