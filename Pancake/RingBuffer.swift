//
//  RingBuffer.swift
//  Pancake
//
//  Created by mxa on 19.09.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio

class RingBuffer {
    let frames: UInt32
    private var byteSize: UInt32
    private var buffer: UnsafeMutableRawPointer
    private let serialQueue: DispatchQueue
    private var activeFormat: AudioStreamBasicDescription

    init(frames: UInt32, format: AudioStreamBasicDescription) {
        self.frames = frames
        self.activeFormat = format
        self.byteSize = frames * format.mBytesPerFrame
        self.buffer = calloc(1, Int(self.byteSize))

        let queueID = UUID().string
        self.serialQueue = DispatchQueue(label: "Pancake.RingBuffer." + queueID)
    }

    deinit {
        free(self.buffer)
    }

    private func reallocBuffer() {
        free(self.buffer)
        self.byteSize = self.frames * self.activeFormat.mBytesPerFrame
        self.buffer = calloc(1, Int(self.byteSize))
    }

    func fill(from srcBuffer: UnsafeMutableRawPointer, fromOffset frameOffset: Int, numberOfFrames frameCount: Int) {
        // Translate frames to bytes
        let bytesPerFrame = Int(self.activeFormat.mBytesPerFrame)
        let startByte = frameOffset * bytesPerFrame
        let bytesToCopy = frameCount * bytesPerFrame

        guard bytesToCopy <= self.byteSize else { assertionFailure(); return }

        self.serialQueue.sync {
            // Copy directly, if we can
            // (if the segment to copy fits in the rest of the ringbuffer)
            if (startByte + bytesToCopy) <= self.byteSize  {
                memcpy(self.buffer + startByte, srcBuffer, bytesToCopy)
                return
            }

            // Otherwise, copy first half from [offset – ringbuffer end],
            // then second half [ringbuffer start – requested lenght]
            let sizeOfFirstHalf  = Int(self.byteSize) - startByte
            let sizeOfSecondHalf = bytesToCopy - sizeOfFirstHalf
            memcpy(self.buffer + startByte, srcBuffer,                   sizeOfFirstHalf)
            memcpy(self.buffer,             srcBuffer + sizeOfFirstHalf, sizeOfSecondHalf)
        }

    }


    func copy(to destBuffer: UnsafeMutableRawPointer, fromOffset frameOffset: Int, numberOfFrames frameCount: Int) {
        // Translate frames to bytes
        let bytesPerFrame = Int(self.activeFormat.mBytesPerFrame)
        let startByte = frameOffset * bytesPerFrame
        let bytesToCopy = frameCount * bytesPerFrame

        guard bytesToCopy <= self.byteSize else { assertionFailure(); return }

        self.serialQueue.sync {
            // Copy directly, if we can
            // (if the segment to copy can be taken from the rest of the ringbuffer)
            if (startByte + bytesToCopy) <= self.byteSize  {
                memcpy(destBuffer, self.buffer + startByte, bytesToCopy)
                return
            }

            // Otherwise, copy first half from [offset – ringbuffer end],
            // then second half [ringbuffer start – requested lenght]
            let sizeOfFirstHalf  = Int(self.byteSize) - startByte
            let sizeOfSecondHalf = bytesToCopy - sizeOfFirstHalf
            memcpy(destBuffer,                   self.buffer + startByte, sizeOfFirstHalf)
            memcpy(destBuffer + sizeOfFirstHalf, self.buffer,             sizeOfSecondHalf)
        }
    }


    /// Updates the format used in the ringbuffer.
    /// **Caution:** this resets the buffer.
    ///
    /// - Parameter format: The new audio format to be used.
    func update(format: AudioStreamBasicDescription) {
        self.activeFormat = format
        self.reallocBuffer()
    }

    func update(frameCount: Int) {
        
    }
}
