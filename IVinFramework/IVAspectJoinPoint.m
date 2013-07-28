//
//  IVAspectJoinPoint.m
//  IVin
//
//  Created by Vinson Huang on 1/4/12.
//  Copyright (c) 2012 Vinson. All rights reserved.
//

#import "IVAspectJoinPoint.h"

#define EXPRESSION_SIGN_OBJECT (@"object")
#define EXPRESSION_SIGN_CLASS (@"class")
#define EXPRESSION_SLICER (@"||")

@interface  IVAspectJoinPoint ()
- (void)parseFromExpression:(NSString *)expression;
- (NSMutableArray *) extractMethodsFromString:(NSString *) expression;
@end

@implementation IVAspectJoinPoint

@synthesize objectList;
@synthesize refMethodList;
@synthesize container;

- (id) initWithExpression:(NSString *)expression inContainer:(id)aContainer {
    self = [super init];
    if (self) {
        self.container = aContainer;
        [self parseFromExpression:expression];
    }
    return self;
}

- (void)parseFromExpression:(NSString *)expression {
    NSMutableArray * result = [[NSMutableArray alloc] init];
    NSArray * signs = [expression componentsSeparatedByString:EXPRESSION_SLICER];
    NSString * firstSign = (NSString *)[signs objectAtIndex:0];
    if ([firstSign isEqualToString:EXPRESSION_SIGN_OBJECT]) {
        if ([[signs objectAtIndex:1] isEqualToString:@"*"]) {
            [result addObjectsFromArray:[container.definitions allKeys]];
        } else {
            NSArray * objNames = [[signs objectAtIndex:1] componentsSeparatedByString:@","];
            [result addObjectsFromArray:objNames];
        }
    } else if ([firstSign isEqualToString:EXPRESSION_SIGN_CLASS]) {
        NSString *secondSign = [signs objectAtIndex:1];
        if ([secondSign isEqualToString:@"*"]) {
            [result addObjectsFromArray:[container.definitions allKeys]];
        } else {
            NSArray * classNames = [secondSign componentsSeparatedByString:@","];
            for (IVEntityDefinition * definition in [container.definitions allValues]) {
                if ([classNames containsObject:definition.className]) {
                    [result addObject:definition.name];
                }
            }
        }
    }
    self.objectList = result;
    [result release];
    
    self.refMethodList = [self extractMethodsFromString:[signs objectAtIndex:2]];
}

- (NSMutableArray *) extractMethodsFromString:(NSString *) expression {
    NSMutableArray * result = [[NSMutableArray alloc] init];
    NSArray * methodSources = [expression componentsSeparatedByString:@","];
    for (NSString * methodSource in methodSources) {
        [result addObject:[methodSource substringWithRange:NSMakeRange(1, (methodSource.length - 2))]];
    }
    return result;
}


- (void)dealloc {
    [objectList release];
    [refMethodList release];
    [super dealloc];
}

@end
