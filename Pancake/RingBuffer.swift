//
//  RingBuffer.swift
//  Pancake
//
//  Created by mxa on 19.09.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio

class RingBuffer {
    let size: UInt32
    private let buffer: UnsafeMutableRawPointer
    private let serialQueue: DispatchQueue
    private var activeFormat: AudioStreamBasicDescription?

    init(size: UInt32) {
        self.size = size
        self.buffer = calloc(1, Int(size))

        let queueID = UUID().string
        self.serialQueue = DispatchQueue(label: "Pancake.RingBuffer." + queueID)
    }

    func read(numberOfFrames frameCount: Int, fromOffset frameOffset: Int, from srcBuffer: UnsafeMutableRawPointer) {

        guard let format = self.activeFormat else { assertionFailure(); return }

        // Translate frames to bytes
        let bytesPerFrame = Int(format.mBytesPerFrame)
        let startByte = frameOffset * bytesPerFrame
        let bytesToCopy = frameCount * bytesPerFrame

        guard bytesToCopy <= self.size else { assertionFailure(); return }

        self.serialQueue.sync {
            // Copy directly, if we can
            // (if the segment to copy fits in the rest of the ringbuffer)
            if (startByte + bytesToCopy) <= self.size  {
                memcpy(self.buffer + startByte, srcBuffer, bytesToCopy)
                return
            }

            // Otherwise, copy first half from [offset – ringbuffer end],
            // then second half [ringbuffer start – requested lenght]
            let sizeOfFirstHalf  = Int(self.size) - startByte
            let sizeOfSecondHalf = bytesToCopy - sizeOfFirstHalf
            memcpy(self.buffer + startByte, srcBuffer,                   sizeOfFirstHalf)
            memcpy(self.buffer,             srcBuffer + sizeOfFirstHalf, sizeOfSecondHalf)
        }

    }


    func write(numberOfFrames frameCount: Int, fromOffset frameOffset: Int, to destBuffer: UnsafeMutableRawPointer) {
        guard let format = self.activeFormat else { assertionFailure(); return }

        // Translate frames to bytes
        let bytesPerFrame = Int(format.mBytesPerFrame)
        let startByte = frameOffset * bytesPerFrame
        let bytesToCopy = frameCount * bytesPerFrame

        guard bytesToCopy <= self.size else { assertionFailure(); return }

        self.serialQueue.sync {
            // Copy directly, if we can
            // (if the segment to copy can be taken from the rest of the ringbuffer)
            if (startByte + bytesToCopy) <= self.size  {
                memcpy(destBuffer, self.buffer + startByte, bytesToCopy)
                return
            }

            // Otherwise, copy first half from [offset – ringbuffer end],
            // then second half [ringbuffer start – requested lenght]
            let sizeOfFirstHalf  = Int(self.size) - startByte
            let sizeOfSecondHalf = bytesToCopy - sizeOfFirstHalf
            memcpy(destBuffer,                   self.buffer + startByte, sizeOfFirstHalf)
            memcpy(destBuffer + sizeOfFirstHalf, self.buffer,             sizeOfSecondHalf)
        }
    }


    /// Sets the format used in the ringbuffer. Caution: this clears the buffer.
    ///
    /// - Parameter format: The new audio format to be used.
    func setFormat(_ format: AudioStreamBasicDescription) {
        memset(self.buffer, 0, Int(self.size))
        self.activeFormat = format
    }

}
