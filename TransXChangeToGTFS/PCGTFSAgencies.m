//
//  PCGTFSAgency.m
//  TransXChangeToGTFS
//
//  Created by Phillip Caudell on 14/09/2014.
//  Copyright (c) 2014 Phillip Caudell. All rights reserved.
//

#import "PCGTFSAgencies.h"
#import "PCTransXChangeKit.h"

@implementation PCGTFSAgencies

- (void)parse
{
    NSMutableArray *agencies = [NSMutableArray array];
    
    ONOXMLElement *operators = [self.document.rootElement firstChildWithTag:@"Operators"];
    
    [operators.children enumerateObjectsUsingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL *stop) {
        
        NSMutableDictionary *agency = [NSMutableDictionary dictionary];
        
        agency[PCGTFSAgencyIdentifier] = [[element firstChildWithTag:@"OperatorCode"] stringValue];
        agency[PCGTFSAgencyName] = [[element firstChildWithTag:@"OperatorShortName"] stringValue];
        agency[PCGTFSAgencyTimeZone] = @"Europe/London";
        
        [agencies addObject:agency];
    }];

    self.agencies = agencies;
    
//    NSLog(@"Agencies: %@", self.agencies);
}

@end
