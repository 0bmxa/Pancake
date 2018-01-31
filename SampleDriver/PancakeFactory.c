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


// Forwards the call to the Swift implementation only.
void *Pancake_Create(CFAllocatorRef allocator, CFUUIDRef requestedTypeUUID) {
    
    // We can only create AudioServer plugins
    if(!CFEqual(requestedTypeUUID, kAudioServerPlugInTypeUUID)) {
        return NULL;
    }

    
    // Create our formats
    AudioStreamBasicDescription format1 = {0};
    AudioStreamBasicDescription format2 = {0};
    AudioStreamBasicDescription format3 = {0};
    format1.mSampleRate = 44100;
    format2.mSampleRate = 48000;
    format3.mSampleRate = 96000;

    // Create a device config
    uint numberOfFormats = 3;
    CFStringRef manufacturer = CFSTR("Pancake Manufaturer");
    CFStringRef name = CFSTR("Pancake Demo Driver");
    CFStringRef UID = CFSTR("PANCAKE_01");
    PancakeDeviceConfiguration *deviceConfig = CreatePancakeDeviceConfig(manufacturer, name, UID, numberOfFormats, &format1, &format2, &format3);
    if (deviceConfig == NULL) { return NULL; }
    
    // Create a pancake config
    PancakeConfiguration *config = CreatePancakeConfig(1, deviceConfig);
    if (config == NULL) { return NULL; }

    // Hand this config to Pancake
    PancakeSetupSharedInstance(config);

    // Release stuff
    ReleasePancakeDeviceConfig(&deviceConfig);
    ReleasePancakeConfig(&config);
    
    return PancakeDriverReference;
}
