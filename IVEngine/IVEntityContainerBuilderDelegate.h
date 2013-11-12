//
//  IVEntityContainerBuilderDelegate.h
//  IVin
//
//  Created by Vinson Huang on 1/3/12.
//  Copyright 2012 Vinson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IVEntityContainer.h"

@protocol IVEntityContainerBuilderDelegate

/**
Be called once the container builded successfully.
 
 @container The relative container.
 
 */

- (void) containerBuildingFinished:(IVEntityContainer*) container;


/**
Be called once the container builded failedly.
 
 */

- (void) containerBuildingError;

@end
