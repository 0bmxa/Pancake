//
//  PancakeConfiguration.h
//  Pancake
//
//  Created by mxa on 31.01.2018.
//  Copyright © 2018 0bmxa. All rights reserved.
//

#ifndef PANCAKE_PANCAKECONFIGURATION_H_
#define PANCAKE_PANCAKECONFIGURATION_H_

#include <CoreAudio/CoreAudioTypes.h>
#include <CoreFoundation/CoreFoundation.h>

struct PancakeDeviceConfiguration {
    CFStringRef __nullable manufacturer;
    CFStringRef __nonnull name;
    CFStringRef __nonnull UID;
    uint numberOfSupportedFormats;
    AudioStreamBasicDescription *__nonnull supportedFormats;
};
typedef struct PancakeDeviceConfiguration PancakeDeviceConfiguration;

struct PancakeConfiguration {
    // TODO: add setup function
    uint numberOfDevices;
    PancakeDeviceConfiguration *__nonnull devices;
};
typedef struct PancakeConfiguration PancakeConfiguration;




/**
 Creates a PancakeConfiguration structure for initial configuration of the
 Pancake driver and returns a pointer to it.
 References to this struct should be released via ReleasePancakeConfig().

 @param numberOfDevices The number of devices the driver should be set up with.
 @param devices A sequence of (pre-configured) PancakeDeviceConfiguration
 pointers, which describe the devices the driver should be set up with.
 The number of device configurations has to be greater or equal than the value
 in `numberOfDevices`. Additional device configs are ignored by the function.
 @return A pointer to the newly created PancakeConfiguration struct, or NULL if
 an error occured.
 */
PancakeConfiguration *__nullable CreatePancakeConfig(uint numberOfDevices, ...);

/**
 Releases a PancakeConfiguration structure, which previously has been created
 via CreatePancakeConfig().

 @param config A pointer to the PancakeConfiguration struct pointer, which
 should be released.
 */
void ReleasePancakeConfig(PancakeConfiguration *__nonnull *__nullable config);

// Device config
/**
 Creates a PancakeDeviceConfiguration structure for configuration of a single
 virtual device created by the Pancake driver and returns a pointer to it.
 References to this struct should be released via ReleasePancakeDeviceConfig().

 @param manufacturer The manufacturer of the device.
 @param name The name of the device.
 @param UID A unique ID for the device to be identified by the system. This has
 to be consistent across boots.
 @param numberOfFormats The number of formats the device should support.
 @param supportedFormats A sequence of (pre-configured)
 AudioStreamBasicDescription structs, which describe the formats the device
 should support.
 The number of formats has to be greater or equal than the value in
 `numberOfFormats`. Additional formats are ignored by the function.
 @return A pointer to the newly created PancakeDeviceConfiguration struct, or
 NULL if an error occured.
 */
PancakeDeviceConfiguration *__nullable
CreatePancakeDeviceConfig(CFStringRef __nullable manufacturer,
                          CFStringRef __nonnull name,
                          CFStringRef __nonnull UID,
                          uint numberOfFormats,
                          ...);

/**
 Releases a PancakeDeviceConfiguration structure, which previously has been
 created via CreatePancakeDeviceConfig().
 
 @param deviceConfig A pointer to the PancakeDeviceConfiguration struct pointer,
 which should be released.
 */
void ReleasePancakeDeviceConfig(PancakeDeviceConfiguration
                                *__nonnull *__nullable deviceConfig);




/**
 Creates a new AudioStreamBasicDescription, suitable for hardware use.
 Note that only a limited set of formats are valid for hardware use.
 
 @param sampleRate The sample rate to specifiy.
 @param channelCount The channel count to use.
 @param formatFlags The flags describing the sample format to be used.
 @param formatSize The byte size of a single audio sample (of the sample format).
 @return The newly created AudioStreamBasicDescription.
 */
AudioStreamBasicDescription CreateHardwareASBD(Float64 sampleRate,
                                               UInt32 channelCount,
                                               AudioFormatFlags formatFlags,
                                               size_t formatSize);

/**
 Creates a new AudioStreamBasicDescription with LPCM, 32bit floating point format, suitable for hardware use.
 
 @param sampleRate The sample rate to specifiy.
 @param channelCount The channel count to use.
 @return The newly created AudioStreamBasicDescription.
 */
AudioStreamBasicDescription CreateFloat32HardwareASBD(Float64 sampleRate,
                                                      UInt32 channelCount);


#endif  // PANCAKE_PANCAKECONFIGURATION_H_
