//
//  SwiftBridge.m
//  Pancake
//
//  Created by mxa on 17.07.2017.
//  Copyright © 2017 mxa. All rights reserved.
//

#include "SwiftBridge.h"
#include "Factory.h"
#include "Pancake-Swift.h"


void setup() {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        AudioServerPlugInDriverRef driver = audioServerPlugInDriverRef;
        AudioServerPlugInDriverInterface *interface = &audioServerPlugInDriverInterface;
        [PancakeBridge setDriver:interface];
    });
}


#pragma mark - Inheritance
HRESULT Pancake_QueryInterface(void* __nullable inDriver, REFIID inUUID, LPVOID __nullable * __nullable outInterface)
{
    setup();
    
    HRESULT (^ _Nonnull queryInterface)(void* __nullable inDriver, REFIID inUUID, LPVOID __nullable * __nullable outInterface) = [PancakeBridge queryInterfaceFunc];
    return queryInterface(inDriver, inUUID, outInterface);
}

ULONG Pancake_AddRef(void* __nullable inDriver)
{
    ULONG (^ _Nonnull addRef)(void* __nullable inDriver) = [PancakeBridge addRefFunc];
    return addRef(inDriver);
}

ULONG Pancake_Release(void* __nullable inDriver)
{
    ULONG (^ _Nonnull release)(void* __nullable inDriver) = [PancakeBridge releaseyyyFunc];
    return release(inDriver);
}





#pragma mark - Basic Operations
OSStatus Pancake_Initialize(AudioServerPlugInDriverRef __nonnull inDriver, AudioServerPlugInHostRef inHost)
{
    OSStatus (^ _Nonnull initialize)(AudioServerPlugInDriverRef __nonnull inDriver, AudioServerPlugInHostRef inHost) = [PancakeBridge initializeyyyFunc];
    return initialize(inDriver, inHost);
}

OSStatus Pancake_CreateDevice(AudioServerPlugInDriverRef __nonnull inDriver, CFDictionaryRef inDescription, const AudioServerPlugInClientInfo* inClientInfo, AudioObjectID* outDeviceObjectID)
{
    OSStatus (^ _Nonnull createDevice)(AudioServerPlugInDriverRef __nonnull inDriver, CFDictionaryRef inDescription, const AudioServerPlugInClientInfo* inClientInfo, AudioObjectID* outDeviceObjectID) = [PancakeBridge createDeviceFunc];
    return createDevice(inDriver, inDescription, inClientInfo, outDeviceObjectID);
}

OSStatus Pancake_DestroyDevice(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inDeviceObjectID)
{
    OSStatus (^ _Nonnull destroyDevice)(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inDeviceObjectID) = [PancakeBridge destroyDeviceFunc];
    return destroyDevice(inDriver, inDeviceObjectID);
}

OSStatus Pancake_AddDeviceClient(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inDeviceObjectID, const AudioServerPlugInClientInfo* inClientInfo)
{
    OSStatus (^ _Nonnull addDeviceClient)(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inDeviceObjectID, const AudioServerPlugInClientInfo* inClientInfo) = [PancakeBridge addDeviceClientFunc];
    return addDeviceClient(inDriver, inDeviceObjectID, inClientInfo);
}

OSStatus Pancake_RemoveDeviceClient(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inDeviceObjectID, const AudioServerPlugInClientInfo* inClientInfo)
{
    OSStatus (^ _Nonnull removeDeviceClient)(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inDeviceObjectID, const AudioServerPlugInClientInfo* inClientInfo) = [PancakeBridge removeDeviceClientFunc];
    return removeDeviceClient(inDriver, inDeviceObjectID, inClientInfo);
}

OSStatus Pancake_PerformDeviceConfigurationChange(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inDeviceObjectID, UInt64 inChangeAction, void* __nullable inChangeInfo)
{
    OSStatus (^ _Nonnull performDeviceConfigurationChange)(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inDeviceObjectID, UInt64 inChangeAction, void* __nullable inChangeInfo) = [PancakeBridge performDeviceConfigurationChangeFunc];
    return performDeviceConfigurationChange(inDriver, inDeviceObjectID, inChangeAction, inChangeInfo);
}

