//
//  Army.m
//  IVinFramework
//
//  Created by Vinson Huang on 1/3/12.
//  Copyright (c) 2012 Vinson. All rights reserved.
//

#import "Army.h"

@implementation Army

@synthesize aid = _aid;
@synthesize name = _name;
@synthesize captain = _captain;

- (void)walk {
    NSLog(@"Army \"%@\" leaded by \"%@\" walk...", self.name, self.captain.name);
}

- (void)attack {
    NSLog(@"Army \"%@\" leaded by \"%@\" attack...", self.name, self.captain.name);
}

- (void)goToPlace:(NSString *)place {
    NSLog(@"Army \"%@\" leaded by \"%@\" go to \"%@\"...", self.name, self.captain.name, place);
}

- (void)dealloc {
    self.aid = nil;
    self.name = nil;
    self.captain = nil;
    [super dealloc];
}

@end
