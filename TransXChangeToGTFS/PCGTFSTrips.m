//
//  PCGTFSTrips.m
//  TransXChangeToGTFS
//
//  Created by Phillip Caudell on 14/09/2014.
//  Copyright (c) 2014 Phillip Caudell. All rights reserved.
//

#import "PCGTFSTrips.h"
#import "PCTransXChangeKit.h"

@implementation PCGTFSTrips

- (void)parse
{
    NSMutableArray *trips = [NSMutableArray array];
    
    ONOXMLElement *services = [self.document.rootElement firstChildWithTag:@"Services"];
    
    [services.children enumerateObjectsUsingBlock:^(ONOXMLElement *serviceElement, NSUInteger idx, BOOL *stop) {
        
        ONOXMLElement *standardServiceElement = [serviceElement firstChildWithTag:@"StandardService"];
        NSString *origin = [[standardServiceElement firstChildWithTag:@"Origin"] stringValue];
        NSString *destination = [[standardServiceElement firstChildWithTag:@"Destination"] stringValue];
        
        NSArray *vehicleJourneys = [[self.document.rootElement firstChildWithTag:@"VehicleJourneys"] childrenWithTag:@"VehicleJourney"];
        
        [vehicleJourneys enumerateObjectsUsingBlock:^(ONOXMLElement *vehicleJourneyElement, NSUInteger idx, BOOL *stop) {
            
            NSString *departureTime = [[vehicleJourneyElement firstChildWithTag:@"DepartureTime"] stringValue];
            NSString *vehicleJourneyCode = [[vehicleJourneyElement firstChildWithTag:@"VehicleJourneyCode"] stringValue];
            NSString *vehicleJourneyPatternRef = [[vehicleJourneyElement firstChildWithTag:@"JourneyPatternRef"] stringValue];
            ONOXMLElement *journeyPatternElement = [self journeyPatternElementForRef:vehicleJourneyPatternRef withService:standardServiceElement];
            
            NSMutableDictionary *trip = [NSMutableDictionary dictionary];
            
            // Make an identifier by combining journey code and departure time
            trip[PCGTFSTripIdentifierKey] = [NSString stringWithFormat:@"%@-%@", vehicleJourneyCode, departureTime];
            
            trip[PCGTFSRouteIdentifierKey] = [[serviceElement firstChildWithTag:@"ServiceCode"] stringValue];
            
            trip[PCGTFSServiceIdentifierKey] = [[vehicleJourneyElement firstChildWithTag:@"VehicleJourneyCode"] stringValue];

            PCGTFSTripDirection direction = [self directionForTransXChangeDirection:[[journeyPatternElement firstChildWithTag:@"Direction"] stringValue]];
            trip[PCGTFSDirectionIdentifierKey] = @(direction);
            
            switch (direction) {
                case PCGTFSTripDirectionOutbound:
                    trip[PCGTFSTripHeadSignKey] = origin;
                    break;
                case PCGTFSTripDirectionInbound:
                    trip[PCGTFSTripHeadSignKey] = destination;
                default:
                    break;
            }
            
            [trips addObject:trip];
        }];
    }];
    
    self.trips = trips;
    
//    NSLog(@"Trips: %@", trips);
}

- (ONOXMLElement *)journeyPatternElementForRef:(NSString *)ref withService:(ONOXMLElement *)standardServiceElement
{
    NSArray *journeyPatterns = [standardServiceElement childrenWithTag:@"JourneyPattern"];
    __block ONOXMLElement *element = nil;
    
    [journeyPatterns enumerateObjectsUsingBlock:^(ONOXMLElement *journeyPatternElement, NSUInteger idx, BOOL *stop) {
        
        if ([journeyPatternElement.attributes[@"id"] isEqualToString:ref]) {
            element = journeyPatternElement;
        }
    }];
    
    return element;
}

- (PCGTFSTripDirection)directionForTransXChangeDirection:(NSString *)direction
{
    if ([direction isEqualToString:@"inbound"]) {
        return PCGTFSTripDirectionInbound;
    } else {
        return PCGTFSTripDirectionOutbound;
    }
}

@end
