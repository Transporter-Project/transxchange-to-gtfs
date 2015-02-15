//
//  PCCSVBuilder.h
//  TransXChange
//
//  Created by Phillip Caudell on 10/05/2014.
//  Copyright (c) 2014 Phillip Caudell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCCSVBuilder : NSObject

@property (nonatomic, strong) NSMutableArray *entries;
@property (nonatomic, strong) NSMutableDictionary *currentEntry;
@property (nonatomic, strong) NSArray *keys;
@property (nonatomic, strong, readonly) NSString *csvStringRepresentation;

- (void)setObject:(id)object forKey:(id<NSCopying>)aKey;
- (void)finishLine;
- (void)writeToFile:(NSString *)filePath;
- (NSString *)csvStringRepresentationWithHeaders:(BOOL)includeHeaders;

@end
