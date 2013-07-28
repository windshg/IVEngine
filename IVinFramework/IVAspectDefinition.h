//
//  IVAspectDefinition.h
//  IVin
//
//  Created by Vinson Huang on 1/3/12.
//  Copyright (c) 2012 Vinson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IVAspectJoinPoint.h"

@interface IVAspectDefinition : NSObject {
    NSString *name;
    NSString *className;
    
    //dictionary
    //key: join point expression
    //value: advice
    NSMutableArray *joinPointList;
}

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *className;
@property (nonatomic, retain) NSMutableArray *joinPointList;

- (void)addJoinPoint:(IVAspectJoinPoint *)joinPoint;

@end
