//
//  PancakeDeviceIO.swift
//  Pancake
//
//  Created by mxa on 22.09.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio

extension PancakeDevice {
    /// Starts IO on the device.
    internal func startIO() throws {
        guard !self.IOCount.maxxedOut else {
            throw PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.illegalOperation)
        }
        
        // Start timing
        if self.IOCount.value == 0 {
            self.cycleCount.value    = 0
            self.referenceHostTime.value = mach_absolute_time()
        }
        
        self.IOCount.increment()
    }
    
    
    /// Stops IO on the device.
    internal func stopIO() throws {
        guard self.IOCount.value > 0 else {
            throw PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.illegalOperation)
        }
        self.IOCount.decrement()
    }
    
    
    /// Calculates sample & host time of the current cycle.
    internal func zeroTimeStamp() -> (sampleTime: Float64, hostTime: UInt64, timelineSeed: UInt64) {
        let ticksPerRingBuffer = UInt64(self.configuration.ticksPerRingBuffer)
        
        // Calculate the end of the active cycle
        let ticksUntilEndOfCurrentCycle = (self.cycleCount.value + 1) * ticksPerRingBuffer
        let hostTimeAtEndOfCurrentCycle = self.referenceHostTime.value + ticksUntilEndOfCurrentCycle
        
        // Increment the cycle count after each ringbuffer, if we're out of it
        let currentHostTime = mach_absolute_time()
        if hostTimeAtEndOfCurrentCycle <= currentHostTime {
            self.cycleCount.increment()
        }
        
        // Calculate sample & host time at the beginning of the current cycle
        let sampleTime = Float64(self.cycleCount.value) * Float64(self.configuration.ringBuffer.size)
        let hostTime   = self.referenceHostTime.value + (self.cycleCount.value * ticksPerRingBuffer)
        
        // Our timeline doesn't change, so return a consistent value
        let timelineSeed = UInt64(1)
        
        return (sampleTime: sampleTime, hostTime: hostTime, timelineSeed: timelineSeed)
    }
    
    func supports(operation: AudioServerPlugInIOOperation) -> (supported: Bool, isInPlaceOperation: Bool) {
        switch operation {
        case .thread,
             .readInput,
             .processOutput,
             .writeMix:
            return (supported: true, isInPlaceOperation: true)
            
        case .cycle,
             .convertInput,
             .processInput,
             .mixOutput,
             .processMix,
             .convertMix:
            return (supported: false, isInPlaceOperation: true)
        }
    }
    
    func execute(operation: AudioServerPlugInIOOperation, streamObjectID: AudioObjectID, numberOfFrames: Int, cycle: AudioServerPlugInIOCycleInfo, buffer: UnsafeMutableRawPointer) throws {
        let stream = self.streams.first { $0.objectID == streamObjectID }
        guard stream != nil else {
            assertionFailure()
            throw PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.illegalOperation)
        }
        
        let ringBuffer = self.configuration.ringBuffer
        
        switch operation {
        // Transfers input data from the device to the provided buffer.
        case .readInput:
            let ringBufferSize = Int(ringBuffer.size)
            let sampleTime = Int(cycle.mInputTime.mSampleTime)
            let startFrameOffset = sampleTime % ringBufferSize
            
            // Copy bytes from the ringbuffer to the outputBuffer
            ringBuffer.write(numberOfFrames: numberOfFrames, fromOffset: startFrameOffset, to: buffer)
            
            
        // Performs arbitrary signal processing on the output data.
        case .processOutput:
            // TODO:
            return
            
            
        // Puts data into the device.
        case .writeMix:
            let ringBufferSize = Int(ringBuffer.size)
            let sampleTime = Int(cycle.mOutputTime.mSampleTime)
            let startFrameOffset = sampleTime % ringBufferSize
            
            // Copy bytes from the inputBuffer to the ringbuffer
            ringBuffer.read(numberOfFrames: numberOfFrames, fromOffset: startFrameOffset, from: buffer)
            
            
        default:
            throw PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.illegalOperation)
        }
    }
}
