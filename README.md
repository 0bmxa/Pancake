<span style="font-size:120px;float:right">🥞</span>
![CircleCI](https://circleci.com/gh/0bmxa/Pancake/tree/master.svg?style=shield&circle-token=f543de04157d4183d9d436163cfbb30fe88373da)


# Pancake

Pancake is a framework for writing macOS AudioServer (`coreaudiod`) plug-ins
for realtime audio processing in the system audio output path.

It is written in Swift and provides highly simplified* Swift and C APIs for
setting up your own systemwide audio processing solution.

<small>&#42;in comparison to Apple's audio server plugin API</small>


## Getting Started

Clone the project and check out the sample driver.
The usage of the framework is as simple as the following 4 steps:
```c
// Configure a virtual device
CFStringRef manufacturer, name, UID = ...;
PancakeDeviceConfiguration *device = CreatePancakeDeviceConfig(manufacturer, name, UID);

// Add a supported audio format
AudioStreamBasicDescription supportedFormat = ...;
PancakeDeviceConfigAddFormat(device, supportedFormat);

// Create a pancake config & add the device
PancakeConfiguration *config = CreatePancakeConfig(NULL);
PancakeConfigAddDevice(config, device);

// Setup Pancake with the config
PancakeSetupSharedInstance(config);
```


### Prerequisites

The project heavily uses Swift 4, so an up-to-date Swift toolchain is required.
It also includes some C (and Objective C) parts, so also `clang` is required.
The easiest way to get all of this at once is by installing [the latest Xcode](https://itunes.apple.com/app/xcode/id497799835)
from the Mac App Store.
```shell
mas install 497799835
```

The project also uses Google's [`cpplint`](https://github.com/google/styleguide/tree/gh-pages/cpplint) and
Realm's [`SwiftLint`](https://github.com/realm/SwiftLint/) for linting, so make
sure you have both of them installed and in your `PATH`
```shell
# Install SwiftLint via homebrew
brew install swiftlint

# Manually download cpplint.py to a dir of your choice & make it executable
curl 'https://raw.githubusercontent.com/google/styleguide/gh-pages/cpplint/cpplint.py' \
    -o '/usr/local/bin/cpplint.py'
chmod +x '/usr/local/bin/cpplint.py'
```


### Installing

The projects creates an audio server plugin (`.driver` bundle), which has to be
placed in `/Library/Audio/Plug-Ins/HAL/` for the audio server being able to find
and load it. When building the project via Xcode, the plugin is automatically
copied to this directory.

For Xcode being able to write to `/Library/Audio/Plug-Ins/HAL/`, the directory
needs to be writable by the current user. The repo includes an AppleScript file
`CheckAndFixInstallPermissions.scpt` which attempts to check and fix this for
you.

Alternatively you can just manually run:
```shell
sudo chmod o+w /Library/Audio/Plug-Ins/HAL/
```

**Please note that making a system directory writeable might cause a security
risk!**

If you don't want to change permissions on the directory, you can also copy the
build product manually to `/Library/Audio/Plug-Ins/HAL/`--this, however, makes
debugging a lot harder.


### Running && Debugging

For the plugin to be loaded by the audio server, the audio server (`coreaudiod`)
has to be restarted. This can be triggered by just killing coreaudiod, or by
gracefully restarting the launchd job:

```shell
sudo launchctl unload /System/Library/LaunchDaemons/com.apple.audio.coreaudiod.plist
sudo launchctl load /System/Library/LaunchDaemons/com.apple.audio.coreaudiod.plist
```

As on restart of the audio server, all audio client connections will be
terminated, you might want to restart some system components as well, like
```shell
killall SystemUIServer # The menu bar
killall ControlStrip   # The MBP TouchBar, if you have one
```

<!--
## Running the tests

### Break down into end to end tests
Explain what these tests test and why
```
Give an example
```

### And coding style tests
Explain what these tests test and why
```
Give an example
```

## Contributing
Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of
conduct, and the process for submitting pull requests to us.
-->

## How it works

Pancake consists of three components:
1. An audio server plugin
2. An audio routing helper (background) app
3. A settings app

The audio server plugin creates a virtual audio device, which provides an audio
output to the system, just like any regular audio output (like Headphones,
AirPlay, BT, etc.). Any audio that is sent to this output is processed by a
(custom providable) processing callback and routed back to the system on a
virtual audio input.

To make the processing transparent to the user, those inputs & outputs can be
hidden from the UI. In this case the audio routing helper overwrites the system
output in the background to the (hidden) virtual one, and also routes the
virtual input to the actual, user-selected audio output.

As both, the plugin and the helper, are not visible to the user, the settings
app provides an interface to the user, where they can change parameters, which
are forwarded to the plugin and/or helper.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available,
see the [tags on this repository](https://github.com/0bmxa/Pancake/tags).

## Authors

* **Max Heim** – _wrote his master thesis about the audio HAL and created the
first version of this framework._

See also the list of [contributors](https://github.com/0bmxa/Pancake/contributors) who participated in this project.

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone who's code was used
* Inspiration
* etc
