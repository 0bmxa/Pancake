//
//  HALClient.swift
//  Pancake
//
//  Created by mxa on 15.05.2018.
//  Copyright © 2018 0bmxa. All rights reserved.
//



/// A client of the Audio HAL Server.
internal struct HALClient {
    /// An ID that allows for differentiating multiple clients in the same
    /// process.
    let clientID: UInt32

    /// The PID of the process that contains the client.
    let processID: pid_t

    /// Whether the client has the same endianness as the server or not.
    let nativeEndian: Bool

    /// The bundle ID of the main bundle of the process that contains the
    /// client. Note that the plug-in is expected to retain this string itself
    /// if the plug-in wishes to keep it around.
    let bundleID: String?

    init(from clientInfo: AudioServerPlugInClientInfo) {
        self.clientID = clientInfo.mClientID
        self.processID = clientInfo.mProcessID
        self.nativeEndian = Bool(clientInfo.mIsNativeEndian)
        self.bundleID = clientInfo.mBundleID?.takeUnretainedValue() as String?
    }
}

extension HALClient: Equatable {
    static func == (lhs: HALClient, rhs: HALClient) -> Bool {
        return lhs.clientID == rhs.clientID
    }
}