OSStatus Pancake_AbortDeviceConfigurationChange(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inDeviceObjectID, UInt64 inChangeAction, void* __nullable inChangeInfo)
{
    OSStatus (^ _Nonnull abortDeviceConfigurationChange)(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inDeviceObjectID, UInt64 inChangeAction, void* __nullable inChangeInfo) = [PancakeBridge abortDeviceConfigurationChangeFunc];
    return abortDeviceConfigurationChange(inDriver, inDeviceObjectID, inChangeAction, inChangeInfo);
}





#pragma mark - Property Operations
Boolean Pancake_HasProperty(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inObjectID, pid_t inClientProcessID, const AudioObjectPropertyAddress* inAddress)
{
    Boolean (^ _Nonnull hasProperty)(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inObjectID, pid_t inClientProcessID, const AudioObjectPropertyAddress* inAddress) = [PancakeBridge hasPropertyFunc];
    return hasProperty(inDriver, inObjectID, inClientProcessID, inAddress);
}

OSStatus Pancake_IsPropertySettable(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inObjectID, pid_t inClientProcessID, const AudioObjectPropertyAddress* inAddress, Boolean* outIsSettable)
{
    OSStatus (^ _Nonnull isPropertySettable)(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inObjectID, pid_t inClientProcessID, const AudioObjectPropertyAddress* inAddress, Boolean* outIsSettable) = [PancakeBridge isPropertySettableFunc];
    return isPropertySettable(inDriver, inObjectID, inClientProcessID, inAddress, outIsSettable);
}

OSStatus Pancake_GetPropertyDataSize(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inObjectID, pid_t inClientProcessID, const AudioObjectPropertyAddress* inAddress, UInt32 inQualifierDataSize, const void* __nullable inQualifierData, UInt32* outDataSize)
{
    OSStatus (^ _Nonnull getPropertyDataSize)(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inObjectID, pid_t inClientProcessID, const AudioObjectPropertyAddress* inAddress, UInt32 inQualifierDataSize, const void* __nullable inQualifierData, UInt32* outDataSize) = [PancakeBridge getPropertyDataSizeFunc];
    return getPropertyDataSize(inDriver, inObjectID, inClientProcessID, inAddress, inQualifierDataSize, inQualifierData, outDataSize);
}

OSStatus Pancake_GetPropertyData(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inObjectID, pid_t inClientProcessID, const AudioObjectPropertyAddress* inAddress, UInt32 inQualifierDataSize, const void* __nullable inQualifierData, UInt32 inDataSize, UInt32* outDataSize, void* outData)
{
    OSStatus (^ _Nonnull getPropertyData)(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inObjectID, pid_t inClientProcessID, const AudioObjectPropertyAddress* inAddress, UInt32 inQualifierDataSize, const void* __nullable inQualifierData, UInt32 inDataSize, UInt32* outDataSize, void* outData) = [PancakeBridge getPropertyDataFunc];
    return getPropertyData(inDriver, inObjectID, inClientProcessID, inAddress, inQualifierDataSize, inQualifierData, inDataSize, outDataSize, outData);
}

OSStatus Pancake_SetPropertyData(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inObjectID, pid_t inClientProcessID, const AudioObjectPropertyAddress* inAddress, UInt32 inQualifierDataSize, const void* __nullable inQualifierData, UInt32 inDataSize, const void* inData)
{
    OSStatus (^ _Nonnull setPropertyData)(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inObjectID, pid_t inClientProcessID, const AudioObjectPropertyAddress* inAddress, UInt32 inQualifierDataSize, const void* __nullable inQualifierData, UInt32 inDataSize, const void* inData) = [PancakeBridge setPropertyDataFunc];
    return setPropertyData(inDriver, inObjectID, inClientProcessID, inAddress, inQualifierDataSize, inQualifierData, inDataSize, inData);
}





#pragma mark - IO Operations
OSStatus Pancake_StartIO(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inDeviceObjectID, UInt32 inClientID)
{
    OSStatus (^ _Nonnull startIO)(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inDeviceObjectID, UInt32 inClientID) = [PancakeBridge startIOFunc];
    return startIO(inDriver, inDeviceObjectID, inClientID);
}

