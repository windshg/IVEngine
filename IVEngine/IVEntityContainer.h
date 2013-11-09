//
//  IVEntityContainer.h
//  IVin
//
//  Created by Vinson on 1/3/12.
//  Copyright 2012 Vinson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IVEntityDefinition.h"

#define IVEntityContainerInject(property,objectName) -(void) iocMap_##property##__##objectName{}

@interface IVEntityContainer : NSObject {
	NSMutableDictionary *definitions;
	NSMutableDictionary *objects;
    NSMutableDictionary *aspects;
    NSMutableDictionary *object_interceptor_map;
}

@property (nonatomic, retain) NSMutableDictionary *definitions;
@property (nonatomic, retain) NSMutableDictionary *object_interceptor_map;

- (void) addDefinition: (IVEntityDefinition*) definition;

- (void) addObjectInterceptorMap:(NSString *)objName interceptorList:(NSArray *)interceptorList;

- (id) getEntity: (NSString*) name;

@end
