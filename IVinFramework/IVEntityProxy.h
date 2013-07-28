//
//  IVEntityProxy.h
//  InnoliFoundation
//
//  Created by Vinson Huang on 1/3/12.
//  Copyright 2011 Innoli Kft. All rights reserved.
//

#import <Foundation/Foundation.h>


/*!
    @class       IVEntityProxy
    @abstract    The IVEntityProxy is a simple Aspect Oriented Programming like proxy.
 */
@interface IVEntityProxy : NSProxy {

@protected
    id parentObject;
    NSMutableArray *methodStartInterceptors;
    NSMutableArray *methodEndInterceptors;
}


/*!
    @method     initWithInstance:
    @abstract   Creates a new proxy with using the instance provided as the parameter.
 */
- (id) initWithInstance:(id)anObject;

/*!
    @method     initWithNewInstanceOfClass:
    @abstract   Creates a new proxy and forwards all calls to a new instance of the specified class
 */
- (id) initWithNewInstanceOfClass:(Class) class;

/*!
    @method     interceptMethodStartForSelector:withInterceptorTarget:interceptorSelector:
    @abstract   This method will cause the proxy to invoke the interceptor selector on the interceptor
        target whenever the aSel selector is invoked on this proxy.
    @discussion The interceptor selector must take exactly one parameter, which will be NSInvocation instance
        for the invocation that was intercepted.
 */
- (void) interceptMethodStartForSelector:(SEL)sel withInterceptorTarget:(id)target interceptorSelector:(SEL)selector;

/*!
 @method     interceptMethodEndForSelector:withInterceptorTarget:interceptorSelector:
 @abstract   This method will cause the proxy to invoke the interceptor selector on the interceptor
    target after the aSel selector is invoked on this proxy.
 @discussion The interceptor selector must take exactly one parameter, which will be NSInvocation instance
    for the invocation that was intercepted.
 */
- (void) interceptMethodEndForSelector:(SEL)sel withInterceptorTarget:(id)target interceptorSelector:(SEL)selector;


// Override point for subclassers to implement different invoking behavior
- (void) invokeOriginalMethod:(NSInvocation *)anInvocation;

@end

