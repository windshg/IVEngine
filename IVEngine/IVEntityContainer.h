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

///-------------------------------------
/// @definitions Contain all definitions
///-------------------------------------

@property (nonatomic, retain) NSMutableDictionary *definitions;

///------------------------------------------------------------------
/// @object_interceptor_map Map the defined entities and interceptors
///------------------------------------------------------------------

@property (nonatomic, retain) NSMutableDictionary *object_interceptor_map;


/**
 Add an entity definition to this entity container
 
 @param definition The pointer to the new entity definition.
 
 */

- (void) addDefinition: (IVEntityDefinition*) definition;


/**
 Add an entity definition to this entity container
 
 @param objName The name of the entity defined.
 
 @param interceptorList The interceptor list defined to offer the aspect logic surrounding the object methods.
 
 */

- (void) addObjectInterceptorMap:(NSString *)objName interceptorList:(NSArray *)interceptorList;


/**
Get an entity from this container
 
 @param name The name of entity defined.
 
 @return The entity refered to the name, if it's not defined, return nil.
 
 */

- (id) getEntity: (NSString*) name;

@end
