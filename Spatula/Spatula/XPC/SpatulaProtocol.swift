//
//  SpatulaProtocol.swift
//  Spatula
//
//  Created by mxa on 27.09.2017.
//  Copyright © 2017 mxa. All rights reserved.
//

import Foundation

// The protocol that this service will vend as its API. This header file will also need to be visible to the process hosting the service.
@objc protocol SpatulaProtocol {
    // Replace the API of this protocol with an API appropriate to the service you are vending.
    func upperCaseString(_ string: String, withReply reply: (String) -> Void)
}



/*
 To use the service from an application or other process, use NSXPCConnection to establish a connection to the service by doing something like this:
 
 _connectionToService = [[NSXPCConnection alloc] initWithServiceName:@"com.0bmxa.Spatula"];
 _connectionToService.remoteObjectInterface = [NSXPCInterface interfaceWithProtocol:@protocol(SpatulaProtocol)];
 [_connectionToService resume];
 
 Once you have a connection to the service, you can use it like this:
 
 [[_connectionToService remoteObjectProxy] upperCaseString:@"hello" withReply:^(NSString *aString) {
 // We have received a response. Update our text field, but do it on the main thread.
 NSLog(@"Result string was: %@", aString);
 }];
 
 And, when you are finished with the service, clean up the connection like this:
 
 [_connectionToService invalidate];
 */
