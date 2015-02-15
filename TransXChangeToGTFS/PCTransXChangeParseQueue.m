//
//  PCTransXChangeParseQueue.m
//  TransXChangeToGTFS
//
//  Created by Phillip Caudell on 20/09/2014.
//  Copyright (c) 2014 Phillip Caudell. All rights reserved.
//

#import "PCTransXChangeParseQueue.h"
#import "PCTransXChangeKit.h"

@implementation PCTransXChangeParseQueue

- (void)addTransXChangeDocuments:(NSArray *)documents
{
    [documents enumerateObjectsUsingBlock:^(PCTransXChangeDocument *document, NSUInteger idx, BOOL *stop) {
        
        PCTransXChangeParseOperation *operation = [PCTransXChangeParseOperation operationWithTransXChangeDocument:document];
        operation.outputDirectory = self.outputDirectory;
        [self addOperation:operation];
    }];
}

@end
