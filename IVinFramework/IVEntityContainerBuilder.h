//
//  IVEntityContainerBuilder.h
//  IVin
//
//  Created by Vinson Huang on 1/3/12.
//  Copyright 2012 Vinson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IVEntityContainer.h"
#import "IVEntityDefinition.h"
#import <libxml/tree.h>
#import "IVEntityContainerBuilderDelegate.h"
#import "IVAspectWeaver.h"

@interface IVEntityContainerBuilder : NSObject {
	xmlParserCtxtPtr context;
    
	IVEntityContainer *container;
	IVEntityDefinition *objectDefinition;
    
    IVAspectWeaver *IVAspectWeaver; // used for aop config
    IVAspectDefinition *aspectDefinition;
    
	id<IVEntityContainerBuilderDelegate> delegate;
}

- (void) buildContainer: (NSURL*) xmlUrl withDelegate: (id<IVEntityContainerBuilderDelegate>) aDelegate;

@end
