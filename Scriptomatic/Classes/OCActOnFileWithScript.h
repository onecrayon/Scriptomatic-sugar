//
//  OCActOnFileWithScript.h
//  Scriptomatic
//
//  Created by Ian Beck on 10/28/11.
//  Copyright 2011 MacRabbit. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface OCActOnFileWithScript : NSObject {
@private
    BOOL allowMultipleFiles;
	NSString *scriptPath;
}

- (NSString *)runCommands:(NSString *)commands withEnv:(NSDictionary *)env;

@end
