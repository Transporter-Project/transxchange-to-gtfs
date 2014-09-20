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
    // Insert code here to initialize your application
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"bmth" ofType:@"xml"];
    PCTransXChangeDocument *document = [PCTransXChangeDocument documentWithPath:path];
    
    
    
//    [operation start];
}

@end
