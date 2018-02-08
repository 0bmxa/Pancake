//
//  PancakeFactory.h
//  SampleDriver
//
//  Created by mxa on 14.12.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

#include <CoreAudio/CoreAudioTypes.h>

#ifndef SAMPLEDRIVER_PANCAKEFACTORY_H_
#define SAMPLEDRIVER_PANCAKEFACTORY_H_

AudioStreamBasicDescription CreateFloat32HardwareASBD(Float64 sampleRate,
                                                      UInt32 channelCount);

#endif  // SAMPLEDRIVER_PANCAKEFACTORY_H_
