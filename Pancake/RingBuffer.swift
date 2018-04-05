//
//  RingBuffer.swift
//  Pancake
//
//  Created by mxa on 19.09.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio.CoreAudioTypes

class RingBuffer {
    private(set) var frames: UInt32
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

    private func reAllocateBuffer() {
        self.byteSize = self.frames * self.activeFormat.mBytesPerFrame
        self.buffer = realloc(self.buffer, Int(self.byteSize))
    }

    func fill(from srcBuffer: UnsafeMutableRawPointer, fromOffset frameOffset: UInt32, numberOfFrames frameCount: UInt32) {
        // Translate frames to bytes
        let bytesPerFrame = self.activeFormat.mBytesPerFrame
        let startByte = Int(frameOffset * bytesPerFrame)
        let bytesToCopy = Int(frameCount * bytesPerFrame)

        guard bytesToCopy <= self.byteSize else { assertionFailure(); return }

        self.serialQueue.sync {
            // Copy directly, if we can.
            // (If the segment to copy fits in the rest of the ringbuffer)
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


    func copy(to destBuffer: UnsafeMutableRawPointer, fromOffset frameOffset: UInt32, numberOfFrames frameCount: UInt32) {
        // Translate frames to bytes
        let bytesPerFrame = Int(self.activeFormat.mBytesPerFrame)
        let startByte = Int(frameOffset) * bytesPerFrame
        let bytesToCopy = Int(frameCount) * bytesPerFrame

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
        self.reAllocateBuffer()
    }

    /// Updates the frame count used in the ringbuffer.
    /// **Caution:** this resets the buffer.
    ///
    /// - Parameter frames: The new number of frames to be used.
    func update(frames: Int) {
        self.frames = UInt32(frames)
        self.reAllocateBuffer()
    }
}
