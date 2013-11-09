//
//  SuperMan.h
//  IVinFramework
//
//  Created by Vinson Huang on 1/3/12.
//  Copyright (c) 2012 Vinson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SuperMan : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSNumber *age;

- (void)walk;

- (void)attack;

- (void)defense;

- (void)fly;

@end
