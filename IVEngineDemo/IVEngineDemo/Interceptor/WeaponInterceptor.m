//
//  WeaponInterceptor.m
//  OxenIoc
//
//  Created by Vinson.D.Warm on 11/9/13.
//
//

#import "WeaponInterceptor.h"
#import "SuperMan.h"

@implementation WeaponInterceptor

- (void)doBefore:(NSInvocation *)invocation {
    IVLog(@"<weaponAspect>%@ \"%@\" equip weapon...</weaponAspect>", [invocation.target class], [invocation.target name]);
}

- (void)doAfter:(NSInvocation *)invocation {
    IVLog(@"<weaponAspect>%@ \"%@\" relieve weapon...</weaponAspect>", [invocation.target class], [invocation.target name]);
}

@end
