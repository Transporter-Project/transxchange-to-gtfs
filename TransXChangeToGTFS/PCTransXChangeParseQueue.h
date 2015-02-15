//
//  PCTransXChangeParseQueue.h
//  TransXChangeToGTFS
//
//  Created by Phillip Caudell on 20/09/2014.
//  Copyright (c) 2014 Phillip Caudell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCTransXChangeParseQueue : NSOperationQueue

@property (nonatomic, strong) NSString *outputDirectory;

- (void)addTransXChangeDocuments:(NSArray *)documents;

@end
