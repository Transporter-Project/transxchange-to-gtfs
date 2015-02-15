//
//  PCCSVBuilder.m
//  TransXChange
//
//  Created by Phillip Caudell on 10/05/2014.
//  Copyright (c) 2014 Phillip Caudell. All rights reserved.
//

#import "PCCSVBuilder.h"

@implementation PCCSVBuilder

- (id)init
{
    if (self = [super init]) {
        
        self.entries = [NSMutableArray array];
        self.currentEntry = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (void)setObject:(id)object forKey:(id<NSCopying>)aKey
{
    if (!object || !aKey) {
        return;
    }
    
    [self.currentEntry setObject:object forKey:aKey];
}

- (void)finishLine
{
    [self.entries addObject:self.currentEntry];
    self.currentEntry = [NSMutableDictionary dictionary];
}

- (NSString *)csvStringRepresentation
{
    return [self csvStringRepresentationWithHeaders:YES];
}

- (NSString *)csvStringRepresentationWithHeaders:(BOOL)includeHeaders
{
    NSMutableString *string = [NSMutableString string];
    
    // Add keys to 'header'
    if (includeHeaders) {
        [string appendString:[self.keys componentsJoinedByString:@","]];
        [string appendString:@"\n"];
    }

    for (NSDictionary *entry in self.entries) {
        
        // Append each entry for that key
        for (NSString *key in self.keys) {
            
            id object = entry[key];
            
            if (object) {
                
                if ([object isKindOfClass:[NSString class]]) {
                    
                    if ([(NSString *)object rangeOfString:@","].location != NSNotFound) {
                    
                        [string appendString:[NSString stringWithFormat:@"\"%@\"", entry[key]]];
                    } else {
                        [string appendString:entry[key]];
                    }
                }
                
                if ([object isKindOfClass:[NSNumber class]]) {
                    [string appendString:[object stringValue]];
                }
                
                if ([object isKindOfClass:[NSDate class]]) {
                    [string appendString:[NSString stringWithFormat:@"%f", [object timeIntervalSince1970]]];
                }
            }
            
            [string appendString:@","];
        }
        
        [string appendString:@"\n"];
    }
    
    return string;
}

- (void)writeToFile:(NSString *)filePath
{
//    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
//        
//        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
//    }
    
//    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
    
        // Don't include headers if file already exists
//        NSData *data = [[self csvStringRepresentationWithHeaders:NO] dataUsingEncoding:NSUTF8StringEncoding];
//
//        NSMutableData *existingData = [NSMutableData dataWithContentsOfFile:filePath];
//        [existingData appendData:data];
//        [existingData writeToFile:filePath atomically:YES];
//        
//    } else {
//        
        NSData *data = [self.csvStringRepresentation dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error = nil;
    
    [data writeToFile:filePath options:NSDataWritingAtomic error:&error];
    
//    NSLog(@"---- Error: %@", error);
//    }
}

@end
