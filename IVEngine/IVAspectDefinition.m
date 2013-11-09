//
//  IVAspectDefinition.m
//  IVin
//
//  Created by Vinson Huang on 1/3/12.
//  Copyright (c) 2012 Vinson. All rights reserved.
//

#import "IVAspectDefinition.h"

@implementation IVAspectDefinition

@synthesize name;
@synthesize className;
@synthesize joinPointList;

- (void)addJoinPoint:(IVAspectJoinPoint *)joinPoint {
    if (!joinPointList) {
        joinPointList = [[NSMutableArray alloc] init];
    }
    [joinPointList addObject:joinPoint];
}

- (void) dealloc {
    [name release];
    [className release];
	[super dealloc];
}

@end
