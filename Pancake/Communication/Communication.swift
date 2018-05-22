//
//  Communication.swift
//  Pancake
//
//  Created by mxa on 05.04.2018.
//  Copyright © 2018 0bmxa. All rights reserved.
//

import Syrup

class DaemonReference {
    private let daemonServiceName: String
    private let connection: Syrup.Connection

    internal var processID: Int32? {
        return self.connection.processID
    }

    init(daemonServiceName: String) {
        self.daemonServiceName = daemonServiceName
        self.connection = Connection(to: daemonServiceName)
    }

    private func daemon(errorHandler: @escaping (Error) -> Void) -> SyrupProtocol? {
        if let daemon = self.connection.getRemoteObject(errorHandler: errorHandler) {
            return daemon
        }

        // As we can't really communicate an error to the outside world,
        // we can only restart the connection and try again
        self.connection.restart()
        let daemon = self.connection.getRemoteObject(errorHandler: errorHandler)
        return daemon
    }

    func startAudio(deviceUID: String) -> Bool {
        let synchronizer = Synchronizer()
        let daemon = self.daemon(errorHandler: synchronizer.errorFunction)
        daemon?.startAudio(deviceUID: deviceUID, completion: synchronizer.successFunction)
        return synchronizer.returnValue()
    }

    func stopAudio() -> Bool {
        let synchronizer = Synchronizer()
        let daemon = self.daemon(errorHandler: synchronizer.errorFunction)
        daemon?.stopAudio(completion: synchronizer.successFunction)
        return synchronizer.returnValue()
    }

}


private class Synchronizer {
    private var success: Bool = false
    private let semaphore = DispatchSemaphore(value: 1)
    private let timeout: Int

    init(timeout: Int = 5) {
        self.timeout = timeout
    }

    func errorFunction(error: Error) {
        self.success = false
        self.semaphore.signal()
    }

    func successFunction() {
        self.success = true
        self.semaphore.signal()
    }

    func returnValue() -> Bool {
        let deadline = DispatchTime.now() + DispatchTimeInterval.seconds(self.timeout)
        let waitResult = semaphore.wait(timeout: deadline)
        return success && (waitResult == .success)
    }
}
