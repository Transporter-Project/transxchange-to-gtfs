//
//  PCAppDelegate.h
//  TransXChangeToGTFS
//
//  Created by Phillip Caudell on 14/09/2014.
//  Copyright (c) 2014 Phillip Caudell. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PCTransXChangeKit.h"

@interface PCAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, strong) PCTransXChangeParseQueue *queue;

@end
