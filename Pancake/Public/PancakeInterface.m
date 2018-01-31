//
//  PancakeInterface.m
//  Pancake
//
//  Created by mxa on 19.12.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

#import "PancakeInterface.h"

#import <Foundation/Foundation.h>
#import <Pancake/Pancake-Swift.h>

void PancakeSetupSharedInstance(PancakeConfiguration *config)
{
    [Pancake setupSharedInstance:config];
    PancakeDriverReference = [Pancake driverInterface];
}
