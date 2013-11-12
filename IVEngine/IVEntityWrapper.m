//
//  LFCObjectWrapper.m
//  IVin
//
//  Created by Vinson Huang on 1/3/12.
//  Copyright 2009 na. All rights reserved.
//

#import "IVEntityWrapper.h"
#import <objc/runtime.h>

@implementation IVEntityWrapper

@synthesize object;

- (id) initWithObject:(id)anObject {
	if (self = [super init]) {
		self.object = anObject;
	}
	return self;
}

- (id) initWithClassName:(NSString*) aClassName {
	id anObject = [objc_getClass([aClassName UTF8String]) new];
	self = [self initWithObject:anObject];
	[anObject release];
	return self;
}

- (NSString*) getPropertyReturnType:(NSString*) aPropertyName {
	NSString *type;
	objc_property_t theProperty = class_getProperty([object class], [aPropertyName UTF8String]);
	if (theProperty != nil) {
		type = [NSString stringWithCString:property_getAttributes(theProperty) encoding:NSUTF8StringEncoding];
		NSUInteger firstPos = [type rangeOfString:@"\""].location + 1;
		NSUInteger charCount = [[type substringFromIndex:firstPos] rangeOfString:@"\""].location;
		return [type substringWithRange: NSMakeRange(firstPos, charCount)];
	} else {
		return nil;
	}

}

- (void) setProperty:(NSString*) aPropertyName withValue:(id) aValue {
	[object setValue:aValue forKey:aPropertyName];
}

- (id) getProperty:(NSString*) aPropertyName {
	SEL propertySelector = NSSelectorFromString(aPropertyName);
	return [object performSelector:propertySelector];
}

- (NSArray*) getPropertyNames {
	NSMutableArray *propArray = [[NSMutableArray alloc] init];
	id theClass = [object class];
	unsigned int outCount, i;
	objc_property_t *properties = class_copyPropertyList(theClass, &outCount);
	for (i = 0; i < outCount; i++) {
		objc_property_t property = properties[i];
		[propArray addObject:[NSString stringWithUTF8String:property_getName(property)]];
	}
	return [propArray autorelease];
}

- (BOOL) hasProperty:(NSString*) aPropertyName {
	return [object respondsToSelector:NSSelectorFromString(aPropertyName)];
}

- (void) dealloc {
	self.object = nil;
	[super dealloc];
}


@end
