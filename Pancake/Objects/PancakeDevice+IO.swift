//
//  PancakeDeviceIO.swift
//  Pancake
//
//  Created by mxa on 22.09.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio

extension PancakeDevice {
    /// Starts IO for a specific client.
    /// This can take as long as necessary to start IO or indicate failure.
    ///
    /// - Throws: An error indicating whether the action is curretthat no further IO is possible.
    internal func startIO() throws {
        guard !self.IOCount.maxxedOut else {
            throw PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.illegalOperation)
        }

        // Start timing
        if self.IOCount.value == 0 {
            self.cycleCount.value = 0
            self.referenceHostTime.value = mach_absolute_time()
        }
        self.IOCount.increment()
    }


    /// Starts IO for a specific client.
    ///
    /// - Throws: An error indicating that no further IO is possible.
    internal func stopIO() throws {
        guard self.IOCount.value > 0 else {
            throw PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.illegalOperation)
        }

        // Decrements the IO count
        self.IOCount.decrement()
    }


    /// Calculates sample & host time of the current cycle.
    ///
    /// - Returns: A triple containing the current sample time, host time, and timeline seed.
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
        let sampleTime = Float64(self.cycleCount.value) * Float64(self.configuration.ringBuffer.frames)
        let hostTime   = self.referenceHostTime.value + (self.cycleCount.value * ticksPerRingBuffer)

        // Our timeline doesn't change, so return a consistent value
        let timelineSeed = UInt64(1)

        return (sampleTime: sampleTime, hostTime: hostTime, timelineSeed: timelineSeed)
    }


    /// Determines wheter the requested operation is supported, and whether it
    /// is an in-place operation or not.
    ///
    /// - Parameter operation: The operation in question.
    /// - Returns: A tuple of two booleans indicating wheter the operation is
    ///    supported and is an in-place operation or not, respectively.
    func supports(operation: AudioServerPlugInIOOperation) -> (supported: Bool, isInPlaceOperation: Bool) {
        switch operation {
        case .readInput,
             .writeMix:
            return (supported: true, isInPlaceOperation: true)

        case .thread,
             .cycle,
             .convertInput,
             .processInput,
             .mixOutput,
             .processMix,
             .processOutput,
             .convertMix:
            return (supported: false, isInPlaceOperation: true)
        }
    }


    /// Informs that the host is about to begin a phase of the IO cycle.
    ///
    /// - Parameters:
    ///   - operation: The operation being performed shortly.
    ///   - numberOfFrames: The number of frames that will be processed.
    ///   - cycle: Details about the current IO cycle.
    func beginCycle(operation: AudioServerPlugInIOOperation, numberOfFrames: Int, cycleInfo: AudioServerPlugInIOCycleInfo) {
        guard let startIOCallback = self.configuration.startIOCallback else { return }
        let sampleRate = self.configuration.registeredFormat.mSampleRate
        startIOCallback(sampleRate, UInt32(numberOfFrames))
    }


    /// Informs that the host is about to end a phase of the IO cycle.
    ///
    /// - Parameters:
    ///   - operation: The operation which has been performed.
    ///   - numberOfFrames: The number of frames that have been processed.
    ///   - cycle: Details about the current IO cycle.
    func endCycle(operation: AudioServerPlugInIOOperation, numberOfFrames: Int, cycleInfo: AudioServerPlugInIOCycleInfo) {
        guard let stopIOCallback = self.configuration.stopIOCallback else { return }
        let sampleRate = self.configuration.registeredFormat.mSampleRate
        stopIOCallback(sampleRate, UInt32(numberOfFrames))
    }


    /// Performs an IO operation for a particular stream.
    ///
    /// - Parameters:
    ///   - operation: The operation to be performed.
    ///   - streamObjectID: The ID of the stream whose data is being processed.
    ///   - numberOfFrames: The number of frames that have been processed.
    ///   - cycle: Details about the current IO cycle.
    ///   - buffer: The sample buffer for the operation.
    /// - Throws: An error indicating why the operation failed.
    func execute(operation: AudioServerPlugInIOOperation, streamID: AudioObjectID, numberOfFrames: UInt32, cycle: AudioServerPlugInIOCycleInfo, buffer: UnsafeMutableRawPointer) throws {
        let stream = self.streams.first { $0.objectID == streamID }
        guard stream != nil else {
            assertionFailure()
            throw PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.badStream)
        }

        let ringBuffer = self.configuration.ringBuffer


        // A note on operations:
        // - processOutput: is called for (and with) every audio client's data,
        //     so if 3 apps are 'playing', this is called 3 times per cycle.
        // - writeMix: is called for ("global") mixed system output data,
        //     so once every cycle.
        // - readInput: is called for ("global") audio input reading,
        //     so once every cycle.
        // - processInput: is called for every audio client, which reads input
        //     data, so again 3 times, if 3 apps are 'recording'. [UNTESTED]

        switch operation {

        // Transfers input data from the device to the provided buffer.
        // [Device] -> [System]
        case .readInput:
            let ringBufferFrameCount = ringBuffer.frames
            let sampleTime = UInt32(cycle.mInputTime.mSampleTime)
            let startFrameOffset = sampleTime % ringBufferFrameCount

            // Copy bytes from the ringbuffer to the outputBuffer
            ringBuffer.copy(to: buffer, fromOffset: startFrameOffset, numberOfFrames: numberOfFrames)

            if let processingCallback = self.configuration.processingCallback {
                var bufferPointer = buffer.assumingMemoryBound(to: Float32.self)
                processingCallback(bufferPointer, numberOfFrames, self.channelCount, cycle)
            }


        // Puts data into the device.
        // [System] -> [Device]
        case .writeMix:
            let ringBufferFrameCount = ringBuffer.frames
            let sampleTime = UInt32(cycle.mOutputTime.mSampleTime)
            let startFrameOffset = sampleTime % ringBufferFrameCount

            // Copy bytes from the inputBuffer to the ringbuffer
            ringBuffer.fill(from: buffer, fromOffset: startFrameOffset, numberOfFrames: numberOfFrames)


        default:
            throw PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.illegalOperation)
        }
    }
}
