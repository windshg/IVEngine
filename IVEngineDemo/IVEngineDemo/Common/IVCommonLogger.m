//
//  IVCommonLogger.m
//  IVEngineDemo
//
//  Created by Vinson.D.Warm on 11/11/13.
//  Copyright (c) 2013 Vinson.D.Warm. All rights reserved.
//

#import "IVCommonLogger.h"

@interface IVCommonLogger ()

@property (nonatomic, retain) NSMutableString *logContext;

@end

@implementation IVCommonLogger

static IVCommonLogger *_logger;

@synthesize logContext = _logContext;

- (void)dealloc {
    self.logContext = nil;
    [super dealloc];
}

- (void)writeLog:(NSString *)log {
    [self.logContext appendFormat:@"\n%@", log];
}

- (NSString *)readLog {
    return self.logContext;
}

+ (IVCommonLogger *)sharedLogger {
    if (!_logger) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _logger = [[IVCommonLogger alloc] init];
        });
    }
    return _logger;
}

- (NSMutableString *)logContext {
    if (!_logContext) {
        _logContext = [[NSMutableString alloc] init];
    }
    return _logContext;
}

@end
