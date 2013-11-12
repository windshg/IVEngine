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
    IVLog(@"<glassesAspect>%@ \"%@\" put on glasses...</glassesAspect>", [invocation.target class], [invocation.target name]);
}

- (void)doAfter:(NSInvocation *)invocation {
    IVLog(@"<glassesAspect>%@ \"%@\" take off glasses...</glassesAspect>", [invocation.target class], [invocation.target name]);
}

@end
