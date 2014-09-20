//
//  PCTransXChangeDefines.h
//  TransXChangeToGTFS
//
//  Created by Phillip Caudell on 14/09/2014.
//  Copyright (c) 2014 Phillip Caudell. All rights reserved.
//

typedef NS_ENUM(NSInteger, PCGTFSRouteType) {
    PCGTFSRouteTypeLightRail = 0,
    PCGTFSRouteTypeMetro = 1,
    PCGTFSRouteTypeRail = 2,
    PCGTFSRouteTypeBus = 3,
    PCGTFSRouteTypeFerry = 4,
    PCGTFSRouteTypeStreetCableCar = 5,
    PCGTFSRouteTypeSuspendedCableCar = 6,
    PCGTFSRouteTypeFunicular = 7
};

typedef NS_ENUM(NSInteger, PCGTFSTripDirection) {
    PCGTFSTripDirectionOutbound = 0,
    PCGTFSTripDirectionInbound = 1
};

// Agency
static NSString * const PCGTFSAgencyIdentifier = @"agency_id";
static NSString * const PCGTFSAgencyName = @"agency_name";
static NSString * const PCGTFSAgencyURL = @"agency_url";
static NSString * const PCGTFSAgencyTimeZone = @"agency_timezone";

// Stops
static NSString * const PCGTFSStopIdentifier = @"stop_id";
static NSString * const PCGTFSStopCode = @"stop_code";
static NSString * const PCGTFSStopName = @"stop_name";
static NSString * const PCGTFSStopDescription = @"stop_desc";
static NSString * const PCGTFSStopLatitude = @"stop_lat";
static NSString * const PCGTFSStopLongitude = @"stop_lon";

// Routes
static NSString * const PCGTFSRouteIdentifierKey = @"route_id";
static NSString * const PCGTFSRouteAgencyIdentifierKey = @"agency_id";
static NSString * const PCGTFSRouteShortNameKey = @"route_short_name";
static NSString * const PCGTFSRouteLongNameKey = @"route_long_name";
static NSString * const PCGTFSRouteTypeKey = @"route_type";

// Trips
static NSString * const PCGTFSServiceIdentifierKey = @"service_id";
static NSString * const PCGTFSDirectionIdentifierKey = @"direction_id";
static NSString * const PCGTFSTripHeadSignKey = @"trip_headsign";
static NSString * const PCGTFSTripIdentifierKey = @"trip_id";

// Stop times
static NSString * const PCGTFSStopTimesArrivalTimeKey = @"arrival_time";
static NSString * const PCGTFSStopTimesDepartureTimeKey = @"departure_time";
static NSString * const PCGTFSStopTimesSequenceKey = @"stop_sequence";