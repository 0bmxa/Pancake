//
//  DriverInterface.c
//  Pancake
//
//  Created by mxa on 17.07.2017.
//  Copyright © 2017 mxa. All rights reserved.
//

#include "DriverInterface.h"

#pragma mark Inheritance
HRESULT     Pancake_QueryInterface(void* __nullable inDriver, REFIID inUUID, LPVOID __nullable * __nullable outInterface) {
    abort();
    return (HRESULT)0;
}
ULONG       Pancake_AddRef(void* __nullable inDriver) {
    abort();
    return (ULONG)0;
}
ULONG       Pancake_Release(void* __nullable inDriver) {
    abort();
    return (ULONG)0;
}


#pragma mark Basic Operations
OSStatus    Pancake_Initialize(AudioServerPlugInDriverRef __nonnull inDriver, AudioServerPlugInHostRef inHost) {
    abort();
    return (OSStatus)0;
}
OSStatus    Pancake_CreateDevice(AudioServerPlugInDriverRef __nonnull inDriver, CFDictionaryRef inDescription, const AudioServerPlugInClientInfo* inClientInfo, AudioObjectID* outDeviceObjectID) {
    abort();
    return (OSStatus)0;
}
OSStatus    Pancake_DestroyDevice(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inDeviceObjectID) {
    abort();
    return (OSStatus)0;
}
OSStatus    Pancake_AddDeviceClient(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inDeviceObjectID, const AudioServerPlugInClientInfo* inClientInfo) {
    abort();
    return (OSStatus)0;
}
OSStatus    Pancake_RemoveDeviceClient(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inDeviceObjectID, const AudioServerPlugInClientInfo* inClientInfo) {
    abort();
    return (OSStatus)0;
}
OSStatus    Pancake_PerformDeviceConfigurationChange(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inDeviceObjectID, UInt64 inChangeAction, void* __nullable inChangeInfo) {
    abort();
    return (OSStatus)0;
}
OSStatus    Pancake_AbortDeviceConfigurationChange(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inDeviceObjectID, UInt64 inChangeAction, void* __nullable inChangeInfo) {
    abort();
    return (OSStatus)0;
}


#pragma mark Property Operations
Boolean     Pancake_HasProperty(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inObjectID, pid_t inClientProcessID, const AudioObjectPropertyAddress* inAddress) {
    abort();
    return (Boolean)0;
}
OSStatus    Pancake_IsPropertySettable(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inObjectID, pid_t inClientProcessID, const AudioObjectPropertyAddress* inAddress, Boolean* outIsSettable) {
    abort();
    return (OSStatus)0;
}
OSStatus    Pancake_GetPropertyDataSize(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inObjectID, pid_t inClientProcessID, const AudioObjectPropertyAddress* inAddress, UInt32 inQualifierDataSize, const void* __nullable inQualifierData, UInt32* outDataSize) {
    abort();
    return (OSStatus)0;
}
OSStatus    Pancake_GetPropertyData(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inObjectID, pid_t inClientProcessID, const AudioObjectPropertyAddress* inAddress, UInt32 inQualifierDataSize, const void* __nullable inQualifierData, UInt32 inDataSize, UInt32* outDataSize, void* outData) {
    abort();
    return (OSStatus)0;
}
OSStatus    Pancake_SetPropertyData(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inObjectID, pid_t inClientProcessID, const AudioObjectPropertyAddress* inAddress, UInt32 inQualifierDataSize, const void* __nullable inQualifierData, UInt32 inDataSize, const void* inData) {
    abort();
    return (OSStatus)0;
}


#pragma mark IO Operations
OSStatus    Pancake_StartIO(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inDeviceObjectID, UInt32 inClientID) {
    abort();
    return (OSStatus)0;
}
OSStatus    Pancake_StopIO(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inDeviceObjectID, UInt32 inClientID) {
    abort();
    return (OSStatus)0;
}
OSStatus    Pancake_GetZeroTimeStamp(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inDeviceObjectID, UInt32 inClientID, Float64* outSampleTime, UInt64* outHostTime, UInt64* outSeed) {
    abort();
    return (OSStatus)0;
}
OSStatus    Pancake_WillDoIOOperation(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inDeviceObjectID, UInt32 inClientID, UInt32 inOperationID, Boolean* outWillDo, Boolean* outWillDoInPlace) {
    abort();
    return (OSStatus)0;
}
OSStatus    Pancake_BeginIOOperation(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inDeviceObjectID, UInt32 inClientID, UInt32 inOperationID, UInt32 inIOBufferFrameSize, const AudioServerPlugInIOCycleInfo* inIOCycleInfo) {
    abort();
    return (OSStatus)0;
}
OSStatus    Pancake_DoIOOperation(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inDeviceObjectID, AudioObjectID inStreamObjectID, UInt32 inClientID, UInt32 inOperationID, UInt32 inIOBufferFrameSize, const AudioServerPlugInIOCycleInfo* inIOCycleInfo, void* __nullable ioMainBuffer, void* __nullable ioSecondaryBuffer) {
    abort();
    return (OSStatus)0;
}
OSStatus    Pancake_EndIOOperation(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inDeviceObjectID, UInt32 inClientID, UInt32 inOperationID, UInt32 inIOBufferFrameSize, const AudioServerPlugInIOCycleInfo* inIOCycleInfo) {
    abort();
    return (OSStatus)0;
}
