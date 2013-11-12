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
    IVLog(@"<behavior>Superman \"%@\" walk...</behavior>", self.name);
}

- (void)attack {
    IVLog(@"<behavior>Superman \"%@\" attack...</behavior>", self.name);
}

- (void)defense {
    IVLog(@"<behavior>Superman \"%@\" defense...</behavior>", self.name);
}

- (void)fly {
    IVLog(@"<behavior>Superman \"%@\" fly...</behavior>", self.name);
}

- (void)dealloc {
    self.name = nil;
    self.age = nil;
    [super dealloc];
}

@end
