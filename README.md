# About

Hello guys, this is example project how to migrating to *Bazel* with iOS application. If you want to know how it works and how to develop, please check the [article](https://flare.build/migration-guides/ios-hearts-bazel)

## Requirements

To build and test the project you need the following dependencies:
- Xcode 13.3 (or higher)
- Bazel 5.0.0
- Carthage 0.38.0

If you want to generate the Xcode project, you will need to install [Tulsi](https://github.com/bazelbuild/tulsi). You will need to setup the environment with carthage before build any target. I've built a script to automatizate this: 

> $ make setup

## Usage

Add another third-party
> git submodule add https://github.com/Alamofire/Alamofire third-part/Alamofire/Sources

To build the iOS app and generate an IPA file you will run:

> $ make build

If you want to test all targets on project run the following:

> $ make test

To run the app on simulator from terminal you could exec:

> $ make run

### Xcode project generation

To generate the xcode project from terminal you need to run:
> $ make project

This command generate a project on `Develop` environment, if you want to change it, you could run: 

> $ build-system/tulsigen build-system/tulsi/AppBazel.tulsiproj Production

## Advanced usage 

If you want to build a release version with `Production` envinronment you need pass the following options:

> $ tools/bazelw build //App:MyApp --config release --define envinronment=production

Maybe you need to config the `ios_signing_cert_name` on `.bazelrc`, and specify the `provisioning_profile` to handle the signing of the IPA file.