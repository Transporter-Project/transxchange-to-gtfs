//
//  PCTransXChangeDocument.h
//  TransXChangeToGTFS
//
//  Created by Phillip Caudell on 14/09/2014.
//  Copyright (c) 2014 Phillip Caudell. All rights reserved.
//

#import "ONOXMLDocument.h"

@interface PCTransXChangeDocument : ONOXMLDocument

+ (instancetype)documentWithPath:(NSString *)path;

@end
