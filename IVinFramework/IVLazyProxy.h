//
//  IVLazyProxy.h
//  IVin
//
//  Created by Vinson Huang on 1/3/12.
//  Copyright 2012 Vinson. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface IVLazyProxy : NSProxy {
	id realObject;
	NSString *className;
}

@end
