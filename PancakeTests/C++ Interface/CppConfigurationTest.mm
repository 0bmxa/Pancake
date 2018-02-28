//
//  CppConfigurationTest.m
//  PancakeTests
//
//  Created by mxa on 10.03.2018.
//  Copyright © 2018 0bmxa. All rights reserved.
//

#import "CppConfigurationTest.h"
#import "PancakeConfiguration.h"

@implementation CppConfigurationTest

- (void)testASBDCreation
{
    int channels = 16;
    int floatSize = sizeof(Float32);
    
    auto asbd = CreateFloat32HardwareASBD(32000, channels);
    
    XCTAssertEqual(asbd.mSampleRate,       32000.0);
    XCTAssertEqual(asbd.mFormatID,         kAudioFormatLinearPCM);
    XCTAssertEqual(asbd.mFormatFlags,      kAudioFormatFlagsNativeEndian | kAudioFormatFlagIsPacked | kAudioFormatFlagIsFloat);
    XCTAssertEqual(asbd.mFramesPerPacket,  1);
    XCTAssertEqual(asbd.mBytesPerFrame,    floatSize * channels);
    XCTAssertEqual(asbd.mChannelsPerFrame, 16);
    XCTAssertEqual(asbd.mBitsPerChannel,   floatSize * 8);
    XCTAssertEqual(asbd.mBytesPerPacket,   floatSize * channels);
}

- (void)testConfigCreation
{
    auto config = CreatePancakeConfig(NULL);

    XCTAssertEqual(config->setupCallback, nullptr);
    XCTAssertEqual(config->numberOfDevices, 0);
    XCTAssertEqual(config->devices, nullptr);
}


bool sampleSetupCallbackHasBeenCalled = false;
//bool sampleProcessingCallbackHasBeenCalled = false;
//bool sampleStartIOCallbackHasBeenCalled = false;
//bool sampleStopIOCallbackHasBeenCalled = false;

void sampleSetupCallback() {
    sampleSetupCallbackHasBeenCalled = true;
}
//void sampleProcessingCallback() {
//    sampleSetupCallbackHasBeenCalled = true;
//}
//void sampleStartIOCallback() {
//    sampleSetupCallbackHasBeenCalled = true;
//}
//void sampleStopIOCallback() {
//    sampleSetupCallbackHasBeenCalled = true;
//}

- (void)testConfigCreationWithCallback
{
    auto config = CreatePancakeConfig(sampleSetupCallback);
    
    XCTAssertNotEqual(config->setupCallback, nullptr);
    XCTAssertEqual(config->numberOfDevices, 0);
    XCTAssertEqual(config->devices, nullptr);
    
    sampleSetupCallbackHasBeenCalled = false;
    config->setupCallback();
    XCTAssertEqual(sampleSetupCallbackHasBeenCalled, true);
}


- (void)testDeviceCreation
{
    auto config = CreatePancakeDeviceConfig(CFSTR("test manufacturer"), CFSTR("test name"), CFSTR("test uid"));
    
    XCTAssertEqual(config->manufacturer, CFSTR("test manufacturer"));
    XCTAssertEqual(config->name, CFSTR("test name"));
    XCTAssertEqual(config->UID, CFSTR("test uid"));
    XCTAssertEqual(config->processingCallback, nullptr);
    XCTAssertEqual(config->numberOfSupportedFormats, 0);
    XCTAssertEqual(config->supportedFormats, nullptr);
}


- (void)testDeviceFormatAddition
{
    auto format44100 = CreateFloat32HardwareASBD(44100, 2);
    auto format192000 = CreateFloat32HardwareASBD(192000, 16);
    auto format12345 = CreateFloat32HardwareASBD(12345, 123);

    auto device = CreatePancakeDeviceConfig(CFSTR("test manufacturer"), CFSTR("test name"), CFSTR("test uid"));
    PancakeDeviceConfigAddFormat(device, format44100);
    PancakeDeviceConfigAddFormat(device, format192000);
    PancakeDeviceConfigAddFormat(device, format12345);

    XCTAssertEqual(device->numberOfSupportedFormats, 3);
    XCTAssertNotEqual(device->supportedFormats, nullptr);
    
    XCTAssertEqual(device->supportedFormats[0].mSampleRate, 44100);
    XCTAssertEqual(device->supportedFormats[1].mSampleRate, 192000);
    XCTAssertEqual(device->supportedFormats[2].mSampleRate, 12345);
    XCTAssertEqual(device->supportedFormats[0].mChannelsPerFrame, 2);
    XCTAssertEqual(device->supportedFormats[1].mChannelsPerFrame, 16);
    XCTAssertEqual(device->supportedFormats[2].mChannelsPerFrame, 123);
}


