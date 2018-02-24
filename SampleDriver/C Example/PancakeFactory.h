//
//  PancakeFactory.h
//  SampleDriver
//
//  Created by mxa on 14.12.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

#ifndef SAMPLEDRIVER_PANCAKEFACTORY_H_
#define SAMPLEDRIVER_PANCAKEFACTORY_H_

#include <CoreFoundation/CoreFoundation.h>

#ifdef __cplusplus
extern "C" {
#endif

void *Pancake_Create(CFAllocatorRef allocator, CFUUIDRef requestedTypeUUID);

#ifdef __cplusplus
}
#endif

#endif  // SAMPLEDRIVER_PANCAKEFACTORY_H_
