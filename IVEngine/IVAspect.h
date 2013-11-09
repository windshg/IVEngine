//
//  IVAspect.h
//  IVin
//
//  Created by Vinson Huang on 1/6/12.
//  Copyright (c) 2012 Vinson. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IVAspect <NSObject>

@required
// invoke before the original invocation
- (void)doBefore:(NSInvocation *)invocation;

// invoke after the original invocation
- (void)doAfter:(NSInvocation *)invocation;

@end
