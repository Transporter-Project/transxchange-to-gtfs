//
//  PCTransXChangeParseOperation.m
//  TransXChangeToGTFS
//
//  Created by Phillip Caudell on 14/09/2014.
//  Copyright (c) 2014 Phillip Caudell. All rights reserved.
//

#import "PCTransXChangeParseOperation.h"
#import "PCTransXChangeKit.h"
#import "PCCSVBuilder.h"

@implementation PCTransXChangeParseOperation

- (instancetype)initWithTransXChangeDocument:(PCTransXChangeDocument *)document
{
    if (self = [super init]) {
        
        _document = document;
    }
    
    return self;
}

+ (instancetype)operationWithTransXChangeDocument:(PCTransXChangeDocument *)document
{
    PCTransXChangeParseOperation *operation = [[PCTransXChangeParseOperation alloc] initWithTransXChangeDocument:document];
    
    return operation;
}

- (void)start
{
    self.agencies = [[PCGTFSAgencies alloc] initWithTransXChangeDocument:self.document];
    self.stops = [[PCGTFSStops alloc] initWithTransXChangeDocument:self.document];
    self.routes = [[PCGTFSRoutes alloc] initWithTransXChangeDocument:self.document];
    self.trips = [[PCGTFSTrips alloc] initWithTransXChangeDocument:self.document];
    self.stopTimes = [[PCGTFSStopTimes alloc] initWithTransXChangeDocument:self.document];
    self.calendar = [[PCGTFSCalendar alloc] initWithTransXChangeDocument:self.document];
    
    NSString *uuid = [[NSUUID UUID] UUIDString];
    NSString *outputDirectory = [self.outputDirectory stringByAppendingPathComponent:uuid];
    
    [[NSFileManager defaultManager] createDirectoryAtPath:outputDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    
    PCCSVBuilder *agencyBuilder = [PCCSVBuilder new];
    agencyBuilder.keys = @[PCGTFSAgencyIdentifier, PCGTFSAgencyName, PCGTFSAgencyTimeZone];
    [agencyBuilder.entries addObjectsFromArray:self.agencies.agencies];
    [agencyBuilder writeToFile:[outputDirectory stringByAppendingPathComponent:@"agency.csv"]];
    
    PCCSVBuilder *routeBuilder = [PCCSVBuilder new];
    routeBuilder.keys = @[PCGTFSRouteAgencyIdentifierKey, PCGTFSRouteIdentifierKey, PCGTFSRouteLongNameKey, PCGTFSRouteShortNameKey, PCGTFSRouteTypeKey];
    [routeBuilder.entries addObjectsFromArray:self.routes.routes];
    [routeBuilder writeToFile:[outputDirectory stringByAppendingPathComponent:@"routes.csv"]];

    PCCSVBuilder *tripBuilder = [PCCSVBuilder new];
    tripBuilder.keys = @[PCGTFSDirectionIdentifierKey, PCGTFSRouteIdentifierKey, PCGTFSServiceIdentifierKey, PCGTFSTripHeadSignKey, PCGTFSTripIdentifierKey];
    [tripBuilder.entries addObjectsFromArray:self.trips.trips];
    [tripBuilder writeToFile:[outputDirectory stringByAppendingPathComponent:@"trips.csv"]];
    
    PCCSVBuilder *stopTimeBuilder = [PCCSVBuilder new];
    stopTimeBuilder.keys = @[PCGTFSStopTimesArrivalTimeKey, PCGTFSStopTimesDepartureTimeKey, PCGTFSStopIdentifier, PCGTFSStopTimesSequenceKey, PCGTFSTripIdentifierKey];
    [stopTimeBuilder.entries addObjectsFromArray:self.stopTimes.stopTimes];
    [stopTimeBuilder writeToFile:[outputDirectory stringByAppendingPathComponent:@"stop_times.csv"]];
    
    PCCSVBuilder *calendarBuilder = [PCCSVBuilder new];
    calendarBuilder.keys = @[PCGTFSCalendarEndDateKey, PCGTFSCalendarFridayKey, PCGTFSCalendarMondayKey, PCGTFSCalendarSaturdayKey, PCGTFSServiceIdentifierKey, PCGTFSCalendarStartDateKey, PCGTFSCalendarSundayKey, PCGTFSCalendarThursdayKey, PCGTFSCalendarTuesdayKey, PCGTFSCalendarWednesdayKey];
    [calendarBuilder.entries addObjectsFromArray:self.calendar.calendars];
    [calendarBuilder writeToFile:[outputDirectory stringByAppendingPathComponent:@"calendar.csv"]];
}

@end
