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
        
        NSMutableDictionary *calendar = [NSMutableDictionary new];
        calendar[PCGTFSServiceIdentifierKey] = [[vehicleJourneyElement firstChildWithTag:@"VehicleJourneyCode"] stringValue];
        calendar[PCGTFSCalendarMondayKey] = @(0);
        calendar[PCGTFSCalendarTuesdayKey] = @(0);
        calendar[PCGTFSCalendarWednesdayKey] = @(0);
        calendar[PCGTFSCalendarThursdayKey] = @(0);
        calendar[PCGTFSCalendarFridayKey] = @(0);
        calendar[PCGTFSCalendarSaturdayKey] = @(0);
        calendar[PCGTFSCalendarSundayKey] = @(0);
        
        ONOXMLElement *daysOfWeekElement = [[[vehicleJourneyElement firstChildWithTag:@"OperatingProfile"] firstChildWithTag:@"RegularDayType"] firstChildWithTag:@"DaysOfWeek"];

        __block BOOL hasAtLeastOneDay = false;
        
        [daysOfWeekElement.children enumerateObjectsUsingBlock:^(ONOXMLElement *dayOfWeekElement, NSUInteger idx, BOOL *stop) {
            
            NSString *dayOfWeek = [dayOfWeekElement tag];
                            
            if ([dayOfWeek isEqualToString:@"MondayToFriday"]) {
                
                calendar[PCGTFSCalendarMondayKey] = @(1);
                calendar[PCGTFSCalendarTuesdayKey] = @(1);
                calendar[PCGTFSCalendarWednesdayKey] = @(1);
                calendar[PCGTFSCalendarThursdayKey] = @(1);
                calendar[PCGTFSCalendarFridayKey] = @(1);
                hasAtLeastOneDay = true;
            }
            
            if ([dayOfWeek isEqualToString:@"Monday"]) {
                calendar[PCGTFSCalendarMondayKey] = @(1);
                hasAtLeastOneDay = true;
            }
            
            if ([dayOfWeek isEqualToString:@"Tuesday"]) {
                calendar[PCGTFSCalendarTuesdayKey] = @(1);
                hasAtLeastOneDay = true;
            }
            
            if ([dayOfWeek isEqualToString:@"Wednesday"]) {
                calendar[PCGTFSCalendarWednesdayKey] = @(1);
                hasAtLeastOneDay = true;
            }
            
            if ([dayOfWeek isEqualToString:@"Thursday"]) {
                calendar[PCGTFSCalendarThursdayKey] = @(1);
                hasAtLeastOneDay = true;
            }
            
            if ([dayOfWeek isEqualToString:@"Friday"]) {
                calendar[PCGTFSCalendarFridayKey] = @(1);
                hasAtLeastOneDay = true;
            }
            
            if ([dayOfWeek isEqualToString:@"Saturday"]) {
                calendar[PCGTFSCalendarSaturdayKey] = @(1);
                hasAtLeastOneDay = true;
            }
            
            if ([dayOfWeek isEqualToString:@"Sunday"]) {
                calendar[PCGTFSCalendarSundayKey] = @(1);
                hasAtLeastOneDay = true;
            }
        }];
        
        ONOXMLElement *serviceElement = [self serviceElementForServiceCode:lineRef];
        ONOXMLElement *operatingPeriodElement = [serviceElement firstChildWithTag:@"OperatingPeriod"];
        
        NSString *startDateString = [[operatingPeriodElement firstChildWithTag:@"StartDate"] stringValue];
        NSString *endDateString = [[operatingPeriodElement firstChildWithTag:@"EndDate"] stringValue];
        
        calendar[PCGTFSCalendarStartDateKey] = [startDateString stringByReplacingOccurrencesOfString:@"-" withString:@""];
        calendar[PCGTFSCalendarEndDateKey] = [endDateString stringByReplacingOccurrencesOfString:@"-" withString:@""];
        
        [currentServiceIdentifiers addObject:lineRef];
    
        if (hasAtLeastOneDay) {
            [calendars addObject:calendar];
        }
    }];
    
    self.calendars = calendars;
            
//    NSLog(@"Calendars: %@", self.calendars);
}

- (ONOXMLElement *)serviceElementForServiceCode:(NSString *)serviceCode
{
    __block ONOXMLElement *selectedElement = nil;
    
    [[[self.document.rootElement firstChildWithTag:@"Services"] childrenWithTag:@"Service"] enumerateObjectsUsingBlock:^(ONOXMLElement *serviceElement, NSUInteger idx, BOOL *stop) {
        
        if ([[[serviceElement firstChildWithTag:@"ServiceCode"] stringValue] isEqualToString:serviceCode]) {
            selectedElement = serviceElement;
        }
    }];
    
    return selectedElement;
}

@end
