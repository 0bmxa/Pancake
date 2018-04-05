//
//  Array.swift
//  Pancake
//
//  Created by mxa on 14.09.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

extension Array {
    /// Creates a new array with only the number of elements from the original
    /// theat fit in the given amout of memory.
    /// Note that for convenience reasons the memory size is optional, but as no
    /// calculation can be done without a memory size, the full array is returned
    /// in such case.
    ///
    /// - Parameter avaliableMemory: The size of memory available to the new
    ///             array.
    /// - Returns: A copy of the original array, limited to the given memory
    ///            size starting at index 0, or the full array, if no memory
    ///            size was given.
    func limitedTo(avaliableMemory: UInt32?) -> [Element] {
        // Return all elements, if memory size is not set
        guard let expectedNumberOfElements = number(of: Element.self, thatFitIn: avaliableMemory) else {
            return self
        }

        // Get elements
        let numberOfElements = Swift.min(expectedNumberOfElements, self.count)
        let elements = self[ 0..<numberOfElements ]
        return Array(elements)
    }
}
