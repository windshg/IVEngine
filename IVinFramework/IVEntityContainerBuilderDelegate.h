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
- (void) containerBuildingFinished:(IVEntityContainer*) container;
- (void) containerBuildingError;
@end
