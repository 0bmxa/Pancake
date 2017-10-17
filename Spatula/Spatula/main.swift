//
//  main.swift
//  Spatula
//
//  Created by mxa on 27.09.2017.
//  Copyright © 2017 mxa. All rights reserved.
//

import Foundation
import XPC


// Create the delegate for the service.
let delegate = ServiceDelegate()

// Set up the one NSXPCListener for this service. It will handle all incoming connections.
let listener = NSXPCListener.service()
listener.delegate = delegate

// Resuming the serviceListener starts this service. This method does not return.
listener.resume()
