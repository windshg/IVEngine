//
//  IVCommonLogger.h
//  IVEngineDemo
//
//  Created by Vinson.D.Warm on 11/11/13.
//  Copyright (c) 2013 Vinson.D.Warm. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IVLog(frmt, ...) \
[[IVCommonLogger sharedLogger] writeLog:[NSString stringWithFormat:frmt, ##__VA_ARGS__]]

@interface IVCommonLogger : NSObject

- (void)writeLog:(NSString *)log;

- (NSString *)readLog;

+ (IVCommonLogger *)sharedLogger;

@end
