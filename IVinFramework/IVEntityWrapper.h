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

- (id) initWithObject:(id) anObject;
- (id) initWithClassName:(NSString*) aClassName;

- (NSString*) getPropertyReturnType:(NSString*) aPropertyName;

- (void) setProperty:(NSString*) aPropertyName withValue:(id) aValue;
- (id) getProperty:(NSString*) aPropertyName;

- (NSArray*) getPropertyNames;
- (BOOL) hasProperty:(NSString*) aPropertyName;

@end
