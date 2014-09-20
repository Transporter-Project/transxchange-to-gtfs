//
//  PCGTFSObject.m
//  TransXChangeToGTFS
//
//  Created by Phillip Caudell on 14/09/2014.
//  Copyright (c) 2014 Phillip Caudell. All rights reserved.
//

#import "PCGTFSObject.h"

@implementation PCGTFSObject

- (instancetype)initWithTransXChangeDocument:(PCTransXChangeDocument *)document
{
    if (self = [super init]) {
        
        _document = document;
        
        [self parse];
    }
    
    return self;
}

- (void)parse
{
    
}

@end
