//
//  Army.h
//  IVinFramework
//
//  Created by Vinson Huang on 1/3/12.
//  Copyright (c) 2012 Vinson. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SuperMan;

@interface Army : NSObject

@property (nonatomic, copy) NSString * aid;
@property (nonatomic, retain) SuperMan *captain;
@property (nonatomic, copy) NSString * name;

- (void)walk;

- (void)attack;

- (void)goToPlace:(NSString *)place;

@end
