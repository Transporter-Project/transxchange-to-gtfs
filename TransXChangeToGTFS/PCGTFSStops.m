//
//  PCGTFSStops.m
//  TransXChangeToGTFS
//
//  Created by Phillip Caudell on 14/09/2014.
//  Copyright (c) 2014 Phillip Caudell. All rights reserved.
//

#import "PCGTFSStops.h"
#import "PCTransXChangeKit.h"

@implementation PCGTFSStops

- (void)parse
{
    NSMutableArray *stops = [NSMutableArray array];
    
    ONOXMLElement *stopPoints = [self.document.rootElement firstChildWithTag:@"StopPoints"];
    
    [stopPoints.children enumerateObjectsUsingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL *s) {
       
        NSMutableDictionary *stop = [NSMutableDictionary dictionary];
        stop[PCGTFSStopIdentifier] = [[element firstChildWithTag:@"StopPointRef"] stringValue];
        stop[PCGTFSStopName] = [[element firstChildWithTag:@"CommonName"] stringValue];
        stop[PCGTFSStopDescription] = [[element firstChildWithTag:@"LocalityName"] stringValue];
        
        [stops addObject:stop];
    }];
    
    self.stops = stops;
    
    NSLog(@"Stops: %@", self.stops);
}

@end
