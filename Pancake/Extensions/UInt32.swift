//
//  UInt32.swift
//  Pancake
//
//  Created by mxa on 19.09.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import Foundation

extension UInt32 {
    init(_ bool: Bool) {
        self = bool ? 1 : 0
    }
}
