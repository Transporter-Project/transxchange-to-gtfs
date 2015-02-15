//
//  PCAppDelegate.m
//  TransXChangeToGTFS
//
//  Created by Phillip Caudell on 14/09/2014.
//  Copyright (c) 2014 Phillip Caudell. All rights reserved.
//

#import "PCAppDelegate.h"

@implementation PCAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    PCTransXChangeDocument *document = [PCTransXChangeDocument documentWithPath:[[NSBundle mainBundle] pathForResource:@"m2" ofType:@"xml"]];

    self.queue = [PCTransXChangeParseQueue new];
    self.queue.outputDirectory = [@"~/Desktop" stringByExpandingTildeInPath];
    [self.queue addTransXChangeDocuments:@[document]];
}

@end