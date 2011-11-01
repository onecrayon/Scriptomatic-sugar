//
//  OCScriptomaticBase.h
//  Scriptomatic
//
//  Created by Ian Beck on 11/1/11.
//  Copyright 2011 MacRabbit. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface OCScriptomaticBase : NSObject {
@protected
    NSString *scriptPath;
	BOOL allowMultipleSelections;
}

- (NSString *)runCommands:(NSString *)commands withEnv:(NSDictionary *)env;

@end
