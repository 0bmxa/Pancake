//
//  PluginInterface.swift
//  Pancake
//
//  Created by mxa on 11.08.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio.AudioServerPlugIn

class PluginInterface {
    private var pointer: UnsafeMutablePointer<UnsafeMutableRawPointer?>
    
    init?(from pointer: UnsafeMutablePointer<UnsafeMutableRawPointer?>?) {
        guard let pointer = pointer else {
            assertionFailure()
            return nil
        }
        self.pointer = pointer
    }
    
    func setInterfacePointer(from driver: AudioServerPlugInDriver) {
        self.pointer.pointee = UnsafeMutableRawPointer(driver.reference)
    }
}
