//
//  FactoryBridge.h
//  Pancake
//
//  Created by mxa on 14.08.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

#import <CoreFoundation/CoreFoundation.h>

void *Pancake_Create(CFAllocatorRef allocator, CFUUIDRef requestedTypeUUID);
