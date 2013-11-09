//
//  ClothesInterceptor.m
//  IVEngineDemo
//
//  Created by Vinson.D.Warm on 11/9/13.
//  Copyright (c) 2013 Vinson.D.Warm. All rights reserved.
//

#import "ClothesInterceptor.h"

@implementation ClothesInterceptor

- (void)doBefore:(NSInvocation *)invocation {
    NSLog(@"--> %@ \"%@\" put on clothes...", [invocation.target class], [invocation.target name]);
}

- (void)doAfter:(NSInvocation *)invocation {
    NSLog(@"--> %@ \"%@\" take off clothes...", [invocation.target class], [invocation.target name]);
}

@end
