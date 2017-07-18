//
//  _Others.h
//  Pancake
//
//  Created by mxa on 17.07.2017.
//  Copyright © 2017 mxa. All rights reserved.
//

#include "Factory.h"

HRESULT     Pancake_QueryInterface(void*, REFIID, LPVOID*);
ULONG       Pancake_AddRef(void*);
ULONG       Pancake_Release(void*);
OSStatus    Pancake_Initialize(AudioServerPlugInDriverRef, AudioServerPlugInHostRef);
OSStatus    Pancake_CreateDevice(AudioServerPlugInDriverRef, CFDictionaryRef, const AudioServerPlugInClientInfo*, AudioObjectID*);
OSStatus    Pancake_DestroyDevice(AudioServerPlugInDriverRef, AudioObjectID);
OSStatus    Pancake_AddDeviceClient(AudioServerPlugInDriverRef, AudioObjectID, const AudioServerPlugInClientInfo*);
OSStatus    Pancake_RemoveDeviceClient(AudioServerPlugInDriverRef, AudioObjectID, const AudioServerPlugInClientInfo*);
OSStatus    Pancake_PerformDeviceConfigurationChange(AudioServerPlugInDriverRef, AudioObjectID, UInt64, void*);
OSStatus    Pancake_AbortDeviceConfigurationChange(AudioServerPlugInDriverRef, AudioObjectID, UInt64, void*);
Boolean     Pancake_HasProperty(AudioServerPlugInDriverRef, AudioObjectID, pid_t, const AudioObjectPropertyAddress*);
OSStatus    Pancake_IsPropertySettable(AudioServerPlugInDriverRef, AudioObjectID, pid_t, const AudioObjectPropertyAddress*, Boolean*);
OSStatus    Pancake_GetPropertyDataSize(AudioServerPlugInDriverRef, AudioObjectID, pid_t, const AudioObjectPropertyAddress*, UInt32, const void*, UInt32*);
OSStatus    Pancake_GetPropertyData(AudioServerPlugInDriverRef, AudioObjectID, pid_t, const AudioObjectPropertyAddress*, UInt32, const void*, UInt32, UInt32*, void*);
OSStatus    Pancake_SetPropertyData(AudioServerPlugInDriverRef, AudioObjectID, pid_t, const AudioObjectPropertyAddress*, UInt32, const void*, UInt32, const void*);
OSStatus    Pancake_StartIO(AudioServerPlugInDriverRef, AudioObjectID, UInt32);
OSStatus    Pancake_StopIO(AudioServerPlugInDriverRef, AudioObjectID, UInt32);
OSStatus    Pancake_GetZeroTimeStamp(AudioServerPlugInDriverRef, AudioObjectID, UInt32, Float64*, UInt64*, UInt64*);
OSStatus    Pancake_WillDoIOOperation(AudioServerPlugInDriverRef, AudioObjectID, UInt32, UInt32, Boolean*, Boolean*);
OSStatus    Pancake_BeginIOOperation(AudioServerPlugInDriverRef, AudioObjectID, UInt32, UInt32, UInt32, const AudioServerPlugInIOCycleInfo*);
OSStatus    Pancake_DoIOOperation(AudioServerPlugInDriverRef, AudioObjectID, AudioObjectID, UInt32, UInt32, UInt32, const AudioServerPlugInIOCycleInfo*, void*, void*);
OSStatus    Pancake_EndIOOperation(AudioServerPlugInDriverRef, AudioObjectID, UInt32, UInt32, UInt32, const AudioServerPlugInIOCycleInfo*);
