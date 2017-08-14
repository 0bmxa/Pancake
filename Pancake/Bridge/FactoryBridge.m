//
//  FactoryBridge.m
//  Pancake
//
//  Created by mxa on 14.08.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

#import "FactoryBridge.h"
#import "Pancake-Swift.h"

// Forwards the call to the Swift implementation only.
void *Pancake_Create(CFAllocatorRef allocator, CFUUIDRef requestedTypeUUID) {
    return [PancakeFactory createWithAllocator:allocator requestedTypeUUID:requestedTypeUUID];
}

