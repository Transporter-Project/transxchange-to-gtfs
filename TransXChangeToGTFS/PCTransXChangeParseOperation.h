//
//  PCTransXChangeParseOperation.h
//  TransXChangeToGTFS
//
//  Created by Phillip Caudell on 14/09/2014.
//  Copyright (c) 2014 Phillip Caudell. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PCTransXChangeDocument;
@class PCGTFSAgencies;
@class PCGTFSStops;
@class PCGTFSRoutes;
@class PCGTFSTrips;
@class PCGTFSStopTimes;

@interface PCTransXChangeParseOperation : NSOperation

@property (nonatomic, strong, readonly) PCTransXChangeDocument *document;
@property (nonatomic, strong) PCGTFSAgencies *agencies;
@property (nonatomic, strong) PCGTFSStops *stops;
@property (nonatomic, strong) PCGTFSRoutes *routes;
@property (nonatomic, strong) PCGTFSTrips *trips;
@property (nonatomic, strong) PCGTFSStopTimes *stopTimes;

+ (instancetype)operationWithTransXChangeDocument:(PCTransXChangeDocument *)document;
- (instancetype)initWithTransXChangeDocument:(PCTransXChangeDocument *)document;

@end
