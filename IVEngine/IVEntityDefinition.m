//
//  IVEntityDefinition.m
//  IVin
//
//  Created by Vinson Huang on 1/3/12.
//  Copyright 2012 Vinson. All rights reserved.
//

#import "IVEntityDefinition.h"


@implementation IVEntityDefinition

@synthesize name, className, singleton, autowire, propertyReferences,propertyStringValues, propertyNumberValues;

#pragma mark public methods
- (void) addPropertyReference:(NSString*) propertyName toObjectName:(NSString*) objectName {
    if (!propertyReferences) {
        propertyReferences = [[NSMutableDictionary alloc] init];
    }
	[propertyReferences setObject:objectName forKey:propertyName];
}

- (void) addPropertyStringValue:(NSString*)propertyName  value:(NSString*)value {
    if (!propertyStringValues) {
        propertyStringValues = [[NSMutableDictionary alloc] init];
    }
    [propertyStringValues setObject:value forKey:propertyName];
}

- (void) addPropertyNumberValue:(NSString*)propertyName  value:(NSString*)value {
    if (!propertyNumberValues) {
        propertyNumberValues = [[NSMutableDictionary alloc] init];
    }
    [propertyNumberValues setObject:value forKey:propertyName];
}

#pragma mark init and dealloc
- (id) init
{
	self = [super init];
	if (self != nil) {
		self.singleton = NO;
		self.autowire = NO;
	}
	return self;
}


- (void) dealloc {
	self.name = nil;
	self.className = nil;
	[propertyReferences release];
    [propertyStringValues release];
    [propertyNumberValues release];
	[super dealloc];
}

@end
