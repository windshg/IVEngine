//
//  SuperMan.m
//  IVinFramework
//
//  Created by Vinson Huang on 1/3/12.
//  Copyright (c) 2012 Vinson. All rights reserved.
//

#import "SuperMan.h"

@implementation SuperMan

@synthesize name = _name;
@synthesize age = _age;

- (void)walk {
    NSLog(@"Superman \"%@\" walk...", self.name);
}

- (void)attack {
    NSLog(@"Superman \"%@\" attack...", self.name);
}

- (void)defense {
    NSLog(@"Superman \"%@\" defense...", self.name);
}

- (void)fly {
    NSLog(@"Superman \"%@\" fly...", self.name);
}

- (void)dealloc {
    self.name = nil;
    self.age = nil;
    [super dealloc];
}

@end
