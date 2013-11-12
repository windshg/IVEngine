//
//  LFCObjectWrapper.h
//  IVin
//
//  Created by Vinson Huang on 1/3/12.
//  Copyright 2009 na. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface IVEntityWrapper : NSObject {
	id object;
}

@property (retain, nonatomic) id object;

/**
Initilize the wrapper with the referenced object.
 
 @param anObject The entity managed by this proxy.
 
 */

- (id) initWithObject:(id)anObject;


/**
 Initilize the wrapper with the referenced class.
 
 @param aClassName The name of Class for the entities managed by this proxy.
 
 */

- (id) initWithClassName:(NSString*)aClassName;


/**
Wrapper of the relative entity's getter method.
 
 @param aPropertyName The name of Class for the entities managed by this proxy.
 
 @return Return the return type of the property getter.
 
 */

- (NSString*) getPropertyReturnType:(NSString*)aPropertyName;


/**
 Wrapper of the relative entity's setter method.
 
 @param aPropertyName The name of Class for the entities managed by this proxy.
 
 */

- (void) setProperty:(NSString*)aPropertyName withValue:(id)aValue;

/**
Return the value or object refering to the property.
 
 @param aPropertyName The name of Class for the entities managed by this proxy.
 
 @return Return the property's value.
 
 */

- (id) getProperty:(NSString*)aPropertyName;

/**
Return all properties' name from the relative entity or its class.
 
 @return An string array refering to property names.
 
 */

- (NSArray*) getPropertyNames;

/**
Indicate whether the entity has the property.
 
 @param aPropertyName The name of the relative property.
 
 @return true or false.
 
 */

- (BOOL) hasProperty:(NSString*)aPropertyName;

@end
