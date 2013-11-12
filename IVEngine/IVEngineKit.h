//
//  IVEngineKit.h
//  IVEngineDemo
//
//  Created by Vinson.D.Warm on 11/9/13.
//  Copyright (c) 2013 Vinson.D.Warm. All rights reserved.
//

/**
 Import all the headers should be at most used during development. Theoretically, this kit only exposes the definition-like class to user because they are mapped from the xml configuration. User can either build the container from XML, which is the way recommended, or build container from code. The fronter one can make full use of the powerful capability of XML language while the latter one is limiting the way to create objects and aspects since user has to follow the rule of managing entities in IVEngin framework.
 
 Here clarify the mapping relationship between terms in code and the ones in XML.
 
 // An interface which any interceptor should implement.
 IVAspect
 
 // Indicate the definition of entity.
 IVEntityDefinition -> <entity></entity>
 
 // Indicate the definition of aspect.
 IVAspectDefinition -> <aspect></aspect>
 
 // Indicate the jointpoint
 IVAspectJoinPoint -> <joinpoint></joinpoint>
 
 // In this way, IVEntityContainer means a context to manage tho objects all.
 IVEntityContainer -> <container></container>
 
 Deployment:
 
 1. Add the IVEngine Kit to your project.
 2. As this kit is based on XML syntax parser, so before using this kit, you should add libxml2.2.dylib to your "Link Binary With Libraries" and "$SDKROOT/usr/include/libxml2" to your "Header Search Path". New a file named "context.xml" or anything else.
 
 Introduction:
 
 Please refer to https://github.com/windshg/IVEngine/blob/master/README.md
 
 
 Summary:
 
 This project is designed to implement a Spring-like framework in Objective-C on purpose to provide a solution to manage components in enterprise application, especially huge application with so much business logic. It makes good use of the powerful capability of XML and somehow it's not designed for view-based application actually. If you are interested enough to have a test. Please refer to the IVEngineDemo Project and enjoy the beauty of coding.
 
 */

#ifndef IVEngineDemo_IVEngineKit_h
#define IVEngineDemo_IVEngineKit_h

#import "IVEntityDefinition.h"
#import "IVAspect.h"
#import "IVAspectDefinition.h"
#import "IVAspectJoinPoint.h"
#import "IVEntityContainer.h"
#import "IVEntityContainerBuilder.h"

#endif
