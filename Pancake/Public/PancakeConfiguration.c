//
//  PancakeConfiguration.c
//  Pancake
//
//  Created by mxa on 31.01.2018.
//  Copyright © 2018 0bmxa. All rights reserved.
//

#include "PancakeConfiguration.h"

#pragma mark - Driver configuration

// =============================================================================
PancakeConfiguration *CreatePancakeConfig(uint numberOfDevices, ...)
{
    size_t configSize = sizeof(uint) + numberOfDevices * sizeof(PancakeDeviceConfiguration *);
    PancakeConfiguration *config = malloc(configSize);
    config->numberOfDevices = numberOfDevices;
    
    va_list deviceList;
    va_start(deviceList, numberOfDevices);
    
    PancakeDeviceConfiguration **currentDevice = &(config->devices);
    for (int i=0; i<numberOfDevices; i++)
    {
        PancakeDeviceConfiguration *device = va_arg(deviceList, PancakeDeviceConfiguration*);
        *currentDevice = device;
        currentDevice++;
    }
    
    va_end(deviceList);
    
    return config;
}

void ReleasePancakeConfig(PancakeConfiguration **config)
{
    if(*config == NULL) { return; }

    free(*config);
    *config = NULL;
}



#pragma mark - Device configuration

PancakeDeviceConfiguration *CreatePancakeDeviceConfig(CFStringRef __nullable manufacturer, CFStringRef name, CFStringRef UID, uint numberOfFormats, ...)
{
    size_t deviceConfigSize = sizeof(PancakeDeviceConfiguration) + (numberOfFormats-1) * sizeof(AudioStreamBasicDescription *);
    PancakeDeviceConfiguration *deviceConfig = malloc(deviceConfigSize);
    if (deviceConfig == NULL) { return NULL; }
    deviceConfig->manufacturer = manufacturer;
    deviceConfig->name = name;
    deviceConfig->UID = UID;
    deviceConfig->numberOfSupportedFormats = numberOfFormats;
    
    size_t sizeOfAllFormats = numberOfFormats * sizeof(AudioStreamBasicDescription);
    deviceConfig->supportedFormats = malloc(sizeOfAllFormats);
    if (deviceConfig->supportedFormats == NULL) { return NULL; }
    
    va_list formatList;
    va_start(formatList, numberOfFormats);
    for (int i=0; i<numberOfFormats; i++)
    {
        AudioStreamBasicDescription format = va_arg(formatList, AudioStreamBasicDescription);
        deviceConfig->supportedFormats[i] = format;
    }
    
    return deviceConfig;
}

void ReleasePancakeDeviceConfig(PancakeDeviceConfiguration **deviceConfig)
{
    if(*deviceConfig == NULL) { return; }
    
    /*
    if((*deviceConfig)->supportedFormats != NULL) {
        free((*deviceConfig)->supportedFormats);
        (*deviceConfig)->supportedFormats = NULL;
    }
    */
    
    free(*deviceConfig);
    *deviceConfig = NULL;
}




#pragma mark - ASBD Helpers

AudioStreamBasicDescription CreateHardwareASBD(Float64 sampleRate,
                                               UInt32 channelCount,
                                               AudioFormatFlags formatFlags,
                                               size_t formatSize)
{
    AudioStreamBasicDescription asbd = {0};
    asbd.mSampleRate       = sampleRate;
    asbd.mFormatID         = kAudioFormatLinearPCM;
    asbd.mFormatFlags      = formatFlags;
    asbd.mFramesPerPacket  = 1;
    asbd.mBytesPerFrame    = (UInt32)formatSize * channelCount;
    asbd.mChannelsPerFrame = channelCount;
    asbd.mBitsPerChannel   = (UInt32)formatSize * 8;
    asbd.mBytesPerPacket   = asbd.mBytesPerFrame * asbd.mFramesPerPacket;
    asbd.mReserved         = 0;
    return asbd;
}

AudioStreamBasicDescription CreateFloat32HardwareASBD(Float64 sampleRate,
                                                      UInt32 channelCount)
{
    AudioFormatFlags flags = kAudioFormatFlagsNativeEndian |
                             kAudioFormatFlagIsPacked |
                             kAudioFormatFlagIsFloat;
    size_t formatSize = sizeof(Float32);
    return CreateHardwareASBD(sampleRate, channelCount, flags, formatSize);
}
