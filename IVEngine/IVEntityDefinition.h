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
	BOOL autowire;
	BOOL singleton;
	NSMutableDictionary *propertyReferences;
	// TODO: propiedades con valores.... propiedades anidadas... etc. Pensar una clase generica
    NSMutableDictionary *propertyStringValues;
    NSMutableDictionary *propertyNumberValues;
}

@property (retain,nonatomic) NSString *name;
@property (retain,nonatomic) NSString *className;
@property (assign,nonatomic) BOOL autowire;
@property (assign,nonatomic) BOOL singleton;
@property (assign,nonatomic,readonly) NSDictionary *propertyReferences;
@property (assign,nonatomic,readonly) NSDictionary *propertyStringValues;
@property (assign,nonatomic,readonly) NSDictionary *propertyNumberValues;

- (void) addPropertyReference:(NSString*) propertyName toObjectName:(NSString*) objectName;
- (void) addPropertyStringValue:(NSString*)propertyName  value:(NSString*)value;
- (void) addPropertyNumberValue:(NSString*)propertyName  value:(NSString*)value;

@end
