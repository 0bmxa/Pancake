//
//  PancakeInterface.h
//  Pancake
//
//  Created by mxa on 19.12.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

#ifndef PANCAKE_PUBLIC_PANCAKEINTERFACE_H_
#define PANCAKE_PUBLIC_PANCAKEINTERFACE_H_

#include "PancakeConfiguration.h"

void PancakeSetupSharedInstance(PancakeConfiguration *config);
extern void *PancakeDriverReference;

#endif  // PANCAKE_PUBLIC_PANCAKEINTERFACE_H_
