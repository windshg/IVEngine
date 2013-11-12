//
//  Army.m
//  IVinFramework
//
//  Created by Vinson Huang on 1/3/12.
//  Copyright (c) 2012 Vinson. All rights reserved.
//

#import "Army.h"
#import "SuperMan.h"

@implementation Army

@synthesize aid = _aid;
@synthesize name = _name;
@synthesize captain = _captain;

- (void)walk {
    IVLog(@"<behavior>Army \"%@\" leaded by \"%@\" walk...</behavior>", self.name, self.captain.name);
}

- (void)attack {
    IVLog(@"<behavior>Army \"%@\" leaded by \"%@\" attack...</behavior>", self.name, self.captain.name);
}

- (void)goToPlace:(NSString *)place {
    IVLog(@"<behavior>Army \"%@\" leaded by \"%@\" go to \"%@\"...</behavior>", self.name, self.captain.name, place);
}

- (void)dealloc {
    self.aid = nil;
    self.name = nil;
    self.captain = nil;
    [super dealloc];
}

@end
