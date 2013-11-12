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
    IVLog(@"<clothesAspect>%@ \"%@\" put on clothes...</clothesAspect>", [invocation.target class], [invocation.target name]);
}

- (void)doAfter:(NSInvocation *)invocation {
    IVLog(@"<clothesAspect>%@ \"%@\" take off clothes...</clothesAspect>", [invocation.target class], [invocation.target name]);
}

@end
