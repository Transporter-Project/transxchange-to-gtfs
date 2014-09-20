//
//  PCTransXChangeParseOperation.m
//  TransXChangeToGTFS
//
//  Created by Phillip Caudell on 14/09/2014.
//  Copyright (c) 2014 Phillip Caudell. All rights reserved.
//

#import "PCTransXChangeParseOperation.h"
#import "PCTransXChangeKit.h"

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
}

@end