OSStatus Pancake_StopIO(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inDeviceObjectID, UInt32 inClientID)
{
    OSStatus (^ _Nonnull stopIO)(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inDeviceObjectID, UInt32 inClientID) = [PancakeBridge stopIOFunc];
    return stopIO(inDriver, inDeviceObjectID, inClientID);
}

OSStatus Pancake_GetZeroTimeStamp(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inDeviceObjectID, UInt32 inClientID, Float64* outSampleTime, UInt64* outHostTime, UInt64* outSeed)
{
    OSStatus (^ _Nonnull getZeroTimeStamp)(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inDeviceObjectID, UInt32 inClientID, Float64* outSampleTime, UInt64* outHostTime, UInt64* outSeed) = [PancakeBridge getZeroTimeStampFunc];
    return getZeroTimeStamp(inDriver, inDeviceObjectID, inClientID, outSampleTime, outHostTime, outSeed);
}

OSStatus Pancake_WillDoIOOperation(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inDeviceObjectID, UInt32 inClientID, UInt32 inOperationID, Boolean* outWillDo, Boolean* outWillDoInPlace)
{
    OSStatus (^ _Nonnull willDoIOOperation)(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inDeviceObjectID, UInt32 inClientID, UInt32 inOperationID, Boolean* outWillDo, Boolean* outWillDoInPlace) = [PancakeBridge willDoIOOperationFunc];
    return willDoIOOperation(inDriver, inDeviceObjectID, inClientID, inOperationID, outWillDo, outWillDoInPlace);
}

OSStatus Pancake_BeginIOOperation(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inDeviceObjectID, UInt32 inClientID, UInt32 inOperationID, UInt32 inIOBufferFrameSize, const AudioServerPlugInIOCycleInfo* inIOCycleInfo)
{
    OSStatus (^ _Nonnull beginIOOperation)(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inDeviceObjectID, UInt32 inClientID, UInt32 inOperationID, UInt32 inIOBufferFrameSize, const AudioServerPlugInIOCycleInfo* inIOCycleInfo) = [PancakeBridge beginIOOperationFunc];
    return beginIOOperation(inDriver, inDeviceObjectID, inClientID, inOperationID, inIOBufferFrameSize, inIOCycleInfo);
}

OSStatus Pancake_DoIOOperation(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inDeviceObjectID, AudioObjectID inStreamObjectID, UInt32 inClientID, UInt32 inOperationID, UInt32 inIOBufferFrameSize, const AudioServerPlugInIOCycleInfo* inIOCycleInfo, void* __nullable ioMainBuffer, void* __nullable ioSecondaryBuffer)
{
    OSStatus (^ _Nonnull doIOOperation)(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inDeviceObjectID, AudioObjectID inStreamObjectID, UInt32 inClientID, UInt32 inOperationID, UInt32 inIOBufferFrameSize, const AudioServerPlugInIOCycleInfo* inIOCycleInfo, void* __nullable ioMainBuffer, void* __nullable ioSecondaryBuffer) = [PancakeBridge doIOOperationFunc];
    return doIOOperation(inDriver, inDeviceObjectID, inStreamObjectID, inClientID, inOperationID, inIOBufferFrameSize, inIOCycleInfo, ioMainBuffer, ioSecondaryBuffer);
}

OSStatus Pancake_EndIOOperation(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inDeviceObjectID, UInt32 inClientID, UInt32 inOperationID, UInt32 inIOBufferFrameSize, const AudioServerPlugInIOCycleInfo* inIOCycleInfo)
{
    OSStatus (^ _Nonnull endIOOperation)(AudioServerPlugInDriverRef __nonnull inDriver, AudioObjectID inDeviceObjectID, UInt32 inClientID, UInt32 inOperationID, UInt32 inIOBufferFrameSize, const AudioServerPlugInIOCycleInfo* inIOCycleInfo) = [PancakeBridge endIOOperationFunc];
    return endIOOperation(inDriver, inDeviceObjectID, inClientID, inOperationID, inIOBufferFrameSize, inIOCycleInfo);
}

