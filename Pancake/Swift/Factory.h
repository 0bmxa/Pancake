//
//  Factory.h
//  Pancake
//
//  Created by mxa on 16.07.2017.
//  Copyright © 2017 mxa. All rights reserved.
//

#include <CoreAudio/AudioServerPlugIn.h>

static AudioServerPlugInDriverRef audioServerPlugInDriverRef;

void* Pancake_Create(CFAllocatorRef, CFUUIDRef);
