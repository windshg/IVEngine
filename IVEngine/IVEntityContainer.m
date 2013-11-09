//
//  IVEntityContainer.m
//  IVin
//
//  Created by Vinson Huang on 1/3/12.
//  Copyright 2012 Vinson. All rights reserved.
//

#import "IVEntityContainer.h"
#import "IVEntityWrapper.h"
#import "IVEntityProxy.h"
#import <objc/runtime.h>
#import "IVAspect.h"
#import "IVAspectDefinition.h"

@interface IVEntityContainer()

- (id) getEntityForDefinition: (IVEntityDefinition*) definition;
- (id) buildObject: (IVEntityDefinition*) definition;
- (id) getAspectForDefinition: (IVAspectDefinition *) definition;
- (id) buildAspect: (IVAspectDefinition*) definition;
- (void) addPropertyReferencesInClass:(NSObject*) anObject andDefinition:(IVEntityDefinition *) definition;
- (id) configureObjectInAOP:(id)object byName:(NSString *)name;
- (NSNumber *) convertStringToNumber:(NSString *)str;
@end

@implementation IVEntityContainer

@synthesize definitions;
@synthesize object_interceptor_map;

#pragma mark public methods
- (void) addDefinition: (IVEntityDefinition*) definition {
	[definitions setObject:definition forKey:definition.name];
}

- (id) getEntity: (NSString*) name {
	IVEntityDefinition *definition = [definitions objectForKey:name];
    if (definition) {
        return [self getEntityForDefinition:definition];
    }
    return nil;
}

- (void) addObjectInterceptorMap:(NSString *)objName interceptorList:(NSArray *)interceptorList {
    if (!object_interceptor_map) {
        object_interceptor_map = [[NSMutableDictionary alloc] init];
    }
    [object_interceptor_map setObject:interceptorList forKey:objName];
}

#pragma mark private methods
- (id) getEntityForDefinition: (IVEntityDefinition*) definition {
	NSObject *object = nil;
	
	if (definition.singleton) {
		object = [objects objectForKey:definition.name];
	}
    
	if (object == nil) {
		object = [self buildObject:definition];
		if (definition.singleton) {
			[objects setObject:object forKey:definition.name];
		}
	}
	
	return object;
}

- (id) buildObject: (IVEntityDefinition*) definition {
	IVEntityWrapper *wrapper = [[IVEntityWrapper alloc] initWithClassName:definition.className];

	//add propertyReference definitions
	[self addPropertyReferencesInClass:wrapper.object andDefinition:definition];
	
	for (NSString *propName in [wrapper getPropertyNames]) {
        
		/* Process references */
		NSString *reference = [definition.propertyReferences objectForKey:propName];
		if (reference != nil) {
			[wrapper setProperty:propName withValue:[self getEntity:reference]];
		}
        /* Process string values */
        NSString *stringValue = [definition.propertyStringValues objectForKey:propName];
        if (stringValue != nil) {
            [wrapper setProperty:propName withValue:stringValue];
        }
        
        /* Process number values */
        NSString *numberValue = [definition.propertyNumberValues objectForKey:propName];
        if (numberValue != nil) {
            NSNumber * num = [self convertStringToNumber:numberValue];
            [wrapper setProperty:propName withValue:num];
        }
	}
	
	id object = [wrapper.object retain];
	[wrapper release];
    
    object = [self configureObjectInAOP:object byName:definition.name];
    
	return object;
}

- (NSNumber *) convertStringToNumber:(NSString *)str {
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterNoStyle];
    return [formatter numberFromString:str];
}

- (id) getAspectForDefinition: (IVAspectDefinition *) definition {
    id aspect = [aspects objectForKey:definition.name];
    
    if (aspect == nil) {
        aspect = [self buildAspect:definition];
        [aspects setObject:aspect forKey:definition.name];
    }
    
    return aspect;
}

- (id) buildAspect: (IVAspectDefinition*) definition {
    id aspect = [[objc_getClass([definition.className UTF8String]) alloc] init];
    return [aspect autorelease];
}

-(void) addPropertyReferencesInClass:(NSObject*) anObject andDefinition:(IVEntityDefinition *) definition {
	int i=0;
	unsigned int mc = 0;
	Method * mlist = class_copyMethodList(object_getClass(anObject), &mc);
	NSString *methodName;
	NSString *propertyName;
	NSString *objectDefName;
	for(i=0;i<mc;i++){
		methodName = [NSString stringWithUTF8String:sel_getName(method_getName(mlist[i]))];
		NSRange iocMapRange = [methodName rangeOfString:@"iocMap_"];
		if (iocMapRange.location == 0) {
			NSRange $$location = [methodName rangeOfString:@"__"];
			propertyName = [methodName substringWithRange: NSMakeRange (iocMapRange.length, $$location.location - iocMapRange.length)];
			objectDefName = [methodName substringWithRange:NSMakeRange($$location.location + $$location.length, [methodName length] - $$location.location - $$location.length)];
			[definition addPropertyReference:propertyName toObjectName:objectDefName];
		}
	}
	free(mlist);
}

- (id) configureObjectInAOP:(id)object byName:(NSString *)name {    
    id objectProxy = nil;
    if ([object_interceptor_map.allKeys containsObject:name]) {
        objectProxy = [[[IVEntityProxy alloc] initWithInstance:object] autorelease];
        NSArray * interceptors = [object_interceptor_map objectForKey:name];
        for (NSDictionary * dic in interceptors) {
            IVAspectDefinition *interceptorDefinition = [dic objectForKey:@"aspectDefinition"];
            NSMutableArray *refmethodList = [dic objectForKey:@"refmethod"];
            if ([(NSString *)[refmethodList objectAtIndex:0] isEqualToString:@"*"]) {
                refmethodList = [[NSMutableArray alloc] init];
                unsigned int mc;
                Method * mlist = class_copyMethodList(object_getClass(object), &mc);
                NSString *methodName;
                for(int i=0;i<mc;i++){
                    methodName = [NSString stringWithUTF8String:sel_getName(method_getName(mlist[i]))]; 
                    [refmethodList addObject:methodName];
                }
                free(mlist);
            }
            
            NSObject *aspect = [self getAspectForDefinition:interceptorDefinition];
            
            if (![aspect conformsToProtocol:NSProtocolFromString(@"IVAspect")]) {
                NSLog(@"Aspect '%@' doesn't confirm to 'IVAspect' protocol", interceptorDefinition.name);
            } else {
                for (NSString * refmethod in refmethodList) {
                    [(IVEntityProxy*)objectProxy interceptMethodStartForSelector:NSSelectorFromString(refmethod)
                                                           withInterceptorTarget:aspect
                                                             interceptorSelector:@selector(doBefore:)];
                    [(IVEntityProxy*)objectProxy interceptMethodEndForSelector:NSSelectorFromString(refmethod)
                                                         withInterceptorTarget:aspect
                                                           interceptorSelector:@selector(doAfter:)];
                }
            }
        }
    } else {
        objectProxy = object;
    }
    return objectProxy;
}

#pragma mark init and dealloc
- (id) init {
	self = [super init];
	if (self != nil) {
		definitions = [[NSMutableDictionary alloc] init];
		objects = [[NSMutableDictionary alloc] init];
        aspects = [[NSMutableDictionary alloc] init];
	}
	return self;
}

- (void) dealloc {
	[definitions release];
	[objects release];
	[super dealloc];
}

@end
