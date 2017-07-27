
//  EntryPoint.c
//  Pancake
//
//  Created by mxa on 20.07.2017.
//  Copyright © 2017 mxa. All rights reserved.
//

#include "EntryPoint.h"
#include "Pancake-Swift.h"

void* Pancake_Create(CFAllocatorRef inAllocator, CFUUIDRef inRequestedTypeUUID)
{
    if (!CFEqual(inRequestedTypeUUID, kAudioServerPlugInTypeUUID)) return NULL;

    AudioServerPlugInDriverInterface driverInterface = [PancakeFactory driverInterface];
    AudioServerPlugInDriverInterface *driverInterfacePointer = &driverInterface;
    AudioServerPlugInDriverRef driverReference = &driverInterfacePointer;

    return driverReference;
}
