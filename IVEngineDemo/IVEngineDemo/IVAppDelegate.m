//
//  IVAppDelegate.m
//  IVEngineDemo
//
//  Created by Vinson.D.Warm on 11/9/13.
//  Copyright (c) 2013 Vinson.D.Warm. All rights reserved.
//

#import "IVAppDelegate.h"

#import "SuperMan.h"
#import "Army.h"

@implementation IVAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // build container from code configuration
    //    [self buildContainerFromCode];
    
    // build container from the configuration of context.xml
	[self buildContainerFromXML];
    
    return YES;
}

// build container from code configuration
- (void) buildContainerFromCode {
    
}

// build container from the configuration of context.xml
- (void) buildContainerFromXML {
	NSString *path =[[NSBundle mainBundle] pathForResource:@"context" ofType:@"xml"];
    if (path) {
        IVEntityContainerBuilder *builder = [[IVEntityContainerBuilder alloc] init];
        // method containerBuildingFinished will be called if container builded successfully
        [builder buildContainer:[NSURL fileURLWithPath:path] withDelegate:self];
        [builder release];
    } else {
        NSLog(@"Configuration XML file does not exist...");
    }
}

#pragma mark IVEntityContainerBuilderDelegate
- (void) containerBuildingFinished:(IVEntityContainer*) container {
    NSLog(@"----------------------------------------------------------------------------");
    SuperMan * s1 = [container getEntity:@"superman1"];
    [s1 walk];
    [s1 attack];
    [s1 defense];
    [s1 fly];
    NSLog(@"----------------------------------------------------------------------------");
    Army * a1 = [container getEntity:@"army1"];
	[a1 walk];
    [a1 attack];
    [a1 goToPlace:@"NewYork"];
    
    NSLog(@"----------------------------------------------------------------------------");
    SuperMan * s2 = [container getEntity:@"superman2"];
    [s2 walk];
    [s2 attack];
    [s2 defense];
    [s2 fly];
    NSLog(@"----------------------------------------------------------------------------");
    Army * a2 = [container getEntity:@"army2"];
	[a2 walk];
    [a2 attack];
    [a1 goToPlace:@"Paris"];
    NSLog(@"-------------------------------------------------------------------------------------");
    Army * a3 = [container getEntity:@"army3"];
	[a3 walk];
    [a3 attack];
    [a3 goToPlace:@"London"];
    
    NSLog(@"----------------------------------------------------------------------------");
    SuperMan * s3 = [container getEntity:@"superman3"];
    [s3 walk];
    [s3 attack];
    [s3 defense];
    [s3 fly];
    NSLog(@"-------------------------------------------------------------------------------------");
    Army * a4 = [container getEntity:@"army4"];
    [a4 walk];
    [a4 attack];
    [a3 goToPlace:@"Australia"];
}

- (void) containerBuildingError {
    NSLog(@"Container build error...");
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
