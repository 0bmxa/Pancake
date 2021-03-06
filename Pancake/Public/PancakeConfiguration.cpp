//
//  PancakeConfiguration.c
//  Pancake
//
//  Created by mxa on 31.01.2018.
//  Copyright © 2018 0bmxa. All rights reserved.
//

#include "PancakeConfiguration.h"

#pragma mark - Driver configuration

PancakeConfiguration *__nullable CreatePancakeConfig(void (*__nullable setupCallback)(void)) {
    size_t configSize = sizeof(PancakeConfiguration);
    void *storage = malloc(configSize);
    PancakeConfiguration *config = reinterpret_cast<PancakeConfiguration *>(storage);
    if (config == NULL) { return NULL; }
    config->setupCallback = setupCallback;
    config->numberOfDevices = 0;
    config->devices = NULL;

    return config;
}

bool PancakeConfigAddDevice(PancakeConfiguration *config, PancakeDeviceConfiguration *device) {
    if (config == NULL) { return false; }

    uint numberOfDevices = config->numberOfDevices + 1;
    size_t devicePointerSize = sizeof(PancakeDeviceConfiguration *);

    // Alloc or grow storage for the new device pointer
    if (config->devices == NULL) {
        void *storage = malloc(devicePointerSize);
        config->devices = reinterpret_cast<PancakeDeviceConfiguration **>(storage);
    } else {
        size_t sizeOfAllDevicePointers = numberOfDevices * devicePointerSize;
        void *storage = realloc(config->devices, sizeOfAllDevicePointers);
        config->devices = reinterpret_cast<PancakeDeviceConfiguration **>(storage);
    }
    if (config->devices == NULL) { return false; }

    // Copy device pointer into new place
    config->devices[numberOfDevices-1] = device;

    config->numberOfDevices = numberOfDevices;
    return true;
}

void ReleasePancakeConfig(PancakeConfiguration **config) {
    if (*config == NULL) { return; }

    if ((*config)->devices != nullptr) {
        delete (*config)->devices;
        (*config)->devices = NULL;
    }

    delete *config;
    *config = NULL;
}



#pragma mark - Device configuration

PancakeDeviceConfiguration *__nullable CreatePancakeDeviceConfig(CFStringRef __nullable manufacturer, CFStringRef __nonnull name, CFStringRef __nonnull UID) {
    auto deviceConfig = new PancakeDeviceConfiguration;
    if (deviceConfig == NULL) { return NULL; }

    deviceConfig->manufacturer = manufacturer;
    deviceConfig->name = name;
    deviceConfig->UID = UID;
    deviceConfig->processingCallback = NULL;
    deviceConfig->startIO = NULL;
    deviceConfig->stopIO = NULL;
    deviceConfig->numberOfSupportedFormats = 0;
    deviceConfig->supportedFormats = NULL;

    return deviceConfig;
}

bool PancakeDeviceConfigAddFormat(PancakeDeviceConfiguration *__nonnull deviceConfig, AudioStreamBasicDescription format) {
    if (deviceConfig == NULL) { return false; }

    uint numberOfFormats = deviceConfig->numberOfSupportedFormats + 1;
    size_t ASBDsize = sizeof(AudioStreamBasicDescription);

    // Alloc or grow storage for the new ASBD
    if (deviceConfig->supportedFormats == NULL) {
        void *storage = malloc(ASBDsize);
        deviceConfig->supportedFormats = reinterpret_cast<AudioStreamBasicDescription *>(storage);
    } else {
        size_t sizeOfAllFormats = numberOfFormats * ASBDsize;
        void *storage = realloc(deviceConfig->supportedFormats, sizeOfAllFormats);
        deviceConfig->supportedFormats = reinterpret_cast<AudioStreamBasicDescription *>(storage);
    }
    if (deviceConfig->supportedFormats == NULL) { return false; }


    // Copy ASBD into new place
    deviceConfig->supportedFormats[numberOfFormats-1] = format;

    deviceConfig->numberOfSupportedFormats = numberOfFormats;
    return true;
}

void ReleasePancakeDeviceConfig(PancakeDeviceConfiguration **deviceConfig) {
    if (*deviceConfig == NULL) { return; }

    free(*deviceConfig);
    *deviceConfig = NULL;
}




#pragma mark - ASBD Helpers

AudioStreamBasicDescription CreateHardwareASBD(Float64 sampleRate, UInt32 channelCount, AudioFormatFlags formatFlags, size_t formatSize) {
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

AudioStreamBasicDescription CreateFloat32HardwareASBD(Float64 sampleRate, UInt32 channelCount) {
    AudioFormatFlags flags = kAudioFormatFlagsNativeEndian |
                             kAudioFormatFlagIsPacked |
                             kAudioFormatFlagIsFloat;
    size_t formatSize = sizeof(Float32);
    return CreateHardwareASBD(sampleRate, channelCount, flags, formatSize);
}

