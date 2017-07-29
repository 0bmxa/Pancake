//
//  AudioServerPlugInDriverRef.c
//  Pancake
//
//  Created by mxa on 29.07.2017.
//  Copyright © 2017 mxa. All rights reserved.
//

#include "AudioServerPlugInDriverRef.h"

AudioServerPlugInDriverRef driverReferenceFromInterface(AudioServerPlugInDriverInterface interface)
{
    AudioServerPlugInDriverInterface *interfacePtr = &interface;
    AudioServerPlugInDriverRef driverReference = &interfacePtr;
    return driverReference;
}
