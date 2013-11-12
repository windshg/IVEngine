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
    
    ///---------------------------
    /// @context Context of libxml
    ///---------------------------
    
	xmlParserCtxtPtr context;
    
    ///---------------------------------------------
    /// @container The container about to be builded
    ///---------------------------------------------
    
	IVEntityContainer *container;
    
    ///----------------------------------------------------------------------------------------
    /// @objectDefinition The buffer entity definition used for generating the relative entity.
    ///----------------------------------------------------------------------------------------
    
	IVEntityDefinition *objectDefinition;
    
    ///-----------------------------------------------------------------------
    /// @IVAspectWeaver The component responsible for configuration of aspect.
    ///-----------------------------------------------------------------------
    
    IVAspectWeaver *IVAspectWeaver;
    
    ///---------------------------------------------------------------------------------------------
    /// @aspectDefinition The buffer aspect definition used for generating the relative interceptor.
    ///---------------------------------------------------------------------------------------------
    
    IVAspectDefinition *aspectDefinition;
    
    ///-----------------------------
    /// @delegate Callback delegate.
    ///-----------------------------
    
	id<IVEntityContainerBuilderDelegate> delegate;
}

/**
Build a IVEngine container.
 
 @param aDelegate The callback delegate.
 
 */

- (void) buildContainer: (NSURL*) xmlUrl withDelegate: (id<IVEntityContainerBuilderDelegate>) aDelegate;

@end
