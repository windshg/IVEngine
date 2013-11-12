//
//  IVViewController.m
//  IVEngineDemo
//
//  Created by Vinson.D.Warm on 11/9/13.
//  Copyright (c) 2013 Vinson.D.Warm. All rights reserved.
//

#import "IVViewController.h"
#import "FTCoreTextStyle.h"
#import "FTCoreTextView.h"
#import "IVCommonLogger.h"
#import "IVEngineKit.h"
#import "SuperMan.h"
#import "Army.h"

@interface IVViewController () <FTCoreTextViewDelegate, IVEntityContainerBuilderDelegate>

@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) FTCoreTextView *coreTextView;

@end

@implementation IVViewController

@synthesize scrollView;
@synthesize coreTextView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // build container from the configuration of context.xml
    [self buildContainerFromXML];
}

// build container from the configuration of context.xml
- (void) buildContainerFromXML {
	NSString *path =[[NSBundle mainBundle] pathForResource:@"context" ofType:@"xml"];
    if (path) {
        IVEntityContainerBuilder *builder = [[IVEntityContainerBuilder alloc] init];
        [builder buildContainer:[NSURL fileURLWithPath:path] withDelegate:self];
        [builder release];
    } else {
        NSLog(@"Configuration XML file does not exist...");
    }
}

#pragma mark IVEntityContainerBuilderDelegate

- (void) containerBuildingFinished:(IVEntityContainer*) container {
    [self initLogFromContainer:container];
    
    //add coretextview
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
	scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    coreTextView = [[FTCoreTextView alloc] initWithFrame:CGRectMake(20, 20, 280, 0)];
	coreTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    // set text
    [coreTextView setText:[self textForView]];
    // set styles
    [coreTextView addStyles:[self coreTextStyle]];
    // set delegate
    [coreTextView setDelegate:self];
	
	[coreTextView fitToSuggestedHeight];
    
    [scrollView addSubview:coreTextView];
    [scrollView setContentSize:CGSizeMake(CGRectGetWidth(scrollView.bounds), CGRectGetHeight(coreTextView.frame) + 40)];
    
    [self.view addSubview:scrollView];
}

- (void)initLogFromContainer:(IVEntityContainer*) container {
    // superman1
    SuperMan * s1 = [container getEntity:@"superman1"];
    [s1 walk];
    [s1 attack];
    [s1 defense];
    [s1 fly];
    // army1
    Army * a1 = [container getEntity:@"army1"];
	[a1 walk];
    [a1 attack];
    [a1 goToPlace:@"NewYork"];
    // superman2
    SuperMan * s2 = [container getEntity:@"superman2"];
    [s2 walk];
    [s2 attack];
    [s2 defense];
    [s2 fly];
    // army2
    Army * a2 = [container getEntity:@"army2"];
	[a2 walk];
    [a2 attack];
    [a2 goToPlace:@"Paris"];
    // army3
    Army * a3 = [container getEntity:@"army3"];
	[a3 walk];
    [a3 attack];
    [a3 goToPlace:@"London"];
    // superman3
    SuperMan * s3 = [container getEntity:@"superman3"];
    [s3 walk];
    [s3 attack];
    [s3 defense];
    [s3 fly];
    // army4
    Army * a4 = [container getEntity:@"army4"];
    [a4 walk];
    [a4 attack];
    [a4 goToPlace:@"Australia"];
}

- (void) containerBuildingError {
    // TO Handle Error
}

#pragma mark View Data Source

- (NSString *)textForView
{
    return [[IVCommonLogger sharedLogger] readLog];
}

- (NSArray *)coreTextStyle
{
    NSMutableArray *result = [NSMutableArray array];
    
    // default stytle configured for output log in root view.
	FTCoreTextStyle *defaultStyle = [FTCoreTextStyle new];
	defaultStyle.name = FTCoreTextTagDefault;
	defaultStyle.font = [UIFont fontWithName:@"TimesNewRomanPSMT" size:15.f];
    defaultStyle.paragraphInset = UIEdgeInsetsMake(0, 0, 15, 0);
	defaultStyle.textAlignment = FTCoreTextAlignementCenter;
	[result addObject:defaultStyle];
    
    // <behavior></behavior>
    FTCoreTextStyle *behaviorStyle = [defaultStyle copy];
    behaviorStyle.name = @"behavior";
	[result addObject:behaviorStyle];
    
    // <logAspect></logAspect>
    FTCoreTextStyle *logAspectStyle = [defaultStyle copy];
    logAspectStyle.name = @"logAspect";
    logAspectStyle.color = [UIColor blackColor];
	[result addObject:logAspectStyle];
    
    // <weaponAspect></weaponAspect>
    FTCoreTextStyle *weaponAspectStyle = [defaultStyle copy];
    weaponAspectStyle.name = @"weaponAspect";
    weaponAspectStyle.color = [UIColor redColor];
	[result addObject:weaponAspectStyle];
    
    // <clothesAspect></clothesAspect>
    FTCoreTextStyle *clothesAspectStyle = [defaultStyle copy];
    clothesAspectStyle.name = @"clothesAspect";
    clothesAspectStyle.color = [UIColor blueColor];
	[result addObject:clothesAspectStyle];
    
    // <shoesAspect></shoesAspect>
    FTCoreTextStyle *shoesAspectStyle = [defaultStyle copy];
    shoesAspectStyle.name = @"shoesAspect";
    shoesAspectStyle.color = [UIColor orangeColor];
	[result addObject:shoesAspectStyle];
    
    // <glassesAspect></glassesAspect>
    FTCoreTextStyle *glassesAspectStyle = [defaultStyle copy];
    glassesAspectStyle.name = @"glassesAspect";
    glassesAspectStyle.color = [UIColor magentaColor];
	[result addObject:glassesAspectStyle];
    
    return  result;
}

#pragma mark - FTCoreTextViewDelegate

- (void)coreTextView:(FTCoreTextView *)acoreTextView receivedTouchOnData:(NSDictionary *)data
{
    NSURL *url = [data objectForKey:FTCoreTextDataURL];
    if (!url) return;
    [[UIApplication sharedApplication] openURL:url];
}


@end
