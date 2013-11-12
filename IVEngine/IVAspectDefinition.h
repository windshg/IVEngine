//
//  IVAspectDefinition.h
//  IVin
//
//  Created by Vinson Huang on 1/3/12.
//  Copyright (c) 2012 Vinson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IVAspectJoinPoint.h"

@interface IVAspectDefinition : NSObject {
    NSString *name;
    NSString *className;
    /**
     element type: IVAspectJoinPoint
     */
    NSMutableArray *joinPointList;
}

///---------------------------------------------
/// @name Indicate to the Intercepter's Name
///---------------------------------------------

@property (nonatomic, copy) NSString *name;

///---------------------------------------------
/// @className Indicate to the Intercepter Class
///---------------------------------------------

@property (nonatomic, copy) NSString *className;

///--------------------------------------
/// @joinPointList Managing the JoinPoint
///--------------------------------------

@property (nonatomic, retain) NSMutableArray *joinPointList;

/**
 Finish the aop configuration in the inferent container.
 
 @param aContainer The container which accommodate the aop configuration job.
 
 */

- (void)addJoinPoint:(IVAspectJoinPoint *)joinPoint;

@end
