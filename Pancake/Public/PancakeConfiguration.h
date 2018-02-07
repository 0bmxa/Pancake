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
    AudioStreamBasicDescription *__nullable supportedFormats;
};
typedef struct PancakeDeviceConfiguration PancakeDeviceConfiguration;

struct PancakeConfiguration {
    void (*__nullable signalProcessorSetup)(void);
    uint numberOfDevices;
    PancakeDeviceConfiguration *__nullable devices;
};
typedef struct PancakeConfiguration PancakeConfiguration;




/**
 Creates a PancakeConfiguration structure for initial configuration of the
 Pancake driver and returns a pointer to it.
 References to this struct should be released via ReleasePancakeConfig().

 @param signalProcessorSetup A pointer to a callback function which is called
 when it's time to set up the signal processor, e.g. when the driver is being
 set up.
 @return A pointer to the newly created PancakeConfiguration struct, or NULL if
 an error occured.
 */
PancakeConfiguration *__nullable
    CreatePancakeConfig(void (*__nullable signalProcessorSetup)(void));

/**
 Adds a PancakeDeviceConfiguration to the list of devices and increments the
 numberOfDevices of a PancakeConfiguration structure.

 @param config The PancakeConfiguration struct to which the device config should
 be added.
 @param device The device config to be added, represented by a pointer to a
 PancakeDeviceConfiguration strcut.
 @return Whether the operation was successful or not.
 */
bool PancakeConfigAddDevice(PancakeConfiguration *__nonnull config,
                            PancakeDeviceConfiguration *__nonnull device);

/**
 Releases a PancakeConfiguration structure, which previously has been created
 via CreatePancakeConfig().

 @param config A pointer to the PancakeConfiguration struct pointer, which
 should be released.
 */
void ReleasePancakeConfig(PancakeConfiguration *__nonnull *__nullable config);




/**
 Creates a PancakeDeviceConfiguration structure for configuration of a single
 virtual device created by the Pancake driver and returns a pointer to it.
 References to this struct should be released via ReleasePancakeDeviceConfig().

 @param manufacturer The manufacturer of the device, or NULL.
 @param name The name of the device.
 @param UID A unique ID for the device to be identified by the system. This has
 to be consistent across boots.
 @return A pointer to the newly created PancakeDeviceConfiguration struct, or
 NULL if an error occured.
 */
PancakeDeviceConfiguration *__nullable
    CreatePancakeDeviceConfig(CFStringRef __nullable manufacturer,
                              CFStringRef __nonnull name,
                              CFStringRef __nonnull UID);

/**
 Adds a format to the list of supported formats and increments the
 numberOfFormats of a PancakeDeviceConfiguration structure.

 @param deviceConfig The device configuration to which the format should be
 added.
 @param format The format to be added, represented in the form of an
 AudioStreamBasicDescription struct.
 @return Whether the operation was successful or not.
 */
bool
PancakeDeviceConfigAddFormat(PancakeDeviceConfiguration *__nonnull deviceConfig,
                                 AudioStreamBasicDescription format);

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
