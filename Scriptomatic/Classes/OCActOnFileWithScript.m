//
//  OCActOnFileWithScript.m
//  Scriptomatic
//
//  Created by Ian Beck on 10/28/11.
//  Copyright 2011 MacRabbit. All rights reserved.
//

#import "OCActOnFileWithScript.h"
#import <EspressoFileActions.h>
#import <NSString+MRFoundation.h>


@implementation OCActOnFileWithScript

- (id)initWithDictionary:(NSDictionary *)dictionary bundlePath:(NSString *)bundlePath
{
    self = [super init];
    if (self) {
        // Parse through our configuration variables
		if ([dictionary objectForKey:@"allow-multiple-files"]) {
			allowMultipleFiles = ([[dictionary objectForKey:@"allow-multiple-files"] isEqualToString:@"true"] == YES) ? YES : NO;
		} else {
			allowMultipleFiles = NO;
		}
		scriptPath = [dictionary objectForKey:@"script-path"];
		if (scriptPath) {
			NSMutableString *tempPath = [NSMutableString stringWithString:[[[NSBundle bundleWithIdentifier:@"com.onecrayon.sugar.scriptomatic"] bundlePath] stringByAppendingPathComponent:scriptPath]];
			// Ajust for running on the shell without quotes
			[tempPath replaceOccurrencesOfString:@" " withString:@"\\ "];
			scriptPath = [tempPath retain];
		} else {
			scriptPath = nil;
		}
    }
    
    return self;
}

- (void)dealloc
{
	MRRelease(scriptPath);
    [super dealloc];
}

- (BOOL)canPerformActionWithContext:(id)context
{
	// Only allow the action if we have a script and the proper number of files
	return scriptPath != nil && (([[context URLs] count] > 1 && allowMultipleFiles) || [[context URLs] count] == 1);
}

- (BOOL)performActionWithContext:(id)context error:(NSError **)outError
{
	// Parse our file path(s) into an argument list
	NSMutableString *paths = [NSMutableString string];
	for (NSURL *url in [context URLs]) {
		[paths appendFormat:@"\"%@\"", [url path]];
	}
	// Create our osascript command
	NSString *command = [NSString stringWithFormat:@"osascript %@ %@", scriptPath, paths];
	NSLog(@"command: %@", command);
	NSLog(@"%@", [self runCommands:command withEnv:nil]);
	return YES;
}

- (NSString *)runCommands:(NSString *)commands withEnv:(NSDictionary *)env
{
    // Configure our arguments array
    NSArray *args = [NSArray arrayWithObjects:@"-c", commands, nil];
    
	// Run the shell commands
	NSTask *task = [[NSTask alloc] init];
	NSPipe *inPipe = [NSPipe pipe], *outPipe = [NSPipe pipe];
	
	[task setLaunchPath:@"/bin/sh"];
    [task setArguments:args];
	[task setStandardOutput:outPipe];
	[task setStandardError:outPipe];
	[task setStandardInput:inPipe];
    
    // Setup environment
    NSMutableDictionary *environment = [NSMutableDictionary dictionaryWithDictionary:env];
    // Setup a standard path
    [environment setObject:@"/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin" forKey:@"PATH"];
    [task setEnvironment:environment];
	
	[task launch];
	
	NSData *data;
	NSString *outString = nil;
	data = [[outPipe fileHandleForReading] readDataToEndOfFile];
	outString = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
	
	[task waitUntilExit];
	[task release];
	
	return outString;
}

@end
