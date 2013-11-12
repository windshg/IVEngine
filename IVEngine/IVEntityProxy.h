//
//  IVEntityProxy.h
//  InnoliFoundation
//
//  Created by Vinson Huang on 1/3/12.
//  Copyright 2011 Innoli Kft. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface IVEntityProxy : NSProxy {

@protected
    id parentObject;
    NSMutableArray *methodStartInterceptors;
    NSMutableArray *methodEndInterceptors;
}


/**
Creates a new proxy with using the instance provided as the parameter.
 
 @param anObject The target object.
 
 */

- (id) initWithInstance:(id)anObject;


/**
Creates a new proxy and forwards all calls to a new instance of the specified class
 
 @param aClass The class of target object.
 
 */

- (id) initWithNewInstanceOfClass:(Class) aClass;


/**
 The interceptor selector must take exactly one parameter, which will be NSInvocation instance
 for the invocation that was intercepted.
 
 @param targetSelector The method be intercepted
 
 @param target The target entity.
 
 @param interceptSelector The method to intercept the target's method.
 
 */

- (void) interceptMethodStartForSelector:(SEL)targetSelector withInterceptorTarget:(id)target interceptorSelector:(SEL)interceptSelector;


/**
 The interceptor selector must take exactly one parameter, which will be NSInvocation instance
 for the invocation that was intercepted.
 
 @param targetSelector The method be intercepted
 
 @param target The target entity.
 
 @param interceptSelector The method to intercept the target's method.
 
 */

- (void) interceptMethodEndForSelector:(SEL)targetSelector withInterceptorTarget:(id)target interceptorSelector:(SEL)interceptSelector;

/**
Override point for subclassers to implement different invoking behavior
 
 @param anInvocation The raw invocation for the original selector of the target entity.
 
 */

- (void) invokeOriginalMethod:(NSInvocation *)anInvocation;

@end

