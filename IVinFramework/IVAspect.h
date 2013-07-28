//
//  IVAspect.h
//  IVin
//
//  Created by Vinson Huang on 1/6/12.
//  Copyright (c) 2012 Vinson. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IVAspect <NSObject>

@optional

- (void)doBefore:(NSInvocation *)invocation;

- (void)doAfter:(NSInvocation *)invocation;

@end
