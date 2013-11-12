//
//  ShoesInterceptor.m
//  IVEngineDemo
//
//  Created by Vinson.D.Warm on 11/9/13.
//  Copyright (c) 2013 Vinson.D.Warm. All rights reserved.
//

#import "ShoesInterceptor.h"

@implementation ShoesInterceptor

- (void)doBefore:(NSInvocation *)invocation {
    IVLog(@"<shoesAspect>%@ \"%@\" put on shoes...</shoesAspect>", [invocation.target class], [invocation.target name]);
}

- (void)doAfter:(NSInvocation *)invocation {
    IVLog(@"<shoesAspect>%@ \"%@\" take off shoes...</shoesAspect>", [invocation.target class], [invocation.target name]);
}

@end
