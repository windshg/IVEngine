//
//  IVInterceptorInfo.h
//  InnoliFoundation
//
//  Created by Vinson Huang on 1/3/12.
//  Copyright 2011 Innoli Kft. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface IVInterceptorInfo : NSObject {

@private
    SEL interceptedSelector;
    id interceptorTarget;
    SEL interceptorSelector;
}

///---------------------------------------------
/// @interceptedSelector The method intercepted.
///---------------------------------------------

@property (assign, nonatomic) SEL interceptedSelector;

///----------------------------------------------
/// @interceptedSelector The interceptor's method.
///----------------------------------------------

@property (assign, nonatomic) SEL interceptorSelector;

///---------------------------------------------
/// @interceptedSelector The target intercepted.
///---------------------------------------------

@property (assign, nonatomic) id interceptorTarget;

@end

