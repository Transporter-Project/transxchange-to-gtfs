//
//  PCGTFSStopTimes.m
//  TransXChangeToGTFS
//
//  Created by Phillip Caudell on 14/09/2014.
//  Copyright (c) 2014 Phillip Caudell. All rights reserved.
//

#import "PCGTFSStopTimes.h"
#import "PCTransXChangeKit.h"

@implementation PCGTFSStopTimes

- (void)parse
{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"HH:mm:ss";
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [NSDateComponents new];
    
    NSMutableArray *stopTimes = [NSMutableArray array];
    
    ONOXMLElement *vehicleJourneys = [self.document.rootElement firstChildWithTag:@"VehicleJourneys"];
    
    [vehicleJourneys.children enumerateObjectsUsingBlock:^(ONOXMLElement *vehicleJourneyElement, NSUInteger idx, BOOL *stop) {
        
        NSString *departureTime = [[vehicleJourneyElement firstChildWithTag:@"DepartureTime"] stringValue];
        NSString *vehicleJourneyCode = [[vehicleJourneyElement firstChildWithTag:@"VehicleJourneyCode"] stringValue];
        NSString *baseDepartureTime = [[vehicleJourneyElement firstChildWithTag:@"DepartureTime"] stringValue];
        ONOXMLElement *journeyPatternElement = [self journeyPatternElementForIdentifier:[[vehicleJourneyElement firstChildWithTag:@"JourneyPatternRef"] stringValue]];
        ONOXMLElement *journeyPatternSectionElement = [self journeyPatternSectionElementForIdentifier:[[journeyPatternElement firstChildWithTag:@"JourneyPatternSectionRefs"] stringValue]];
        NSArray *timingLinkElements = [journeyPatternSectionElement childrenWithTag:@"JourneyPatternTimingLink"];
        NSString *tripIdentifier = [NSString stringWithFormat:@"%@-%@", vehicleJourneyCode, departureTime];
        __block NSString *currentTime = baseDepartureTime;
        
        [timingLinkElements enumerateObjectsUsingBlock:^(ONOXMLElement *timingLinkElement, NSUInteger idx, BOOL *stop) {
            
            ONOXMLElement *fromElement = [timingLinkElement firstChildWithTag:@"From"];
            NSString *runtime  = [[timingLinkElement firstChildWithTag:@"RunTime"] stringValue];

            NSMutableDictionary *stopTime = [NSMutableDictionary dictionary];
            stopTime[PCGTFSTripIdentifierKey] = tripIdentifier;
            stopTime[PCGTFSStopTimesDepartureTimeKey] = currentTime;
            stopTime[PCGTFSStopTimesArrivalTimeKey] = currentTime;
            stopTime[PCGTFSStopTimesSequenceKey] = fromElement.attributes[@"SequenceNumber"];
            stopTime[PCGTFSStopIdentifier] = [[fromElement firstChildWithTag:@"StopPointRef"] stringValue];
            
            [stopTimes addObject:stopTime];
            
            NSDate *date = [dateFormatter dateFromString:currentTime];
            components.second = [self intervalWithRunTime:runtime];
            date = [calendar dateByAddingComponents:components toDate:date options:kNilOptions];
            currentTime = [dateFormatter stringFromDate:date];
        }];
    }];
    
    self.stopTimes = stopTimes;
    
//    NSLog(@"Stop Times: %@", self.stopTimes);
}

- (ONOXMLElement *)journeyPatternElementForIdentifier:(NSString *)identifier
{
    ONOXMLElement *standardServiceElement = [[[self.document.rootElement firstChildWithTag:@"Services"] firstChildWithTag:@"Service"] firstChildWithTag:@"StandardService"];
    NSArray *journeyPatternElements = [standardServiceElement childrenWithTag:@"JourneyPattern"];
    
    __block ONOXMLElement *selectedVehicleJourney = nil;
    
    [journeyPatternElements enumerateObjectsUsingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL *stop) {
        
        if ([identifier isEqualToString:element.attributes[@"id"]]) {
            selectedVehicleJourney = element;
            *stop = YES;
        }
    }];
    
    return selectedVehicleJourney;
}

- (ONOXMLElement *)journeyPatternSectionElementForIdentifier:(NSString *)identifier
{
    NSArray *journeyPatternSectionElements = [[self.document.rootElement firstChildWithTag:@"JourneyPatternSections"] childrenWithTag:@"JourneyPatternSection"];
    __block ONOXMLElement *selectedJourneyPatternSection = nil;
    
    [journeyPatternSectionElements enumerateObjectsUsingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL *stop) {
        
        if ([identifier isEqualToString:element.attributes[@"id"]]) {
            selectedJourneyPatternSection = element;
            *stop = YES;
        }
    }];
    
    return selectedJourneyPatternSection;
}


- (NSTimeInterval)intervalWithRunTime:(NSString *)runTime
{
    NSArray *components = [[runTime stringByReplacingOccurrencesOfString:@"PT" withString:@""] componentsSeparatedByString:@"M"];
    
    if (components.count == 2) {
        
        NSInteger minute = [components[0] integerValue];
        NSInteger second = [[components[1] stringByReplacingOccurrencesOfString:@"S" withString:@""] integerValue];
        
        return (minute * 60) + second;
    }
    
    if (components.count == 1) {
        
        NSInteger second = [[components[0] stringByReplacingOccurrencesOfString:@"S" withString:@""] integerValue];
        
        return second;
    }
    
    return 0;
}

@end
