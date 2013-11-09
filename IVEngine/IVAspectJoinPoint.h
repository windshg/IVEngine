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

- (id) initWithExpression:(NSString *)expression inContainer:(IVEntityContainer *)aContainer;

@property (nonatomic, retain) NSMutableArray * objectList;
@property (nonatomic, copy) NSMutableArray * refMethodList;
@property (nonatomic, assign) IVEntityContainer *container;

@end
