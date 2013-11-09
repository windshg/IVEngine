//
//  IVEntityProxy.m
//  InnoliFoundation
//
//  Created by Vinson Huang on 1/3/12.
//  Copyright 2011 Innoli Kft. All rights reserved.
//

#import "IVEntityProxy.h"
#import "IVInterceptorInfo.h"

@implementation IVEntityProxy

- (id) initWithInstance:(id)anObject {
    
    parentObject = [anObject retain];

    methodStartInterceptors = [[NSMutableArray alloc] init];
    methodEndInterceptors = [[NSMutableArray alloc] init];

    return self;
}

- (id) initWithNewInstanceOfClass:(Class) class {

    // create a new instance of the specified class
    id newInstance = [[class alloc] init];

    // invoke my designated initializer
    [self initWithInstance:newInstance];

    // release the new instance
    [newInstance release];

    // finally return the configured self
    return self;
}

- (BOOL)isKindOfClass:(Class)aClass;
{
    return [parentObject isKindOfClass:aClass];
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol;
{
    return [parentObject conformsToProtocol:aProtocol];
}

- (BOOL)respondsToSelector:(SEL)aSelector;
{
    return [parentObject respondsToSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector;
{
    return [parentObject methodSignatureForSelector:aSelector];
}

- (void) interceptMethodStartForSelector:(SEL)sel withInterceptorTarget:(id)target interceptorSelector:(SEL)selector {

    // make sure the target is not nil
    NSParameterAssert( target != nil );

    IVInterceptorInfo *info = [[IVInterceptorInfo alloc] init];

    // create the interceptorInfo
    info.interceptedSelector = sel;
    info.interceptorTarget = target;
    info.interceptorSelector = selector;

    // add to our list
    [methodStartInterceptors addObject:info];

    [info release];
}

- (void) interceptMethodEndForSelector:(SEL)sel withInterceptorTarget:(id)target interceptorSelector:(SEL)selector {
    
    // make sure the target is not nil
    NSParameterAssert( target != nil );
    
    IVInterceptorInfo *info = [[IVInterceptorInfo alloc] init];
    
    // create the interceptorInfo
    info.interceptedSelector = sel;
    info.interceptorTarget = target;
    info.interceptorSelector = selector;
    
    // add to our list
    [methodEndInterceptors addObject:info];
    
    [info release];
}

- (void) invokeOriginalMethod:(NSInvocation *)anInvocation {
    [anInvocation invoke];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation;
{
    SEL aSelector = [anInvocation selector];

    // check if the parent object responds to the selector ...
    if ( [parentObject respondsToSelector:aSelector] ) {

        [anInvocation setTarget:parentObject];

        //
        // Intercept the start of the method.
        //

        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

        for ( int i = 0; i < [methodStartInterceptors count]; i++ ) {

            // first search for this selector ...
            IVInterceptorInfo *oneInfo = [methodStartInterceptors objectAtIndex:i];

            if ( [oneInfo interceptedSelector] == aSelector ) {

                // extract the interceptor info
                id target = [oneInfo interceptorTarget];
                SEL selector = [oneInfo interceptorSelector];

                // finally invoke the interceptor
                [(NSObject *) target performSelector:selector withObject:anInvocation];
            }
        }

        [pool release];

        //
        // Invoke the original method ...
        //
        
        [self invokeOriginalMethod:anInvocation];

        
        //
        // Intercept the ending of the method.
        //
        
        NSAutoreleasePool *pool2 = [[NSAutoreleasePool alloc] init];
        
        for ( int i = 0; i < [methodEndInterceptors count]; i++ ) {
            
            // first search for this selector ...
            IVInterceptorInfo *oneInfo = [methodEndInterceptors objectAtIndex:i];
            
            if ( [oneInfo interceptedSelector] == aSelector ) {
                
                // extract the interceptor info
                id target = [oneInfo interceptorTarget];
                SEL selector = [oneInfo interceptorSelector];
                
                // finally invoke the interceptor
                [(NSObject *) target performSelector:selector withObject:anInvocation];
            }
        }
        
        [pool2 release];        
    } 
//    else {
//        [super forwardInvocation:invocation];
//    }
}

- (void) dealloc {
    [parentObject release];
    [methodStartInterceptors release];
    [methodEndInterceptors release];

    [super dealloc];
}

@end

