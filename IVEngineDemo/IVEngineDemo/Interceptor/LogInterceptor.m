//
//  LogInterceptor.m
//  IVin
//
//  Created by Vinson Huang on 1/4/12.
//  Copyright (c) 2012 Vinson. All rights reserved.
//

#import "LogInterceptor.h"

@implementation LogInterceptor 

- (void)doBefore:(NSInvocation *)invocation {
    IVLog(@"--> Before \"%@\" %@...", [invocation.target class], NSStringFromSelector(invocation.selector));
}

- (void)doAfter:(NSInvocation *)invocation {
    IVLog(@"--> After \"%@\" %@...", [invocation.target class], NSStringFromSelector(invocation.selector));
}

@end
