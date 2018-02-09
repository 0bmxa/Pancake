//
//  PancakeFactory.c
//  SampleDriver
//
//  Created by mxa on 14.12.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

#include "PancakeFactory.h"
#include <CoreFoundation/CoreFoundation.h>
#include <CoreAudio/AudioServerPlugIn.h>

#include "Pancake.h"

void setupCallback() {
    printf("setup 🎉\n");
}

#define assureNonNULL(c) if(c == NULL)  {return NULL;}
#define assureTrue(c)    if(c == false) {return NULL;}

// Forwards the call to the Swift implementation only.
void *Pancake_Create(CFAllocatorRef allocator, CFUUIDRef requestedTypeUUID) {
    
    // We can only create AudioServer plugins
    if(!CFEqual(requestedTypeUUID, kAudioServerPlugInTypeUUID)) {
        return NULL;
    }
    
    // Create a device config
    CFStringRef manufacturer = CFSTR("Pancake Manufaturer");
    CFStringRef name = CFSTR("Pancake Demo Driver");
    CFStringRef UID = CFSTR("PANCAKE_01");
    PancakeDeviceConfiguration *deviceConfig = CreatePancakeDeviceConfig(manufacturer, name, UID);
    assureNonNULL(deviceConfig);
    
    // Create & add our formats
    AudioStreamBasicDescription format44 = CreateFloat32HardwareASBD(44100, 2);
    AudioStreamBasicDescription format48 = CreateFloat32HardwareASBD(48000, 2);
    AudioStreamBasicDescription format96 = CreateFloat32HardwareASBD(96000, 2);
    assureTrue(PancakeDeviceConfigAddFormat(deviceConfig, format44));
    assureTrue(PancakeDeviceConfigAddFormat(deviceConfig, format48));
    assureTrue(PancakeDeviceConfigAddFormat(deviceConfig, format96));

    // Create a pancake config
    PancakeConfiguration *config = CreatePancakeConfig(setupCallback);
    assureNonNULL(config);
    assureTrue(PancakeConfigAddDevice(config, deviceConfig));

    // Hand this config to Pancake
    PancakeSetupSharedInstance(config);

    // Release stuff
//    ReleasePancakeDeviceConfig(&deviceConfig);
//    ReleasePancakeConfig(&config);
    
    return PancakeDriverReference;
}

