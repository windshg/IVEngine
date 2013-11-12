//
//  IVEntityDefinition.h
//  IVin
//
//  Created by Vinson Huang on 1/3/12.
//  Copyright 2012 Vinson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IVEntityDefinition : NSObject {
	NSString *name;
	NSString *className;
	NSInteger autowire;
	BOOL singleton;
	NSMutableDictionary *propertyReferences;
    NSMutableDictionary *propertyStringValues;
    NSMutableDictionary *propertyNumberValues;
}

///--------------------------
/// @name The name of entity.
///--------------------------

@property (retain,nonatomic) NSString *name;

///--------------------------------------------------
/// @className The name of Class the entity new from.
///--------------------------------------------------

@property (retain,nonatomic) NSString *className;

///---------------------------------------------------------------------------------
/// @autowire Indicate to the autowire type including "byType", "byName", "default".
///---------------------------------------------------------------------------------

@property (assign,nonatomic) NSInteger autowire;

///---------------------------------------------------
/// @singleton Declare whether the entity is singleton
///---------------------------------------------------

@property (assign,nonatomic) BOOL singleton;

///--------------------------------------------------
/// @propertyReferences Property and references map.
///--------------------------------------------------

@property (retain,nonatomic,readonly) NSMutableDictionary *propertyReferences;

///------------------------------------------------------
/// @propertyStringValues Property and string values map.
///------------------------------------------------------

@property (retain,nonatomic,readonly) NSMutableDictionary *propertyStringValues;

///-----------------------------------------------------
/// @propertyNumberValues Property and number value map.
///-----------------------------------------------------

@property (retain,nonatomic,readonly) NSMutableDictionary *propertyNumberValues;

/**
 Add ref value to the property.
 
 @param propertyName The name of the property in entity.
 
 @param objectName The entity name.
 
 */

- (void) addPropertyReference:(NSString*) propertyName toObjectName:(NSString*) objectName;


/**
 Add string value to the property.
 
 @param propertyName The name of the property in entity.
 
 @param objectName The entity name.
 
 */

- (void) addPropertyStringValue:(NSString*)propertyName  value:(NSString*)value;


/**
Add number value to the property.
 
 @param propertyName The name of the property in entity.
 
 @param objectName The entity name.
 
 */

- (void) addPropertyNumberValue:(NSString*)propertyName  value:(NSString*)value;

@end
