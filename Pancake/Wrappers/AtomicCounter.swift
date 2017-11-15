//
//  AtomicCounter.swift
//  Pancake
//
//  Created by mxa on 16.08.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import Foundation

struct AtomicCounter<T: FixedWidthInteger> {
    private var _value: T
    private let serialQueue: DispatchQueue

    init(initialValue: T = 0) {
        self._value = initialValue
        let queueID = UUID().string
        self.serialQueue = DispatchQueue(label: "Pancake.AtomicCounter." + queueID)
    }

    mutating func increment() {
        self.serialQueue.sync {
            guard self._value < T.max else { return }
            self._value += 1
        }
    }

    mutating func decrement() {
        self.serialQueue.sync {
            guard self._value > T.min else { return }
            self._value -= 1
        }
    }

    var value: T {
        get {
            return self.serialQueue.sync {
                self._value
            }
        }
        set {
            self.serialQueue.sync {
                self._value = newValue
            }
        }
    }

    var maxxedOut: Bool {
        return self.value == T.max
    }
}
