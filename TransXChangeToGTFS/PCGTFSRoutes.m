//
//  PCGTFSRoutes.m
//  TransXChangeToGTFS
//
//  Created by Phillip Caudell on 14/09/2014.
//  Copyright (c) 2014 Phillip Caudell. All rights reserved.
//

#import "PCGTFSRoutes.h"
#import "PCTransXChangeDocument.h"
#import "PCTransXChangeDefines.h"   

@implementation PCGTFSRoutes

- (void)parse
{
    NSMutableArray *routes = [NSMutableArray array];
    
    ONOXMLElement *services = [self.document.rootElement firstChildWithTag:@"Services"];

    [services.children enumerateObjectsUsingBlock:^(ONOXMLElement *serviceElement, NSUInteger idx, BOOL *stop) {
        
        NSArray *lines = [[serviceElement firstChildWithTag:@"Lines"] children];
        
        [lines enumerateObjectsUsingBlock:^(ONOXMLElement *lineElement, NSUInteger lineIndex, BOOL *lineStop) {
            
            NSMutableDictionary *route = [NSMutableDictionary dictionary];
            route[PCGTFSRouteIdentifierKey] = [[serviceElement firstChildWithTag:@"ServiceCode"] stringValue];
            route[PCGTFSRouteAgencyIdentifierKey] = [[serviceElement firstChildWithTag:@"RegisteredOperatorRef"] stringValue];
            route[PCGTFSRouteShortNameKey] = [[lineElement firstChildWithTag:@"LineName"] stringValue];
            route[PCGTFSRouteLongNameKey] = [[serviceElement firstChildWithTag:@"Description"] stringValue];
            
            NSString *mode = [[serviceElement firstChildWithTag:@"Mode"] stringValue];
            route[PCGTFSRouteTypeKey] = @([self routeTypeForTransXChangeMode:mode]);
            
            [routes addObject:route];
        }];
    }];
    
    self.routes = routes;
    
//    NSLog(@"Routes: %@", self.routes);
}

- (PCGTFSRouteType)routeTypeForTransXChangeMode:(NSString *)mode
{
    if ([mode isEqualToString:@"bus"]) {
        return PCGTFSRouteTypeBus;
    }
    
    return PCGTFSRouteTypeBus;
}

@end
