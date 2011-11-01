//
//  OCScriptomaticBase.m
//  Scriptomatic
//
//  Created by Ian Beck on 11/1/11.
//  Copyright 2011 MacRabbit. All rights reserved.
//

#import "OCScriptomaticBase.h"
#import <NSString+MRFoundation.h>


@implementation OCScriptomaticBase

- (id)initWithDictionary:(NSDictionary *)dictionary bundlePath:(NSString *)bundlePath
{
    self = [super init];
    if (self) {
        // Parse through our configuration variables
		if ([dictionary objectForKey:@"allow-multiple-selections"]) {
			allowMultipleSelections = ([[dictionary objectForKey:@"allow-multiple-selections"] isEqualToString:@"true"] == YES) ? YES : NO;
		} else {
			allowMultipleSelections = NO;
		}
		scriptPath = [dictionary objectForKey:@"script-path"];
		if (scriptPath) {
			NSMutableString *tempPath = [NSMutableString stringWithString:[bundlePath stringByAppendingPathComponent:scriptPath]];
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