- (void)testConfigDeviceAddition
{
    auto device1 = CreatePancakeDeviceConfig(CFSTR("test manufacturer 1"), CFSTR("test name 1"), CFSTR("test uid 1"));
    auto device2 = CreatePancakeDeviceConfig(CFSTR("test manufacturer 2"), CFSTR("test name 2"), CFSTR("test uid 2"));

    auto config = CreatePancakeConfig(NULL);
    PancakeConfigAddDevice(config, device1);
    PancakeConfigAddDevice(config, device2);

    XCTAssertEqual(config->numberOfDevices, 2);
    XCTAssertNotEqual(config->devices, nullptr);

    XCTAssertEqual(config->devices[0]->manufacturer, CFSTR("test manufacturer 1"));
    XCTAssertEqual(config->devices[0]->name, CFSTR("test name 1"));
    XCTAssertEqual(config->devices[0]->UID, CFSTR("test uid 1"));
    XCTAssertEqual(config->devices[0]->processingCallback, nullptr);
    XCTAssertEqual(config->devices[0]->startIO, nullptr);
    XCTAssertEqual(config->devices[0]->stopIO, nullptr);
    XCTAssertEqual(config->devices[0]->numberOfSupportedFormats, 0);
    XCTAssertEqual(config->devices[0]->supportedFormats, nullptr);

    XCTAssertEqual(config->devices[1]->manufacturer, CFSTR("test manufacturer 2"));
    XCTAssertEqual(config->devices[1]->name, CFSTR("test name 2"));
    XCTAssertEqual(config->devices[1]->UID, CFSTR("test uid 2"));
    XCTAssertEqual(config->devices[1]->processingCallback, nullptr);
    XCTAssertEqual(config->devices[1]->startIO, nullptr);
    XCTAssertEqual(config->devices[1]->stopIO, nullptr);
    XCTAssertEqual(config->devices[1]->numberOfSupportedFormats, 0);
    XCTAssertEqual(config->devices[1]->supportedFormats, nullptr);
}

- (void)testFullConfig
{
    // Create formats
    auto format44100 = CreateFloat32HardwareASBD(44100, 2);
    auto format192000 = CreateFloat32HardwareASBD(192000, 16);
    auto format32000 = CreateFloat32HardwareASBD(32000, 1);
    auto format12345 = CreateFloat32HardwareASBD(12345, 123);

    // Create devices
    auto device0 = CreatePancakeDeviceConfig(CFSTR("test manufacturer 1"), CFSTR("test name 1"), CFSTR("test uid 1"));
    auto device1 = CreatePancakeDeviceConfig(CFSTR("test manufacturer 2"), CFSTR("test name 2"), CFSTR("test uid 2"));
    
    // Add formats to devices
    PancakeDeviceConfigAddFormat(device0, format44100);
    PancakeDeviceConfigAddFormat(device0, format192000);
    PancakeDeviceConfigAddFormat(device1, format32000);
    PancakeDeviceConfigAddFormat(device1, format12345);

    // Create Pancake config
    auto config = CreatePancakeConfig(sampleSetupCallback);
    PancakeConfigAddDevice(config, device0);
    PancakeConfigAddDevice(config, device1);
    
    // Verify device existence
    XCTAssertEqual(config->numberOfDevices, 2);
    XCTAssertNotEqual(config->devices, nullptr);
    
    // Verify device metadata
    XCTAssertEqual(config->devices[0]->manufacturer, CFSTR("test manufacturer 1"));
    XCTAssertEqual(config->devices[0]->name, CFSTR("test name 1"));
    XCTAssertEqual(config->devices[0]->UID, CFSTR("test uid 1"));
    XCTAssertEqual(config->devices[1]->manufacturer, CFSTR("test manufacturer 2"));
    XCTAssertEqual(config->devices[1]->name, CFSTR("test name 2"));
    XCTAssertEqual(config->devices[1]->UID, CFSTR("test uid 2"));

    // Verify format existence
    XCTAssertEqual(config->devices[0]->numberOfSupportedFormats, 2);
    XCTAssertNotEqual(config->devices[0]->supportedFormats, nullptr);
    XCTAssertEqual(config->devices[1]->numberOfSupportedFormats, 2);
    XCTAssertNotEqual(config->devices[1]->supportedFormats, nullptr);

    // Verify device callbacks
    // TODO: Test callbacks
//    XCTAssertEqual(config->devices[0]->processingCallback, nullptr);
//    XCTAssertEqual(config->devices[0]->startIO, nullptr);
//    XCTAssertEqual(config->devices[0]->stopIO, nullptr);
//    XCTAssertEqual(config->devices[1]->processingCallback, nullptr);
//    XCTAssertEqual(config->devices[1]->startIO, nullptr);
//    XCTAssertEqual(config->devices[1]->stopIO, nullptr);

    
    // Verify format details
    XCTAssertEqual(config->devices[0]->supportedFormats[0].mSampleRate, 44100);
    XCTAssertEqual(config->devices[0]->supportedFormats[1].mSampleRate, 192000);
    XCTAssertEqual(config->devices[1]->supportedFormats[0].mSampleRate, 32000);
    XCTAssertEqual(config->devices[1]->supportedFormats[1].mSampleRate, 12345);
    XCTAssertEqual(config->devices[0]->supportedFormats[0].mChannelsPerFrame, 2);
    XCTAssertEqual(config->devices[0]->supportedFormats[1].mChannelsPerFrame, 16);
    XCTAssertEqual(config->devices[1]->supportedFormats[0].mChannelsPerFrame, 1);
    XCTAssertEqual(config->devices[1]->supportedFormats[1].mChannelsPerFrame, 123);

    // Release device & verify
    ReleasePancakeDeviceConfig(&device0);
    XCTAssertEqual(device0, nullptr);
    XCTAssertNotEqual(config->devices[0], nullptr);
    XCTAssertNotEqual(config->devices[1], nullptr);

    // Release config & verify
    ReleasePancakeConfig(&config);
    XCTAssertEqual(config, nullptr);
}


@end
