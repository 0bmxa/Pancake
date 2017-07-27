//
//  DynamicRegistration.c
//  Pancake
//
//  Created by mxa on 25.07.2017.
//  Copyright © 2017 mxa. All rights reserved.
//

#include "DynamicRegistration.h"
#include <CoreAudio/AudioServerPlugIn.h>

void CFPlugInDynamicRegister(CFPlugInRef plugIn)
{
    CFUUIDRef factoryUUID = CFUUIDCreateFromString(kCFAllocatorSystemDefault, CFSTR("F3F8529B-D171-4BAC-9D05-0AB00BBB2250"));
    CFStringRef factoryFunctionName = CFSTR("Pancake_Create");
    
    //CFPlugInRegisterFactoryFunction(kFactoryUUID, Pancake_Create);
    CFPlugInRegisterFactoryFunctionByName(factoryUUID, plugIn, factoryFunctionName);
    CFPlugInRegisterPlugInType(factoryUUID, kAudioServerPlugInTypeUUID);

    CFRelease(factoryUUID);
    CFRelease(factoryFunctionName);
}
