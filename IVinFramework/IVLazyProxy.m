//
//  IVLazyProxy.m
//  IVin
//
//  Created by Vinson Huang on 1/3/12.
//  Copyright 2012 Vinson. All rights reserved.
//

#import "IVLazyProxy.h"


@interface IVLazyProxy()
@property (retain, nonatomic) id realObject;
@property (retain, nonatomic) NSString *className;
- (void) buildRealObjectIfNull;
@end

@implementation IVLazyProxy
@synthesize realObject, className;

#pragma mark Init and dealloc methods
- (id) initWithClassName: (id) aClassName {
	self.realObject = nil;
	self.className = aClassName;
	return self;
}

- (void) dealloc {
	self.realObject = nil;
	self.className = nil;
	[super dealloc];
}

#pragma mark NSProxy methods
- (void)forwardInvocation:(NSInvocation *)anInvocation {
	[self buildRealObjectIfNull];
    [anInvocation setTarget:self.realObject];
    [anInvocation invoke];
    return;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
	[self buildRealObjectIfNull];
    return [self.realObject methodSignatureForSelector:aSelector];
}

#pragma mark Private methods
- (void) buildRealObjectIfNull {
	if (self.realObject == nil) {
		self.realObject = [objc_getClass([self.className UTF8String]) new];
	}
}

@end

