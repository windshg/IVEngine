//
//  AOPWeaver.h
//  IVin
//
//  Created by Vinson Huang on 1/3/12.
//  Copyright (c) 2012 Vinson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IVAspectDefinition.h"
#import "IVEntityContainer.h"

@interface IVAspectWeaver : NSObject {
    IVEntityContainer * container;
    NSMutableArray *aspectDefinitions;
}

///-------------------------------------------------
/// @aspectDefinitions Contain all aspect definition
///-------------------------------------------------

@property (nonatomic, retain) NSMutableArray *aspectDefinitions;

///------------------------------
/// @container Relative container
///------------------------------

@property (nonatomic, assign) IVEntityContainer * container;


/**
 Add an aspectDefinition to this aspect weaver
 
 @param aspectDefinition The pointer to the new aspect definition.
 
 */

- (void)addAspectDefinition:(IVAspectDefinition *)aspectDefinition;


/**
 Finish the aop configuration in the inferent container.
 
 @param aContainer The container which accommodate the aop configuration job.
 
 */

- (void)configureInContainer:(IVEntityContainer *)aContainer;

@end
