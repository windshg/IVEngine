//
//  GlassesInterceptor.m
//  IVEngineDemo
//
//  Created by Vinson.D.Warm on 11/9/13.
//  Copyright (c) 2013 Vinson.D.Warm. All rights reserved.
//

#import "GlassesInterceptor.h"

@implementation GlassesInterceptor

- (void)doBefore:(NSInvocation *)invocation {
    NSLog(@"--> %@ \"%@\" put on glasses...", [invocation.target class], [invocation.target name]);
}

- (void)doAfter:(NSInvocation *)invocation {
    NSLog(@"--> %@ \"%@\" take off glasses...", [invocation.target class], [invocation.target name]);
}

@end
