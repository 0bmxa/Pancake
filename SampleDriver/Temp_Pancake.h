//
//  Temp_Pancake.h
//  SampleDriver
//
//  Created by mxa on 15.12.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

#include <CoreAudio/CoreAudioTypes.h>
#include <CoreFoundation/CoreFoundation.h>

struct PancakeDeviceConfiguration {
    CFStringRef manufacturer;
    CFStringRef name;
    CFStringRef UID;
    int numberOfSupportedFormats;
    AudioStreamBasicDescription supportedFormats[];
};
typedef struct PancakeDeviceConfiguration PancakeDeviceConfiguration;

struct PancakeConfiguration {
    int numberOfDevices;
    PancakeDeviceConfiguration devices[];
};
typedef struct PancakeConfiguration PancakeConfiguration;


void PancakeSetupSharedInstance(PancakeConfiguration config);

void *PancakeDriverReference;
