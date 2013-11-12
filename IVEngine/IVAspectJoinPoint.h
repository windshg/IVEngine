//
//  IVAspectJoinPoint.h
//  IVin
//
//  Created by Vinson Huang on 1/4/12.
//  Copyright (c) 2012 Vinson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IVEntityContainer.h"

@interface IVAspectJoinPoint : NSObject {
    NSMutableArray * objectList;
    NSMutableArray * refMethodList;
    IVEntityContainer *container;
}

///--------------------------------------------------
/// @objectList Objects which this joinpoint affects.
///--------------------------------------------------

@property (nonatomic, retain) NSMutableArray * objectList;


///---------------------------------------------------------------
/// @refMethodList Name of selectors which this joinpoint affects.
///---------------------------------------------------------------

@property (nonatomic, copy) NSMutableArray * refMethodList;


///---------------------------------------------------------------
/// @container The container context this joinpoint take activity.
///---------------------------------------------------------------

@property (nonatomic, assign) IVEntityContainer *container;


/**
Initilize the joinpoint with expression and the context container
 
 @param expression The expression of all targets of this joinpoint
 
 @param aContainer The context container.
 
 @return The new Join Point Object
 
 */

- (id) initWithExpression:(NSString *)expression inContainer:(IVEntityContainer *)aContainer;

@end
