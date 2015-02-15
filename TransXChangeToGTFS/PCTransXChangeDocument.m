//
//  PCTransXChangeDocument.m
//  TransXChangeToGTFS
//
//  Created by Phillip Caudell on 14/09/2014.
//  Copyright (c) 2014 Phillip Caudell. All rights reserved.
//

#import "PCTransXChangeDocument.h"

@implementation PCTransXChangeDocument

+ (instancetype)documentWithPath:(NSString *)path
{
    NSData *data = [NSData dataWithContentsOfFile:path];
    PCTransXChangeDocument *document = [PCTransXChangeDocument XMLDocumentWithData:data error:nil];
    document.path = path;
    
    return document;
}

@end
