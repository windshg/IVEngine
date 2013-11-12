//
//  IVAspectWeaver.m
//  IVin
//
//  Created by Vinson Huang on 1/3/12.
//  Copyright (c) 2012 Vinson. All rights reserved.
//

#import "IVAspectWeaver.h"

#define EXPRESSION_SIGN_OBJECT (@"object")
#define EXPRESSION_SIGN_CLASS (@"class")

@interface IVAspectWeaver()

@end

@implementation IVAspectWeaver

@synthesize aspectDefinitions;
@synthesize container;

- (void)addAspectDefinition:(IVAspectDefinition *)aspectDefinition {
    if (!aspectDefinitions) {
        aspectDefinitions = [[NSMutableArray alloc] init];
    }
    [aspectDefinitions addObject:aspectDefinition];
}

- (void)configureInContainer:(IVEntityContainer *)aContainer {
    self.container = aContainer;
    NSMutableDictionary * objectInterceptorMap = [[NSMutableDictionary alloc] init];
    for (IVAspectDefinition * definition in aspectDefinitions) {
        for (IVAspectJoinPoint *joinPoint in definition.joinPointList) {
            NSArray * objectList = [joinPoint objectList];
            NSMutableArray * refmethodList = joinPoint.refMethodList;
            NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:definition, @"aspectDefinition", refmethodList, @"refmethod", nil];
            for (NSString * objectStr in objectList) {
                NSMutableArray *interceptorList = [objectInterceptorMap objectForKey:objectStr];
                if (!interceptorList) {
                    interceptorList = [[NSMutableArray alloc] init];
                    [interceptorList addObject:dic];
                    [objectInterceptorMap setObject:interceptorList forKey:objectStr];
                } else {
                    [interceptorList addObject:dic];
                }
            }
        }
    }
    container.object_interceptor_map = objectInterceptorMap;
}

- (void)dealloc {
    [aspectDefinitions release];
    [super dealloc];
}

@end
