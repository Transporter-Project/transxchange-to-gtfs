//
//  PCGTFSCalendar.m
//  TransXChangeToGTFS
//
//  Created by Phillip Caudell on 20/09/2014.
//  Copyright (c) 2014 Phillip Caudell. All rights reserved.
//

#import "PCGTFSCalendar.h"
#import "PCTransXChangeKit.h"

@implementation PCGTFSCalendar

- (void)parse
{
    NSMutableArray *calendars = [NSMutableArray array];
    ONOXMLElement *vehicleJourneys = [self.document.rootElement firstChildWithTag:@"VehicleJourneys"];
    NSMutableArray *currentServiceIdentifiers = [NSMutableArray array];
    
    [vehicleJourneys.children enumerateObjectsUsingBlock:^(ONOXMLElement *vehicleJourneyElement, NSUInteger idx, BOOL *stop) {
        
        NSString *lineRef = [[vehicleJourneyElement firstChildWithTag:@"LineRef"] stringValue];
        
        if (![currentServiceIdentifiers containsObject:lineRef]) {
            
            NSMutableDictionary *calendar = [NSMutableDictionary new];
            calendar[PCGTFSServiceIdentifierKey] = lineRef;
            calendar[PCGTFSCalendarMondayKey] = @(0);
            calendar[PCGTFSCalendarTuesdayKey] = @(0);
            calendar[PCGTFSCalendarWednesdayKey] = @(0);
            calendar[PCGTFSCalendarThursdayKey] = @(0);
            calendar[PCGTFSCalendarFridayKey] = @(0);
            calendar[PCGTFSCalendarSaturdayKey] = @(0);
            calendar[PCGTFSCalendarSundayKey] = @(0);
            
            ONOXMLElement *daysOfWeekElement = [[[vehicleJourneyElement firstChildWithTag:@"OperatingProfile"] firstChildWithTag:@"RegularDayType"] firstChildWithTag:@"DaysOfWeek"];
 
            [daysOfWeekElement.children enumerateObjectsUsingBlock:^(ONOXMLElement *dayOfWeekElement, NSUInteger idx, BOOL *stop) {
                
                NSString *dayOfWeek = [dayOfWeekElement tag];
                                
                if ([dayOfWeek isEqualToString:@"MondayToFriday"]) {
                    
                    calendar[PCGTFSCalendarMondayKey] = @(1);
                    calendar[PCGTFSCalendarTuesdayKey] = @(1);
                    calendar[PCGTFSCalendarWednesdayKey] = @(1);
                    calendar[PCGTFSCalendarThursdayKey] = @(1);
                    calendar[PCGTFSCalendarFridayKey] = @(1);
                }
                
                if ([dayOfWeek isEqualToString:@"Monday"]) {
                    calendar[PCGTFSCalendarMondayKey] = @(1);
                }
                
                if ([dayOfWeek isEqualToString:@"Tuesday"]) {
                    calendar[PCGTFSCalendarTuesdayKey] = @(1);
                }
                
                if ([dayOfWeek isEqualToString:@"Wednesday"]) {
                    calendar[PCGTFSCalendarWednesdayKey] = @(1);
                }
                
                if ([dayOfWeek isEqualToString:@"Thursday"]) {
                    calendar[PCGTFSCalendarThursdayKey] = @(1);
                }
                
                if ([dayOfWeek isEqualToString:@"Friday"]) {
                    calendar[PCGTFSCalendarFridayKey] = @(1);
                }
                
                if ([dayOfWeek isEqualToString:@"Saturday"]) {
                    calendar[PCGTFSCalendarSaturdayKey] = @(1);
                }
                
                if ([dayOfWeek isEqualToString:@"Sunday"]) {
                    calendar[PCGTFSCalendarSundayKey] = @(1);
                }
            }];
            
            [currentServiceIdentifiers addObject:lineRef];
            [calendars addObject:calendar];
        }
    }];
    
    self.calendars = calendars;
            
    NSLog(@"Calendars: %@", self.calendars);
}

@end
