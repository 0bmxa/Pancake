//
//  more.swift
//  Pancake
//
//  Created by mxa on 27.07.2017.
//  Copyright © 2017 mxa. All rights reserved.
//

import CoreAudio.AudioServerPlugIn

struct PancakeInheritance {
    func queryInterface(driver: AudioServerPlugInDriverRef!, UUID: REFIID, interface: inout UnsafeMutablePointer<UnsafeMutableRawPointer?>!) -> HRESULT {

//        guard let driver = driver else {
//            fatalError()
//        }
        
        return 0
    }
    
    func addRef(driver: UnsafeMutableRawPointer?) -> ULONG {
        return 0
    }
    
    func release(driver: UnsafeMutableRawPointer?) -> ULONG {
        return 0
    }
}

