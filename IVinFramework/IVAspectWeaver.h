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

- (void)addAspectDefinition:(IVAspectDefinition *)aspectDefinition;

- (void)configureInContainer:(IVEntityContainer *)aContainer;

@end
