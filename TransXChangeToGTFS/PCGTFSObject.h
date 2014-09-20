//
//  PCGTFSObject.h
//  TransXChangeToGTFS
//
//  Created by Phillip Caudell on 14/09/2014.
//  Copyright (c) 2014 Phillip Caudell. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PCTransXChangeDocument;

@interface PCGTFSObject : NSObject

@property (nonatomic, strong, readonly) PCTransXChangeDocument *document;

- (instancetype)initWithTransXChangeDocument:(PCTransXChangeDocument *)document;
- (void)parse;

@end
