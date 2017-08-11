//
//  PluginInterface.swift
//  Pancake
//
//  Created by mxa on 11.08.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio.AudioServerPlugIn

// TODO: Fix this description.
/// A wrapper arount the weird interface you get in queryInterface()
class PluginInterface {
    private var pointer: UnsafeMutablePointer<UnsafeMutableRawPointer?>
    
    init?(from pointer: UnsafeMutablePointer<UnsafeMutableRawPointer?>?) {
        guard let pointer = pointer else {
            assertionFailure()
            return nil
        }
        self.pointer = pointer
    }
    
    //    init?(for driver: AudioServerPlugInDriver?) {
    //        guard let driver = driver else { return nil }
    //        self.pointer = driver.
    //    }
    
    func setInterfacePointer(from driver: AudioServerPlugInDriver) {
        self.pointer.pointee = UnsafeMutableRawPointer(driver.interfacePointer)
    }
}

