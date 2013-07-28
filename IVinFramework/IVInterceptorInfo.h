//
//  IVInterceptorInfo.h
//  InnoliFoundation
//
//  Created by Vinson Huang on 1/3/12.
//  Copyright 2011 Innoli Kft. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface IVInterceptorInfo : NSObject {

@private
    SEL interceptedSelector;
    id interceptorTarget;
    SEL interceptorSelector;
}

@property (assign, nonatomic) SEL interceptedSelector;
@property (assign, nonatomic) SEL interceptorSelector;
@property (assign, nonatomic) id interceptorTarget;

@end

