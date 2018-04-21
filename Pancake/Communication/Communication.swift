//
//  Communication.swift
//  Pancake
//
//  Created by mxa on 05.04.2018.
//  Copyright © 2018 0bmxa. All rights reserved.
//

import Syrup

let serviceName = "io.mimi.MimiDaemon"

protocol MimiDaemonServiceType: SyrupProtocol {
    func setServerValue(value: Float)
    func getServerValue(callback: (Float) -> ())
}

class DummyService: MimiDaemonServiceType {
    func setServerValue(value: Float) { fatalError() }
    func getServerValue(callback: (Float) -> ()) { fatalError() }
}


struct Communication {

    let connection = Syrup.Connection(to: serviceName)

    func go() {

        let remoteService: DummyService = try! connection.getRemoteObject()
        remoteService.setServerValue(value: 14)
        remoteService.getServerValue { serverValue in
            print(serverValue)
        }

    }

}
