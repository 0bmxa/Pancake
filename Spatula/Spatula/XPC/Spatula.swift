//
//  Spatula.swift
//  Spatula
//
//  Created by mxa on 27.09.2017.
//  Copyright © 2017 mxa. All rights reserved.
//

import Foundation

class Spatula: SpatulaProtocol {
    // This implements the example protocol. Replace the body of this class with the implementation of this service's protocol.
    func upperCaseString(_ string: String, withReply reply: (String) -> Void) {
        let response = string.uppercased()
        reply(response)
    }
}


/*
@objc protocol MyProcessCommunicationProtocol {
    func sendSomething(something: Int)
    func getSometing() -> Int
}

class ProcessCommunicationBase: NSObject {
    typealias CommunicationProtocol = MyProcessCommunicationProtocol
    let remoteInterface = NSXPCInterface(with: CommunicationProtocol.self)
    
    // Make default init unavailable
    private override init() {}
}

class ProcessCommunicationServer: ProcessCommunicationBase {
    private let connection: NSXPCConnection
    
    init(serviceName: String) {
        self.connection = NSXPCConnection(serviceName: serviceName)
        self.connection.remoteObjectInterface = self.remoteInterface
        self.connection.resume()
    }
    
    deinit {
        self.connection.suspend()
    }
    
    var remoteObject: CommunicationProtocol {
        return self.connection.remoteObjectProxy as! CommunicationProtocol
    }
}

class ProcessCommunicationClient: ProcessCommunicationBase, NSXPCListenerDelegate {
    private let exportedObject: CommunicationProtocol
    
    init(object: CommunicationProtocol) {
        self.exportedObject = object
    }
    
    func listener(_ listener: NSXPCListener, shouldAcceptNewConnection newConnection: NSXPCConnection) -> Bool {
        newConnection.exportedInterface = self.remoteInterface
        newConnection.exportedObject = self.exportedObject
        newConnection.resume()
        return true
    }
}


let listener = NSXPCListener(machServiceName: <#T##String#>)
*/
